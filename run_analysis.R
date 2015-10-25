library(dplyr)
library(tidyr)
library(reshape2)


activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

test <- read.table("./UCI HAR Dataset/test/x_test.txt")
names(test) <- features[,2]
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

train <- read.table("./UCI HAR Dataset/train/x_train.txt")
names(train) <- features[,2]
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## x - variables with Observation
## y - activity
## subject - devices
## features - descriptive names of the variables
## activity labels - descriptive names for activities

relFeatures <- grep("mean|std", features[,2])
relFeatures.Names <- features[relFeatures,2]

## 2 extract only mean and standard deviation meausrements
test  <- test[,relFeatures]
train <- train[,relFeatures]

test <- cbind(testSubject,testActivity,test)
train <- cbind(trainSubject,trainActivity,train)

## 1 mearge training and test data set
all_data <- rbind(test,train)

## remove variables not needed any more
rm(testActivity,trainActivity)
rm(testSubject,trainSubject)
rm(test,train)

## 4 change to descriptive variable names
colnames(all_data) <- c("subject","activity",relFeatures.Names)



## 3 change to desactiptive activity names
all_data$activity <- factor(all_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
all_data$subject <- as.factor(all_data$subject)

## 5 get average of each variable for each subject and activity
all_data.melted <- melt(all_data, id = c("subject", "activity"))
all_data.mean <- dcast(all_data.melted, subject + activity ~ variable, mean)

## remove variables not required
rm(test,train)
rm(features)
rm(activity_labels)
rm(all_data)
rm(all_data.melted)
rm(relFeatures,relFeatures.Names)

## write to txt file
write.table(all_data.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)

