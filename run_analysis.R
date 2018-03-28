#clear the environment
rm(list = ls(all =T))

#set the working directory
setwd(paste0("C:/Users/bhargavab250/Documents/Kolkata/Coursera/Data",
             " Science Specialisation/Getting and Cleaning Data/project"))

##Read the required files: Activity labels and features, Training set files,
##and Testing set files

#read activity_labels, features
ActivityLabels <- read.delim(file = "./UCI HAR Dataset/activity_labels.txt", 
                              header = F, sep = "")
Features <- read.delim(file = "./UCI HAR Dataset/features.txt", 
                       header = F, sep = "")

#read training set files: X_train, y_train, subject_train
Train <- read.delim(file = "./UCI HAR Dataset/train/X_train.txt",
                    header = F, sep = "")
TrainActivity <- read.delim(file = "./UCI HAR Dataset/train/y_train.txt",
                             header = F, sep = "")
TrainSubjects <- read.delim(file = "./UCI HAR Dataset/train/subject_train.txt",
                             header = F, sep = "")

#read test set files: X_test, y_test, subject_test
Test <- read.delim(file = "./UCI HAR Dataset/test/X_test.txt",
                   header = F, sep = "")
TestActivity <- read.delim(file = "./UCI HAR Dataset/test/y_test.txt",
                            header = F, sep = "")
TestSubjects <- read.delim(file = "./UCI HAR Dataset/test/subject_test.txt",
                            header = F, sep = "")

##Create consolidated training and testing sets with 'subject' and 'activity'
##information, and label the columns

#change the column names of the train and test dataframe for the 561 columns
colnames(Train) <- Features$V2
colnames(Test) <- Features$V2

#Add the activity and subject columns to the respective dataframes
Train$Activity <- TrainActivity$V1
Train$Subject <- TrainSubjects$V1

Test$Activity <- TestActivity$V1
Test$Subject <- TestSubjects$V1

##Merge the training and testing data sets
MasterData <- rbind(Train,Test)

##Extract measurements on the mean and standard deviation. Names of the columns
##with mean & standard deviation values contain the strings 'mean()' & 'std()'

#Extract colnames with mean and standard deviation
MeanAndStdData <- MasterData[, grep("[Mm]ean|[Ss]td", colnames(MasterData))]
#Add the Subject and activity columns
MeanAndStdData$Activity <- MasterData$Activity
MeanAndStdData$Subject <- MasterData$Subject

##Desciptive names to name the activities

#Change the column names of 'ActivityLabels' dataframe
colnames(ActivityLabels) <- c("ActivityNo", "ActivityName")
#Merge MeanAndStdData dataframe with 'ActivityLabels' dataframe
MeanAndStdData <- merge(MeanAndStdData, ActivityLabels, by.x = "Activity", 
                        by.y = "ActivityNo")

##Descriptive Variable Names: Remove all the special characters and make the
##names tidy and comprehendable

DescriptiveName <- gsub("-mean", "Mean",colnames(MeanAndStdData))
DescriptiveName <- gsub("-std", "Std",DescriptiveName)
DescriptiveName <- gsub("tBody", "timeBody",DescriptiveName)
DescriptiveName <- gsub("tGravity", "timeGravity",DescriptiveName)
DescriptiveName <- gsub("gravity", "Gravity",DescriptiveName)
DescriptiveName <- gsub("fBody", "frequencyBody",DescriptiveName)
DescriptiveName <- gsub("BodyBody", "Body",DescriptiveName)
DescriptiveName <- gsub("\\(", "",DescriptiveName)
DescriptiveName <- gsub("\\)", "",DescriptiveName)
DescriptiveName <- gsub(",", "",DescriptiveName)
DescriptiveName <- gsub("-", "",DescriptiveName)

colnames(MeanAndStdData) <- DescriptiveName

##data set with the average of each variable for each activity and each subject
AvgValuesActivitySubject <- aggregate(.~Subject + ActivityName,
                                      data=MeanAndStdData, FUN=mean)
