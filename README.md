GACD_peerassignment
===================

Getting and Cleaning Data Coursera subject Peer assignment scripts explanation

## run_analysis.R
The run_analysis.R script creates the tidy data set and summary dataset through the following activities

1. load required libraries (reshape2)
2. Download Data and unzipping files
3. Load all datasets, including activity label files into variables
4. Subsetting the measurements to only select mean and std measurements
5. Merges the training and the test sets to create one "melted" data set.
6. Drop unneeded vars
7. Export a tidy dataset as tidy_dataset.csv
8. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

