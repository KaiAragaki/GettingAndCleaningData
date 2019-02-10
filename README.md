# GettingAndCleaningData
Scripts and Documents for the Getting and Cleaning Data Project

## Scripts
This repository contains only one script, run_analysis.R.
This script downloads the UCI HAR Dataset, merges the training and testing dataframes together, extracts variables pertaining to standard 
deviation and mean calculation, and then takes the mean of those variables - by grouping both by the subject and the activity done by the 
subjects.
