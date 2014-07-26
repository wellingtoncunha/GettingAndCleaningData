setwd("C://Users//Wellington//Desktop//DataScience//Coursera//03 Getting and Cleaning Data//Data")

##Load Train Subjects file
subject <- read.table(
    "./subject_train.txt")
colnames(subject) <- "Subject"

##Load Train Activity file
y_train <-  read.table(
    "./y_train.txt")
colnames(y_train) <- "ActivityID"

##Load Train Activity Labels file
ActivityLabel <- read.table(
    "./activity_labels.txt")
colnames(ActivityLabel) <- c("ActivityID", "ActivityDescription")

##Assign labels to Train Activities
mergedData <- merge(y_train, ActivityLabel, by.x="ActivityID", by.y="ActivityID")

##Merge Train Subjects and Train Activities
Train <- cbind(subject, mergedData[,2])
colnames(Train) <- c("Subject", "Activity.Description")
#Train$Type <- "Train"

##Load Features file
features <-  read.table(
    "./features.txt")

## Select just mean and std columns indexes
selectedColumns <- grep("mean()", features$V2)
selectedColumns <- c(selectedColumns, grep("std()", features$V2))

## Add descriptive feature names to be used as columns
features <- features[selectedColumns, ]
features$V2 <- 
    paste(
        ifelse(
            substring(features$V2, 1, 1) == "t", 
            "Time.", 
            ifelse(
                substring(features$V2, 1, 1) == "f",
                "Frequency.",
                substring(features$V2, 1, 1)
            )
        ),
        substring(features$V2, 2, 100),
        sep=""
    )

features$V2 <- gsub(")", "", features$V2)
features$V2 <- gsub("[(]", "", features$V2)
features$V2 <- gsub("[-]", ".", features$V2)
features$V2 <- gsub("std", "STD", features$V2)
features$V2 <- gsub("mean", "Mean", features$V2)

## Load training data
x_train <- read.table(
    "./X_train.txt")
x_train <- x_train[, selectedColumns]
colnames(x_train) <- features$V2

## Add Training data to Train main data table
Train <- cbind(Train, x_train)


##Load Test Subjects file from test
subject <- read.table(
    "./subject_test.txt")
colnames(subject) <- "Subject"

##Load Test Activity file
y_test <-  read.table(
    "./y_test.txt")
colnames(y_test) <- "ActivityID"

##Assign labels to Test Activities
mergedData <- merge(y_test, ActivityLabel, by.x="ActivityID", by.y="ActivityID")

##Merge Train Subjects and Train Activities
Test <- cbind(subject, mergedData[,2])
colnames(Test) <- c("Subject", "Activity.Description")
#Test$Type <- "Test"

## Load training data
x_test <- read.table(
    "./X_test.txt")
x_test <- x_test[, selectedColumns]
features$V2 <- gsub("Train", "Test", features$V2)
colnames(x_test) <- features$V2

## Add Training data to Train main data table
Test <- cbind(Test, x_test)

## Merging Train and Test data tables
RunAnalysis <- rbind(Train, Test)

## Create the dataset with Mean for each variable 
## aggregating by subject and activity
library("data.table")
RunAnalysis <- data.table(RunAnalysis)
AnalysisMean <- RunAnalysis[, lapply(.SD,mean, na.rm = TRUE), by=list(RunAnalysis$Subject, RunAnalysis$Activity.Description)]
ColumnNames <- colnames(AnalysisMean)
ColumnNames[1:2] <- c("Subject", "Activity")
setnames(AnalysisMean, ColumnNames)
AnalysisMean <- AnalysisMean[order(AnalysisMean$Subject, AnalysisMean$Activity),]

## Generate file
write.table(RunAnalysis, file = ".\\RunAnalysis.txt", row.names = FALSE)
