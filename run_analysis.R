# Getting and Cleaning Data | Peer Assessment

# Load libraries
library(reshape2)

# Download Data
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, "projectfiles.zip", method="curl")

unzip("projectfiles.zip")

# Load datasets

x_test <- read.table(file="UCI HAR Dataset//test//X_test.txt")
y_test <- read.table(file="UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file="UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table(file="UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file="UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file="UCI HAR Dataset/train/subject_train.txt")

# load descriptive names
activity.labels <- read.table(file="UCI HAR Dataset/activity_labels.txt")
reading.labels <- read.table(file="UCI Har Dataset/features.txt")

# grab mean and std
mean.std <- grep("mean\\(\\)|std\\(\\)", reading.labels$V2)

# 1. Merges the training and the test sets to create one data set.

# build test
test.raw <- x_test
names(test.raw) <- reading.labels[,2]
test.mean.std <- test.raw[,mean.std]
names(subject_test) <- "subject"
names(y_test) <- "activity"
test.labels <- data.frame(type="test",subject_test,y_test)
test.labels$activity.name <- activity.labels[test.labels$activity,][[2]]
test.combined <- data.frame(test.labels,test.mean.std)
test.melt <- melt(test.combined, id=c("type", "subject", "activity", "activity.name"))

# build train
train.raw <- x_train
names(train.raw) <- reading.labels[,2]
train.mean.std <- train.raw[,mean.std]
names(subject_train) <- "subject"
names(y_train) <- "activity"
train.labels <- data.frame(type="train",subject_train,y_train)
train.labels$activity.name <- activity.labels[train.labels$activity,][[2]]
train.combined <- data.frame(train.labels,train.mean.std)
train.melt <- melt(train.combined, id=c("type", "subject", "activity", "activity.name"))

# combine
dataset <- rbind(test.melt,train.melt)

# Use descriptive activity names to name the activities in the data set
names(dataset) <- c("type","subject","activity.code","activity.name","variable","value")

# drop unneeded vars
rm(test.raw)
rm(test.melt)
rm(test.labels)
rm(test.mean.std)
rm(train.raw)
rm(train.melt)
rm(train.labels)
rm(train.mean.std)
rm(x_test)
rm(x_train)
rm(y_test)
rm(y_train)

# Assignment 1 - Export tidy dataset
write.csv(dataset, file = "tidy_dataset.csv")

# Create second, independent tidy data set with the average of each variable for each activity and each subject.
second_dataset <- dcast(dataset,activity.name + subject + variable ~., mean)
names(second_dataset) <- c("activity.name","subject","variable","value")



