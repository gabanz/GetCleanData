# Getting and Cleaning Data

#Purpose/Goals

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

## Course Project

You should create one R script called run_analysis.R that does the following. 

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data Set

The data set "Human Activity Recognition Using Smartphones" has been taken from [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## How-To

`CodeBook.md` : Describes the variables, the data, and the work that has been performed to clean up the data.

`run_analysis.R` : The script that is used for this work. It can be loaded in R/Rstudio and executed without any parameters.

`data` : The directory used to download the Data Set.

`UCI HAR Dataset` : The Data Set will be extracted to this directory.

`tidydata.txt` : The output result of the execution of `run_analysis.R`. The created file stores the data (mean and standard deviation of each measurement per activity & subject).