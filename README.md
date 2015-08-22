## Getting and Cleaning data Course Project
The R Script <run_analysis.R> do the following:

1. Download project file and unzip it.
2. Load all data sets from unzipped file.
3. Merges the training and the test sets to create one data set.
4. Extracts the measurements on the mean and standard deviation for each measurement. 
5. Uses descriptive activity names to name the activities in the data set
6. Labels the data set with descriptive variable names. 
7. create tidy data set with the average of each variable for each activity and each subject and 
```
#Create tidy data set with the average of each variable for each activity and each subject
allDS_Melt <- melt(allDS, id = c("Subject","Activity"))
allDS_mean <- dcast(allDS_Melt, Subject + Activity ~ variable, mean)
```
write output to "tidy.txt".
```
#write output to txt filte without rownames
write.table(allDS_mean, file = "tidy.txt", row.names = FALSE)
```

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

