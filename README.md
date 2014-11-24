##Study Design
The goal of this project is to prepare tidy data that can be used for later analysis.
<br/>The project is part of the **Getting and Cleaning Data** Coursera course.

You can find  **Code book** is at the end of this README file.

####Preliminary survey of the raw data available
1. The data batch was delivered in a compressed folder named *getdata_projectfiles_UCI HAR Dataset.zip* which was decompressed.
2. All files in the folder (and subfolders therein present) were text files (file extension: .txt).
3. All files have been opened into RStudio to inspect their contents:
      - some were decriptive files and have all been read;
      - some were data files and have been inspected using the following method:
```
the_table <- read.table("name_of_file.txt")
View(the_table)      
```
4. **No manipulation** of *any data* contained in *any file* has been done at this stage.
5. The files contaning the measurement data to make tidy were in the files:
      - X_test.txt (2947 rows, 561 variables)
      - X_train.txt (7352 rows, 561 variables)
6. The variable names, ordered by their index in the 2 datasets, were in the file:
      - features.txt (561 variable names)
7. The measurements were conducted on 30 subjects. Two files connect each measure to a subject:
      - subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
      - subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
8. Each subject was measured during 6 different activities.
      - 'activity_labels.txt': Links the class labels with their activity name (factor).
      - the y_test.txt and X_test.txt contained the activity factor for each corresponding row in the two measurements files.

The R script **run_analysis.R**:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. The 2 resulting files (step 4 and step 5) are saved (as .csv datasets) to disk in a folder named 'tidyData':
      - tidyData/tidyTable.txt
      - tidyData/overallMeansTable.txt

##IMPORTANT NOTE
The *run_analysis.R* script **MUST be** in the same folder with the original UCI HAR Dataset **folder** (obtained after unzipping). 
      