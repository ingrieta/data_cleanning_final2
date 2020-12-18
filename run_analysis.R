#BAJAR LOS ARCHIVOS Y DESCOMPRIMIRLOS

file <- "Coursera_Final_W3.zip"
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, file)
unzip(file) 


#LECTURA DE TABLAS
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("row","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject") # simbolos
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code") # simbolos
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")#simbolos
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")#simbolos


# primero se juntan todos las observaciones de las tablas x, y y subject
#para posteriormente obtener una tabla con todas las columnas de esas tablas

subject = rbind(subject_train,subject_test)
y = rbind(y_train,y_test)
x = rbind(x_train,x_test) 
df_merged = cbind(subject,y,x)

#subconjunto con sólo las columnas que tengan "mean" y "std" 
library(dplyr)
mean_std = df_merged %>% select(subject, code, contains("mean"), contains("std"))


#substituir el codigo numerico por la descripcion de la actividad contenida en
#el df activity

mean_std$code = activities[mean_std$code, 2]

# remplazar con los nombres descriptivos cada variable de mean_std.R
names(mean_std)[2] = "activity"
names(mean_std)= gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std) = gsub("Gyro", "Gyroscope", names(mean_std))
names(mean_std) = gsub("BodyBody", "Body", names(mean_std))
names(mean_std) = gsub("Mag", "Magnitude", names(mean_std))
names(mean_std) = gsub("^t", "Time", names(mean_std))
names(mean_std) = gsub("^f", "Frequency", names(mean_std))
names(mean_std) = gsub("tBody", "TimeBody", names(mean_std))
names(mean_std) = gsub("-mean()", "Mean", names(mean_std))
names(mean_std) = gsub("-std()", "STD", names(mean_std))
names(mean_std) = gsub("-freq()", "Frequency", names(mean_std))
names(mean_std) = gsub("angle", "Angle", names(mean_std))
names(mean_std) = gsub("gravity", "Gravity", names(mean_std))
# df final en el que agrupamos por actividad y sujeto
df_final = mean_std %>%
  group_by(activity,subject) %>%
  summarise_all(funs(mean))
write.csv(df_final, "final.csv")

