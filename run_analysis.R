
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

###  STEP 2 - Extract measurements on mean and sd for each measurement
# Using features.txt, we know which columns contain means and sds:
#   1-6, 41-46, 81-86, 121-126, 161-166, 201-202, 214-215, 227-228, 240-241
#   253-254, 266-271, 345-350, 424-429, 503-504, 516-517, 529-530, 542-543
# Note that each fo these is off by 2 in the full_df data frame

# Let's add names to the full_df to make this easier
feature_names <- read.table("data/UCI HAR Dataset/features.txt")
names(full_df) <- c("Subject", "Activity", as.character(feature_names[[2]]))

# Create a df with the first two columns and others that contain "mean()" or "std()" in the name
tidy_df <- full_df[, sort(c(1, 2, grep("mean\\(\\)", names(full_df)), grep("std\\(\\)", names(full_df))))]

