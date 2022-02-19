## Original Dataset

1. The original dataset are downloaded and unzipped to the folder `UCI HAR Dataset`
2. A detailed `README.txt` in the folder describes the original dataset

## Data Modification

1. Merging the training and the test sets to create one data set
    - `X`: 10299 obs of 561 variables
    - `Y`: 10299 obs of 1 variable
    - `subject`: 10299 obs of 1 variable
3. Extracting only the measurements on the mean and standard deviation for each measurement
4. Using descriptive activity names to name the activities in the data set
5. Appropriately labeling the data set with descriptive variable names
    - all the abbreviated column names are revised as the corresponding measured activities
    - `Acc` -> Accelerometer
    - `Gyro` -> Gyroscope
    - `BodyBody` -> Body
    - `Mag` -> Magnitude
    - names with `f` -> Frequency
    - names with `t` -> Time
6. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

## Modified Dataset

- Identifiers: the first 2 columns (`subject` and `activity`)
- Measurements: the remaining 86 columns (mean and standard deviation values of each variables for each activity and each subject)
- the `features.txt` file in the original dataset includes the descriptions of all original variables
