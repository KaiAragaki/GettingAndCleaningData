library(tidyverse) # Load tidyverse
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "zippedData") # Downloads file
unzip("zippedData") # Creates a folder called "UCI HAR Dataset"
userWD <- getwd() # Save current working directory to restore at end of script
setwd("UCI HAR Dataset")
labels <- read.delim("features.txt", header = F, sep = "") # List of variable names common to both training and test files
activityLabels <- read.delim("activity_labels.txt", header = F, sep = "") # List of Activity Labels common to both training and test files
activityLabels <- factor(activityLabels[,1], levels = activityLabels[,1], labels = activityLabels[,2])

setwd("train") # Go to train files

xTrain <- read.delim("X_train.txt", header = F, sep = "") # Read in measurement data
colnames(xTrain)<-labels[,2] # Name columns as dictated by the features.txt file
yTrain <- read.delim("y_train.txt", header = F, sep = "") # Read in Activity Numbers
subjectTrain <- read.delim("subject_train.txt", header = F, sep = "") # Read in Subject Numbers

totTrain <- cbind(yTrain, subjectTrain, xTrain, isTrain = c(T)) # Combines and adds "isTrain" attribute (to be able to differentiate after combining)

setwd("../test") # Go to test file from train directory

# The same process as above is repeated, this time with test files
xTest <- read.delim("X_test.txt", header = F, sep = "")
colnames(xTest)<-labels[,2]
yTest <- read.delim("y_test.txt", header = F, sep = "")
subjectTest <- read.delim("subject_test.txt", header = F, sep = "")
totTest <- cbind(yTest, subjectTest, xTest, isTrain = c(F))

totData <- rbind(totTrain, totTest) # Combine test and train
colnames(totData)[1:2] <- c("Activity", "Subject") # Name unnamed columns
totData[,1] <- factor(totData[,1], levels = c(1:6), labels = activityLabels)

tibbleTot <- as_tibble(totData, .name_repair = "unique") # Convert to tibble, which allows for downstream proccesing with dplyr
selectData <- select(tibbleTot, matches("mean|std|isTrain|Activity|Subject")) # Extracts only variables that match our wanted criteria and our informational variables


# Group by Subject number and Activity Number
groupedData <- group_by(selectData, Activity, Subject) %>%
  summarize_at(vars(matches("mean|std")), mean)

write.table(groupedData, file = "analysisOutput.txt", row.names = F)

setwd(userWD) # Put the user back where you found them
