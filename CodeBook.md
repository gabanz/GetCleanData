#Code Book

## Introduction

This file describes the data, the variables, and the work that has been performed to clean up the data.

# Raw Data Set (Source)

## Description

The data set represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

The original data set is split into training and test sets where each partition consists of three files that contain
* the measurements from the accelerometer and gyroscope
* the labels for activity
* the subject identifiers

For detailed description of the original dataset, refer to README.txt and features_info.txt bundeled with the original data set zip archive.
- [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The original data set includes the following files:
* `features_info.txt`: Shows information about the variables used on the feature vector.
* 'features.txt`: List of all features.
* `activity_labels.txt`: Links the class labels with their activity name.
* `train/X_train.txt`: Training set.
* `train/y_train.txt`: Training labels.
* `test/X_test.txt`: Test set.
* `test/y_test.txt`: Test labels.
* `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

# Tidy Data

## Description

Contains aggregated mean values of all mean and standard deviation values from original data set grouped by activity  and subject, resulting in a total of 180 records.

## Attribute Information

For each record in the tidy data it is provided: 
- Its activity label (one out of 6 different activities):
  - LAYING
  - SITTING
  - STANDING
  - WALKING
  - WALKING_DOWNSTAIR
  - WALKING_UPSTAIRS
- An identifier of the subject who carried out the experiment (30 different subjects, IDs ranging from {1,2,3,...,30})
- 79 features with the
  - Mean of Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
  - Mean of Triaxial Angular velocity from the gyroscope. 
  - numerical value ranging in [-1,1]

## Variable Names
* timeBodyAccelerometer-mean()-X
* timeBodyAccelerometer-mean()-Y
* timeBodyAccelerometer-mean()-Z
* timeBodyAccelerometer-std()-X
* timeBodyAccelerometer-std()-Y
* timeBodyAccelerometer-std()-Z
* timeGravityAccelerometer-mean()-X
* timeGravityAccelerometer-mean()-Y
* timeGravityAccelerometer-mean()-Z
* timeGravityAccelerometer-std()-X
* timeGravityAccelerometer-std()-Y
* timeGravityAccelerometer-std()-Z
* timeBodyAccelerometerJerk-mean()-X
* timeBodyAccelerometerJerk-mean()-Y
* timeBodyAccelerometerJerk-mean()-Z
* timeBodyAccelerometerJerk-std()-X
* timeBodyAccelerometerJerk-std()-Y
* timeBodyAccelerometerJerk-std()-Z
* timeBodyGyroscope-mean()-X
* timeBodyGyroscope-mean()-Y
* timeBodyGyroscope-mean()-Z
* timeBodyGyroscope-std()-X
* timeBodyGyroscope-std()-Y
* timeBodyGyroscope-std()-Z
* timeBodyGyroscopeJerk-mean()-X
* timeBodyGyroscopeJerk-mean()-Y
* timeBodyGyroscopeJerk-mean()-Z
* timeBodyGyroscopeJerk-std()-X
* timeBodyGyroscopeJerk-std()-Y
* timeBodyGyroscopeJerk-std()-Z
* timeBodyAccelerometerMagnitude-mean()
* timeBodyAccelerometerMagnitude-std()
* timeGravityAccelerometerMagnitude-mean()
* timeGravityAccelerometerMagnitude-std()
* timeBodyAccelerometerJerkMagnitude-mean()
* timeBodyAccelerometerJerkMagnitude-std()
* timeBodyGyroscopeMagnitude-mean()
* timeBodyGyroscopeMagnitude-std()
* timeBodyGyroscopeJerkMagnitude-mean()
* timeBodyGyroscopeJerkMagnitude-std()
* frequencyBodyAccelerometer-mean()-X
* frequencyBodyAccelerometer-mean()-Y
* frequencyBodyAccelerometer-mean()-Z
* frequencyBodyAccelerometer-std()-X
* frequencyBodyAccelerometer-std()-Y
* frequencyBodyAccelerometer-std()-Z
* frequencyBodyAccelerometerJerk-mean()-X
* frequencyBodyAccelerometerJerk-mean()-Y
* frequencyBodyAccelerometerJerk-mean()-Z
* frequencyBodyAccelerometerJerk-std()-X
* frequencyBodyAccelerometerJerk-std()-Y
* frequencyBodyAccelerometerJerk-std()-Z
* frequencyBodyGyroscope-mean()-X
* frequencyBodyGyroscope-mean()-Y
* frequencyBodyGyroscope-mean()-Z
* frequencyBodyGyroscope-std()-X
* frequencyBodyGyroscope-std()-Y
* frequencyBodyGyroscope-std()-Z
* frequencyBodyAccelerometerMagnitude-mean()
* frequencyBodyAccelerometerMagnitude-std()
* frequencyBodyAccelerometerJerkMagnitude-mean()
* frequencyBodyAccelerometerJerkMagnitude-std()
* frequencyBodyGyroscopeMagnitude-mean()
* frequencyBodyGyroscopeMagnitude-std()
* frequencyBodyGyroscopeJerkMagnitude-mean()
* frequencyBodyGyroscopeJerkMagnitude-std()
* subject
* activity

## Work/Transformations Step List (Instructions)

### 1. Preparation.

Download and store the data set in the `./data/UCI HAR Dataset` directory.
```
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/dataset.zip")){
  download.file(fileUrl,destfile="./data/dataset.zip",method="wget")
}
```

The `unzip` function is used to extract the zip file in this directory.
```
if(!file.exists("UCI HAR Dataset")){
unzip(zipfile="./data/dataset.zip",exdir="./data")
}
datapath <- file.path("./data" , "UCI HAR Dataset")
```

For the purposes of this project, the files in the `Inertial Signals` folders are not used. The files that will be used to load data are listed as follows:
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

`read.table` is used to load into R environment the data, the activities and the subject of both test and training datasets.

```
ActivityTest  <- read.table(file.path(datapath, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(datapath, "train", "Y_train.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(datapath, "test" , "subject_test.txt"),header = FALSE)
FeaturesTest  <- read.table(file.path(datapath, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE)
```

### 2. Uses descriptive activity names to name the activities in the data set

The labels linked with their activity names are loaded from the `activity_labels.txt` file. The numbers of the `ActivityTest` and `ActivityTrain` data frames are replaced by those names:

```
ActivityLabels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)
ActivityTest$V1 <- factor(ActivityTest$V1,levels=ActivityLabels$V1,labels=ActivityLabels$V2)
ActivityTrain$V1 <- factor(ActivityTrain$V1,levels=ActivityLabels$V1,labels=ActivityLabels$V2)
```

### 3. Appropriately labels the data set with descriptive variable names. 

The `Activity` and `Subject` columns are named properly.
Each data frame of the data set is labeled with the information contained in `features.txt`.
By pattern matching and replacement, the following changes are made in the names of the variables:
- replace names that begin with the letter t, change the t to time
- replace names that begin with the letter f, change the f to frequency
- replace names with "Acc" to "Accelerometer"
- replace names with "Gyro" to "Gyroscope"
- replace names with "Mag" to "Magnitude"
- replace names with "BodyBody" to "Body"

```
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(datapath, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2
names(Features)<-gsub("^t", "time", names(Features))
names(Features)<-gsub("^f", "frequency", names(Features))
names(Features)<-gsub("Acc", "Accelerometer", names(Features))
names(Features)<-gsub("Gyro", "Gyroscope", names(Features))
names(Features)<-gsub("Mag", "Magnitude", names(Features))
names(Features)<-gsub("BodyBody", "Body", names(Features))
```

### 4. Merges the training and the test sets to create one data set.

Each train and test data tables are concatenated by rows, then merged by columns to get the data frame `dataMerged`.

```
Activity<- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features<- rbind(FeaturesTrain, FeaturesTest)
dataMerged <- cbind(Features, Subject, Activity)
```

### 5. Extract only the measurements on the mean and standard deviation for each measurement

A subset of dataMerged was created with only Features Names that includes “mean()” or “std()”

```
subFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames<-c(as.character(subFeaturesNames), "subject", "activity" )
dataMerged<-subset(dataMerged,select=selectedNames)
```

### 6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally the desired result, a `tidy` data table is created and saved as `tidydata.txt` file.

```
library(plyr);
newData<-aggregate(. ~subject + activity, dataMerged, mean)
newData<-newData[order(newData$subject,newData$activity),]
write.table(newData, file = "tidydata.txt",row.name=FALSE)
```
