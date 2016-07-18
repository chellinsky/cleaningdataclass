library(dplyr)

# Begin by downloading the datasets
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "project-datasets.zip")

# Unzip the datasets into a data directory
unzip("project-datasets.zip", exdir = "data")


###  STEP 1 - Merge training and test sets ###

# Read test data files
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")

# Merge test data frames
test_df <- cbind(subject_test, y_test, x_test)

# Read train data files
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")

# Merge train data frames
train_df <- cbind(subject_train, y_train, x_train)

# Merge test and train data frames
full_df <- rbind(test_df, train_df)

###  STEPS 2 and 4 - Extract measurements on mean and sd for each measurement
# Let's add names to the full_df to make this easier--this is step 4 of the assignment
feature_names <- read.table("data/UCI HAR Dataset/features.txt")
names(full_df) <- c("Subject", "Activity", as.character(feature_names[[2]]))

# Create a df with the first two columns and others that contain "mean()" or "std()" in the name
tidy_df <- full_df[, sort(c(1, 2, grep("mean\\(\\)", names(full_df)), grep("std\\(\\)", names(full_df))))]

###  STEP 3 - Name the activities
# Create a list of the activities
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")

# Update the data fram with a factor variable labeled correctly
tidy_df$Activity <- factor(tidy_df$Activity, labels = activities[, 2])

###  STEP 5 - Creating a data frame with the average for each variable for each activity and each subject
# Create the gropued-by data frame
newtidy_df <- group_by(tidy_df, Subject, Activity)

# Summarize each column
finaltidy_df <- summarize_each(newtidy_df, funs(mean))

# Write the final data frame to a file
write.table(finaltidy_df, "finaltidydf.txt")