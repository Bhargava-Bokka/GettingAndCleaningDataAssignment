# Getting And Cleaning Data Course Project

The purpose of the assignment is to demonstrate our ability to collect, work with, and clean a data set. The data given is for an experiment carried out on 30 subjects while they performed any of the six activities (WALKING, WALKING Upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using the sembedded accelerometer and gyroscope, a variety of readings related to the acceleration and movements of the subjects. After applying various filters, for each record in the data the following are provided:
  - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
  - Triaxial Angular velocity from the gyroscope. 
  - A 561-feature vector with time and frequency domain variables. 
  - Its activity label. 
  - An identifier of the subject who carried out the experiment.\

The obtained data is divided into two sets: 
  + training set with 70% data
  + testing set with 30% data
  
## Files in the dataset

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Data cleaning and transformation

The following transformations and analyses were followed to obtain at the clean set

1. Read the input files (the files mentioned above) to dataframes in R

2. Create consolidated training and testing sets with 'subject' and 'activity' information, and label the columns

    + change the column names of the train and test dataframe for the 561 columns
    + Add the activity and subject columns to the respective dataframes
    + Merge the training and testing data sets

3. Extract measurements on the mean and standard deviation. Names of the columns with mean & standard deviation values contain the strings 'mean()' & 'std()'

    + Extract colnames with mean and standard deviation
    + Subset the data with the above columns to create *MeanAndStdData*
    + Add the Subject and activity columns to *MeanAndStdData*
  
4. Descriptive names to name the activities

    + Merge *MeanAndStdData* dataframe with 'Activity Labels' described in 'activity_labels.txt'

5. Descriptive Variable Names: Remove all the special characters and make the names tidy and comprehendable

6. As required in the final step, data set with the average of each variable for each activity and each subject (using aggregate function)
