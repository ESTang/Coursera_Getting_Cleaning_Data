#------------------------------------------------;
# CoursEra: Getting and cleaning Data course
# Course project program
#------------------------------------------------
# Description: Creates a tidy dataset from the
#              the provided datasets
#
#------------------------------------------------
# Date: Mar 22nd 2015
# Author: Seng Tang
#------------------------------------------------;



#----- Reading in all data file ------;

# Feature file

feature <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

# Activity label file 

activity_label <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Training files

training_data <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
training_label <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
training_subject <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")


# Test files;

test_data <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("D:/R/Training/Getting and cleaning data - Coursera/Course_Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")


#----- Applying variable labels to training datasets variable, merging subject, activity labels to training dataset ------;

# Training data variable names
feature <- feature[order(feature$V1),]
colnames(training_data) <- feature$V2

# Adding subject number & activity label to training dataset
training_label$id <- 1:nrow(training_label)
training_label_txt <- merge(training_label,activity_label,by="V1",all.x=TRUE)
training_label_txt <- training_label_txt[order(training_label_txt$id),]
training_label_txt <- training_label_txt[,c("V1","V2")]
colnames(training_label_txt) <- c("Activity_number","Activity_Label")
colnames(training_subject) <- "Subject_Number"
training_data <- cbind(training_subject,training_label_txt,training_data)
rownames(training_data) <- NULL


#----- Applying variable labels to test datasets variable, merging subject, activity labels to test dataset ------;

# Test data variable names
feature <- feature[order(feature$V1),]
colnames(test_data) <- feature$V2

# Adding subject number & activity label to test dataset
test_label$id <- 1:nrow(test_label)
test_label_txt <- merge(test_label,activity_label,by="V1",all.x=TRUE)
test_label_txt <- test_label_txt[order(test_label_txt$id),]
test_label_txt <- test_label_txt[,c("V1","V2")]
colnames(test_label_txt) <- c("Activity_number","Activity_Label")
colnames(test_subject) <- "Subject_Number"
test_data <- cbind(test_subject,test_label_txt,test_data)
rownames(test_data) <- NULL


#------ Concatenating Training and test data ------; 
all_data <- rbind(training_data,test_data)


#------ Keeping only mean and std variables ------;
var_names <- as.character(feature$V2)
var_means <- grep("mean",var_names)
var_std <- grep("std",var_names)
var_means_std <- var_names[c(var_means,var_std)]
all_data_means_std <- all_data[,c("Subject_Number","Activity_Label",var_means_std)]


#------ Creating 2nd tidy dataset with average of each variable for each subject and activity ------;
library(reshape2)
melt_all_data <- melt(all_data_means_std, id=c("Subject_Number","Activity_Label")) 
all_data_mean <- dcast(melt_all_data, Subject_Number + Activity_Label~variable, mean)


#----- Output all_data_mean dataframe to txt file
write.table(all_data_mean,"D:/R/Training/Getting and cleaning data - Coursera/Course_Project/course_project_tidy_data.txt",row.name=FALSE)
