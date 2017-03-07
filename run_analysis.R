##Getting and Cleaning Data Course Project Week 4 Course Project

## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Step 0: Load all required packages
library(reshape2)


##Step 1: Merges the training and the test sets to create one data set.

#Load the Data into R
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")

#Assigne column names to subject files
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

#Assigne column names to measurements (based on feature.txt)
features <- read.table("features.txt")
names(X_train) <- features$V2
names(X_test) <- features$V2

#Assigne column name to labels 
names(y_train) <- "activities"
names(y_test) <- "activities"

#Combine the files and create "complete" dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
complete <- rbind(train, test)


##Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

#Search above complete dataset for columns containng "mean()" or "std()"
meanstdcols <- grepl("mean\\(\\)", names(complete)) |
  grepl("std\\(\\)", names(complete))

#keep  subjectID and activity columns!
meanstdcols[1:2] <- TRUE

#remove unnecessary columns and reassigne "complete" to updated dataset
complete <- complete[, meanstdcols]


##Step 3: Use descriptive activity names to name the activities in the data set
## and
##Step 4: Appropriately label the data set with descriptive activity names.

#convert activities column from integer to factor, labels taken from "activitiy_labels.txt"
complete$activities <- factor(complete$activities, labels=c("Walking",
                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))


##Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#this is where the reshape2 package comes into play
# -> melt() reshapes wide-format data into long-format data
reshaped <- melt(complete, id=c("subjectID","activities"))

#create tidy dataset, dcast(data, id1 + id2 ~ measured variable, values in this case mean)
tidy <- dcast(reshaped, subjectID+activities ~ variable, mean)

# write the tidy data set to a file as instructed
write.csv(tidy, "tidy.csv", row.names=FALSE)

