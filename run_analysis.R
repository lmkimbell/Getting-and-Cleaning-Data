## Getting Data Project

## 1. Merges the training and the test sets to create one data set.
mergeData <- rbind(read.table("./train/X_train.txt"), read.table("./test/X_test.txt"))
mergeLabel <- rbind((read.table("./train/y_train.txt")), (read.table("./test/y_test.txt")))
mergeSubject <- rbind(read.table("./train/subject_train.txt"), read.table("./test/subject_test.txt"))

## 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
MeanStdData <- mergeData[,meanStdIndices]
rm(mergeData)

## 3.  Uses descriptive activity names to name the activities in the data set
activity <- read.table("./activity_labels.txt")
## Standardize and Clean Activity
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[mergeLabel[, 1], 2]
mergeLabel[, 1] <- activityLabel

## 4.  Appropriately labels the data set with descriptive variable names. 

names(MeanStdData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(MeanStdData) <- gsub("mean", "Mean", names(MeanStdData)) # Standardize Heading by capitalize M
names(MeanStdData) <- gsub("std", "Std", names(MeanStdData)) # Standardize Heading by capitalize S
names(MeanStdData) <- gsub("-", "", names(MeanStdData)) # remove "-" in column names 
names(mergeLabel) <- "Activity"
names(mergeSubject) <- "Subject"
rm(features, activityLabel, meanStdIndices)
cleanedData <- cbind(mergeSubject, mergeLabel, MeanStdData)
dim(cleanedData) # 10299*68
##setwd(OrigDir)
write.table(cleanedData, "cleaned_data.txt") # write out the 1st dataset

## 5.  From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject.

cleanedGroup <- cleanedData %>% 
   group_by(Activity,Subject) %>% 
   summarize_each(funs(mean))

write.table(cleanedGroup, "Summary_Data_Means.txt", row.names = FALSE) # write out the 2nd dataset