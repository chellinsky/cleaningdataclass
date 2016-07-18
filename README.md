# Course Project for Cleaning Data

This repository contains a script (run_analysis.R) that creates a tidy data set of 
wearable computing data.  More details can be found in the "README.txt" file in the
data/UCI HAR Dataset folder.

# Codebook

For the changes to the original dataset contained in the final tidy data set (found
in finaltidydf.txt), a codebook exists in CodeBook.md listing the variables.

# Tidy Dataset Steps

Several steps were used to create the tidy dataset:

1. Merge training and test sets
2. Extract measurements on mean and sd for each measurement
3. Name the activities
4. Create a data frame with the average for each variable for each activity and each subject
5. Write the final data frame to a file