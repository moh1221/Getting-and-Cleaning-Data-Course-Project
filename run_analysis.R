#load reshape2 library
library(reshape2)

#Remove all objects from Global Enviroment
rm(list = ls())

#Download and unzip files
zipfile <- "getdata_dataset.zip"
filename <- "UCI HAR Dataset"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(zipfile)) {
  download.file(fileUrl, zipfile, method = "curl")
}
if(!file.exists(filename)){
unzip(zipfile)
}

#set working directory
setwd(filename)

#Load Labels 
activity <- read.table("activity_labels.txt")
feature <- read.table("features.txt")

#Load test Data sets
SubjectTest <- read.table("test/subject_test.txt")
TestX <- read.table("test/X_test.txt")
TestY <- read.table("test/y_test.txt")

#Load training data sets
SubjectTraining <- read.table("train/subject_train.txt")
TrainingX <- read.table("train/X_train.txt")
TrainingY <- read.table("train/y_train.txt")

#Combined two data set @ X, Y and Subject
allDS_X <- rbind(TestX, TrainingX)
allDS_Y <- rbind(TestY, TrainingY)
allDS_Subject <- rbind(SubjectTest, SubjectTraining)

#filter feature on mean and std @ allDS_X
featureFilter <- grep("-(mean|std)\\(\\)", feature[,2])
allDS_X <- allDS_X[,featureFilter]
colnames(allDS_X) <- feature[featureFilter, 2]

#update activity ID with activity name in data set allDS_Y
allDS_Y[,1] <- activity[allDS_Y[,1],2]
colnames(allDS_Y) <- c("Activity")

#Label Subject data set
colnames(allDS_Subject) <- c("Subject")

#combined data sets
allDS <- cbind(allDS_Subject, allDS_Y, allDS_X)

#Create tidy data set with the average of each variable for each activity and each subject
allDS_Melt <- melt(allDS, id = c("Subject","Activity"))
allDS_mean <- dcast(allDS_Melt, Subject + Activity ~ variable, mean)

#write output to txt filte without rownames
write.table(allDS_mean, file = "tidy.txt", row.names = FALSE)