##########################################################################
## Create Date: 12/17/2014                                              ##
## Author: Nick McDannald                                               ##
## Description: Getting and Cleaning Data Course Project                ##
## Downloads raw Samgsung Galaxy cellphone data and writes a tidy data  ##
## set to a txt file per the requirements of the assignment             ##
##########################################################################

## Create folder for data
if(!file.exists("celldata")) {
        dir.create("celldata")
}

## Download zip folder and extract data files to celldata folder
library(downloader) # if package not installed Run this code: install.packages("downloader")
                        
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(url,dest="./celldata/celldata.zip", mode="wb") 
unzip ("./celldata/celldata.zip",exdir = "./celldata")

#### Bring in the raw data from the "X" files. Merge them together and 
#### create a set of the mean and standard deviation data

## Read the raw files into R: X_test.txt, X_train.txt
xtest <- read.table("./celldata/UCI HAR Dataset/test/X_test.txt")
xtrain <- read.table("./celldata/UCI HAR Dataset/train/X_train.txt")

## combine xtest and xtrain data frames to one data frame. Has to go in order
## of xtest and xtrain for consistancy with the "Y" files
xframe <- rbind(xtest, xtrain)

## bring in the names for the xframe columns from features.txt to xframe
xcolnames <- read.table(".//celldata/UCI HAR Dataset/features.txt")
names(xframe) <- features[, 2]

## build a new dataframe that has only the mean and std columns from xframe
xsubset <- xframe[ , grepl("mean()|std()", names(xframe))]

#### Now get the "Y" files that label the raw data in xsubset 
#### cooresponding to the raw data

## Read the label files into R: y_test.txt, y_train.txt
ytest <- read.table("./celldata/UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("./celldata/UCI HAR Dataset/train/y_train.txt")

## combine ytest and ytrain data frames to one data frame. Note that ytest
## is first then ytrain.  This has to match this order exactly with the
## "X" files for the merge later so the data doesn't get rearranged
yframe <- rbind(ytest, ytrain)

## Read the activity file into R: activity_labels.txt
actlabels <- read.table("./celldata/UCI HAR Dataset/activity_labels.txt")

## replace the number value in yframe to the activity the number represents
yframe[,1] <- actlabels[yframe[,1], 2]

## merge Y and X sets together to combine the activity to the data readings
yxset <- cbind(yframe,xsubset)

## rename and clean up column names in yxset to make more user friendly
colnames(yxset)[1] <- "activity"
names(yxset) <- gsub("tBodyAcc", "time_body_accelerometer ", names(yxset))
names(yxset) <- gsub("tBodyGyro", "time_body_gyroscope ", names(yxset))
names(yxset) <- gsub("fBodyAcc", "frequency_body_accelerometer ", names(yxset))
names(yxset) <- gsub("fBodyBodyAcc", "frequency_body_accelerometer ", names(yxset))
names(yxset) <- gsub("fBodyBodyGyro", "frequency_body_gyroscope ", names(yxset))
names(yxset) <- gsub("fBodyGyro", "frequency_body_gyroscope ", names(yxset))
names(yxset) <- gsub("tGravityAcc", "time_gravity_accelerometer ", names(yxset))
names(yxset) <- gsub("Mag", "magnitude ", names(yxset))
names(yxset) <- gsub("Jerk", "jerk_signals ", names(yxset))
names(yxset) <- gsub("-", " ", names(yxset))
names(yxset) <- gsub("  ", " ", names(yxset))
names(yxset) <- gsub(" ", "_", names(yxset))
names(yxset) <- gsub("\\()", "", names(yxset))

#### Step 5:  second set with the average of each variable for each 
####          activity and each subject

## Read the subject files into R: subject_test.txt, subject_train.txt
stest <- read.table("./celldata/UCI HAR Dataset/test/subject_test.txt")
strain <- read.table("./celldata/UCI HAR Dataset/train/subject_train.txt")

## combine stest and strain data frames to one data frame. Note that stest
## is first then strain for consisitancy (see above rbind merges)
sframe <- rbind(stest, strain)

## merge subject to yxset together to combine the subject to activity & data
syxset <- cbind(sframe,yxset)
colnames(syxset)[1] <- "subject"

## Create dataset that averages of each variable for the subject and activity
library(plyr)  # if package not install run code: install.packages("plyr")
finalset <- ddply(syxset, c("subject", "activity"), colwise(mean))

## Write the fileset to a txt file in the UCI HAR Dataset folder
write.table(finalset, "./celldata/UCI HAR Dataset/tidydataset.txt", sep="\t", 
                                        quote=FALSE, row.names=FALSE)

