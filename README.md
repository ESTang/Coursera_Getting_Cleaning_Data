# Coursera_Getting_Cleaning_Data Course project : run_analysis.R file description

### Step 1: Step 1: Reading in all data file: all files must be in working director

This step read in all the data (txt) file needed to do the project. These are:

1. The feature file containing the name of the variables
2. The activity label file containing the id and the label for each activity type
3. The training and test files which include
- The training and test data
- the training and test activity label
- the training and test subject number

### Step 2: Applying variable labels to training datasets variable, merging subject, activity labels to training dataset 

This step applies the variable labels and then merge in the subject number and the activity number and label to both the 
training and test dataset. The same treatment is applied to both dataset

### Step 3: Concatenating Training and test data

This step combines the training and test data togheter into a single dataset

### Step 4: Keeping only mean and std variables 

This steps finds all the variable names that contains the string "mean" and "std" and then keeps only those variable in the
combined traning and test dataset

### Step 5: Creating 2nd tidy dataset with average of each variable for each subject and activity

This step takes the combined training and test dataset and melts it into a long and narrow dataset and recast it to find the average of each variable for each subject and activity

### Step 6: Output all_data_mean dataframe to txt file

This step outputs the final file to a txt format for review by peers
