
## download and unzip the datasets
filename <- "Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)){
    download.file(fileURL, filename, method="curl")
}  
unzip(filename)

## read all the data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## 1. Merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
rawdata <- cbind(subject, Y, X)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

ds <- rawdata %>% select(subject, code, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set

ds$code <- activities[ds$code,2]

## 4. Appropriately labels the data set with descriptive variable names. 

names(ds)[2] = "activity"
names(ds) <- gsub("Acc", "Accelerometer", names(ds))
names(ds) <- gsub("Gyro", "Gyroscope", names(ds))
names(ds) <- gsub("BodyBody", "Body", names(ds))
names(ds) <- gsub("Mag", "Magnitude", names(ds))
names(ds) <- gsub("^t", "Time", names(ds))
names(ds) <- gsub("^f", "Frequency", names(ds))
names(ds) <- gsub("tBody", "TimeBody", names(ds))
names(ds) <- gsub("-mean()", "Mean", names(ds), ignore.case = TRUE)
names(ds) <- gsub("-std()", "STD", names(ds), ignore.case = TRUE)
names(ds) <- gsub("-freq()", "Frequency", names(ds), ignore.case = TRUE)
names(ds) <- gsub("angle", "Angle", names(ds))
names(ds) <- gsub("gravity", "Gravity", names(ds))

## 5. From the data set in step 4
## creates a second, independent tidy data set with the average of each variable for each activity and each subject.

data <- ds %>% group_by(subject, activity) %>% summarize_all(list(mean))
write.table(data, "tidy_dataset.txt", row.name=FALSE)