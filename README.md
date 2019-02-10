# GettingAndCleaningData
Scripts and Documents for the Getting and Cleaning Data Project

## Scripts
This repository contains only one script, run_analysis.R.
* This script requires tidyverse
The script first saves the users current working directory to be able to return to it at the end of the script.

This script then downloads the dataset (from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) and unzips it.

Labels describing variables are read in, followed by labels of activity performed (see 'activityLabels' in the codebook for a list of activities performed)

The training and test datasets, individually, are first merged with their subjects and activities, each corresponding to a particular row, as well as their variable names. They are then merged vertically together, with the addition of attribute "isTrain" to signal the origin of the dataset (prevent loss of data upon merging)

This merged dataset is converted into a tibble to allow for further downstream processing with dplyr. The .name_repair method of as_tibble is used to provide duplicate variable names with unique variable names.

Variable names containing the character string "mean" or "std" are selected from the dataset, including ID columns like "isTrain", "Activity" and "Subject".

This filtered dataset then bifurcates and is grouped by either Activity or Subject, then the mean of each column containing "mean" or "std" is taken as a summary. The results are merged back together in the variable 'meanData', which is then written to a .txt file called "analysisOutput.txt".

Finally, the user's original working directory is restored.
