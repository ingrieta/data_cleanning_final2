## Pre requirements:

1. download the files contained in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. unzip them and save them in R's working directory.
3. read each file from the "getdata_projectfiles_UCI HAR Dataset" directory and assign it to different DFs to work with, The resulting DFs have the following characteristics:
features <- features.txt: 561 rows, 2 variables
activities <- activity_labels.txt: 6 rows, 2 variables
subject_test <- test / subject_test.txt: 2947 rows, 1 variable
x_test <- test / X_test.txt: 2947 rows, 561 variables
y_test <- test / y_test.txt: 2947 rows, 1 variables
subject_train <- test / subject_train.txt: 7352 rows, 1 variable
x_train <- test / X_train.txt: 7352 rows, 561 variables
y_train <- test / y_train.txt: 7352 rows, 1 variables

## run_analysis.R program executes:
###Step1. Merges the training and the test sets to create one data set

subject (10299 rows, 1 variables) is the result of joining the rows of subject_train and subject_test using rbind ()
y (10299 rows, 1 variables) is the result of joining the rows of y_test and y_train using the rbind () function
x (10299 rows, 561 variables) is the result of joining the rows of x_test and x_train using the rbind () function
df_merged (10299 rows, 563 variables) is the result of joining the columns of subject, y, x using cbind ()


###Step 2.Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std (10299 rows, 88 columns) which is a subset of the "subject" and "code" columns of df_merged which
they contain the word "mean" and "std".

####Step 3.Uses descriptive activity names to name the activities in the data set.
replace the number in the code column of the mean_std df with the description of the activity contained in the activity df

####Step 4.Appropriately labels the data set with descriptive variable names.

"Acc" are replaced with "Accelerometer"
"Gyro" are replaced with "Gyroscope"
"BodyBody" are replaced with "Body"
"Mag" are replaced with "Magnitude"
"^ t" are replaced with "Time"
"^ f" are replaced with "Frequency"
"tBody" are replaced with "TimeBody"
"-mean ()" are replaced with "Mean"
"-std ()" are replaced with "STD"
"-freq ()" are replaced with "Frequency"
"angle" are replaced with "Angle"
"gravity" are replaced with "gravity"


###Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
df_final (180 rows, 88 variables) is the result of obtaining the average of each variable and then agroparing it by the categorical columns for activity and subject.
the result of this last operation is saved in a file called "final.csv"
