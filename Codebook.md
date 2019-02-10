# Codebook
All data used in this analysis is from the UCI HAR Dataset. Further documentation can be found [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)
run_analysis.R produces several variables. They are described below in order of appearance

## userWD
Stores the user's current working directory so as to be able to restore it at the end of the session

## labels
List of variable names associated with measurement columns (See xTrain). The first column includes column number, the second includes column name

## activityLabels
Labels provided by the UCI HAR Dataset. They will be used downstream to convert numeric activity labels to descriptive activity labels, with the following Key:Value pairs:
1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

## xTrain
Training measurements made by the UCI HAR Lab. 

## yTrain
Activity numbers associated with the training dataset measurement. These numbers correspond with the labels in activityLabels (see activityLabels)

## subjectTrain
Subject numbers associated with he training dataset measurements. These do not have descriptive labels associated with them.

## totTrain
Horizontal combination of yTrain, subjectTrain, xTrain, and a new variable "isTrain" - which specifies whether it came from the training dataset or the testing dataset

## xTest, yTest, subjectTest, totTest
Similar to their training cognates, except from the testing dataset produced by UCI HAR

## totData
Vertical combination of totTrain and totTest, with the numerical activity labels replace with descriptive activity labels

## tibbleTot
totData coerced into a tibble, using a .name_repair method to handle duplicate names (which cannot be handled by dplyr)

## selectData
Subset of tibbleTot. Particular rows of data whose column names contain either "mean", "std", "isTrain", "Activity", or "Subject".

## groupedSelectSubject
selectData, grouped by subject number, then summarized by the mean of columns containing either "mean" or "std"

## groupedSelectActivity
selectData, grouped by activity, then summarized by the mean of columns containing either "mean" or "std"

## meanData
Vertical combination of groupedSelectSubject and groupedSelectActivity
