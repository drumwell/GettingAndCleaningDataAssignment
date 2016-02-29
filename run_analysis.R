# load dplyr 
library(dplyr)

### Some setup ###
# load the feature names
feature_names <- read.table("./UCI HAR Dataset/features.txt", col.names = c("id", "name"))
# load the activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id", "name"))

## 1. Merges the training and the test sets to create one data set.

# load all of the test data
test_features <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = feature_names$name)
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
test_activities <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))

# merge test data into a single data frame
test_data <- mutate(test_features, subject = test_subjects$subject, activity = test_activities$activity)

# load all of the training data
train_features <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = feature_names$name)
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
train_activities <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))

# merge training data into a single data frame
train_data <- mutate(train_features, subject = train_subjects$subject, activity = train_activities$activity)

# merge test_data and train_data into one data set
merged_data <- merge(test_data, train_data, all = TRUE)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# column names containing only "mean" and "std"
extracted_data <- select(merged_data, subject, activity, contains(".mean."), contains(".std."))

## 3. Uses descriptive activity names to name the activities in the data set
extracted_data <- mutate(extracted_data, activity=activities$name[activity])

## 4. Appropriately labels the data set with descriptive variable names.

## from lesson 4, names of variables should be
## - all lower case
## - descriptive (diagnosis vs dx)
## - not duplicated
## - not have underscores, dots or whitespaces

# make the names lower case
variables <- tolower(colnames(extracted_data))

# replace dots
variables <- gsub("\\.", "", variables)

# make them a little more descriptive (without spelling out every word and becoming unweildy)
variables <- sub("tbody", "timebody", variables)
variables <- sub("fbody", "freqbody", variables)
variables <- sub("tgravity", "timegravity", variables)
colnames(extracted_data) <- variables

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averaged_data <- extracted_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

## write out the two data sets to disk
extracted_data_filename <- "./extracted_data.txt"
if(file.exists(extracted_data_filename)) file.remove(extracted_data_filename)
write.table(extracted_data, file = extracted_data_filename, row.names = FALSE)

averaged_data_filename <- "./averaged_data.txt"
if(file.exists(averaged_data_filename)) file.remove(averaged_data_filename)
write.table(averaged_data, file = averaged_data_filename, row.names = FALSE)



