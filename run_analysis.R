# Downloads the dataset and unzip into data directory.

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/dataset.zip")){
  download.file(fileUrl,destfile="./data/dataset.zip",method="wget")
}
if(!file.exists("UCI HAR Dataset")){
unzip(zipfile="./data/dataset.zip",exdir="./data")
}

# Read the necessary data

datapath <- file.path("./data" , "UCI HAR Dataset")

ActivityTest  <- read.table(file.path(datapath, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(datapath, "train", "Y_train.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(datapath, "test" , "subject_test.txt"),header = FALSE)
FeaturesTest  <- read.table(file.path(datapath, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE)

# Uses descriptive activity names to name the activities in the data set

ActivityLabels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)
ActivityTest$V1 <- factor(ActivityTest$V1,levels=ActivityLabels$V1,labels=ActivityLabels$V2)
ActivityTrain$V1 <- factor(ActivityTrain$V1,levels=ActivityLabels$V1,labels=ActivityLabels$V2)

# Merges the training and the test sets to create one data set.

names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(datapath, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

Activity<- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features<- rbind(FeaturesTrain, FeaturesTest)
dataMerged <- cbind(Features, Subject, Activity)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

subFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames<-c(as.character(subFeaturesNames), "subject", "activity" )
dataMerged<-subset(dataMerged,select=selectedNames)

# Appropriately labels the data set with descriptive variable names

names(dataMerged)<-gsub("^t", "time", names(dataMerged))
names(dataMerged)<-gsub("^f", "frequency", names(dataMerged))
names(dataMerged)<-gsub("Acc", "Accelerometer", names(dataMerged))
names(dataMerged)<-gsub("Gyro", "Gyroscope", names(dataMerged))
names(dataMerged)<-gsub("Mag", "Magnitude", names(dataMerged))
names(dataMerged)<-gsub("BodyBody", "Body", names(dataMerged))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr);
newData<-aggregate(. ~subject + activity, dataMerged, mean)
newData<-newData[order(newData$subject,newData$activity),]
write.table(newData, file = "tidydata.txt",row.name=FALSE)

