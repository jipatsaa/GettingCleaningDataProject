### Project Introduction

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Project Assignment

Create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.


### RScript run_analysis.R Documentation

Downloads raw Samgsung Galaxy cellphone data and writes a tidy data set to a txt file per the requirements of the assignment.

### What run_analysis.R Does

1) Creates folder for data called "celldata" in the computer's working directory
2) Downloads zip folder and extract data files to celldata folder
3) Bring in the raw data from the "X" files. Merge them together and 
4) Create a set of the mean and standard deviation data
5) Combine test and train data frames to one data frame. 
6) Bring in the names for the xframe columns from features.txt to xframe
7) Build a new dataframe that has only the mean and std columns from xframe
8) Adds the label data to the raw data
9) Rename and clean up column names to make more user friendly
10) Adds the Subject data to the data table
11) Create dataset that averages of each variable for the subject and activity
12) Write the fileset to a txt file called tidydataset.txt in the UCI HAR Dataset folder

### What you need to do to create the tidydataset file

1) Install the following R Packages if needed:
	downloader - This package will download and unzip the raw data
	plyr - This package will be used for averaging each variable for each activity and subject
2) Execute run_analysis.R

You can then find tidydataset.txt in the \celldata\UCI HAR Dataset\ directory
	

