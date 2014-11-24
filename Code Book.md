##Code Book
1. Step by step description of the processing done by the *run_analysis.R* script.
2. Variables.

##1. Step by step description of the processing done by the *run_analysis.R* script.
**STEP 1**
Load raw measurement data tables, bind them, free memory from the orginal files.

1.1 Load *X_test.txt* and *X_train.txt* data sets (time and frequency measures)
1.2 Bind the two together: they contain the same columns in the same order.
1.3 Free memory from original 2 tables.

**STEP 2**
Change the column names (V1...) to their feature (variable) names.

To do this: from *features.txt*, load variable names and their column position in the raw data table:
-'V1' column holds the column position in the raw dataset.
-'V2' holds feature name.

**STEP 3**
3.1 using grpl(), from the table obtained in STEP 2, obtain a reduced table with only mean and stddev variable names.
3.2 We can then make a subset from the overaal measurements dataset (STEP 1), comprising
only the columns we want, since we have their names in column V2 in the dataset from STEP 3.1.

**STEP 4**
Add an 'id' column to dataset from STEP 1 and populate it with progressive integers (the 'id' of each row).

**STEP 5**
Load raw 'activity' datasets, bind them, free memory and add 'id' column

5.1 Load *y_test.txt* and *y_train.txt* datasets:
- these factor variables for each measure row, indicating type of activity.
5.2 Bind the two together: they contain 1 column with rows in the same order as the measure tables.
5.3 Free memory from original 2 tables.
5.4 Add an 'id' column to each row of the resulting bound dataset and populate it with progressive integers (the 'id' of each row).

**STEP 6**
Load raw 'subject' data tables, bind them, free memory and add 'id' column.

6.1 *subject_test.txt* and *subject_train.txt* datasets contain factor variables indicating the id of the subjects taking part to the experiment.
6.2 Bind the two together: hey contain 1 column with rows in the same order as the measure tables.
6.3 Free memory from original 2 tables.
6.4 Add an 'measure_id' column to each row and populate it.

**STEP 7**
Rename factor column in activy and subject tables to be more meaningful.

**STEP 8**
Merge by id: 
8.1 first our measures and activity tables
8.2 then, the subject table to the one just obtained from previous merge.
8.3 Free memory from the temporary table obtained in STEP 8.1.

**STEP 9**
Load the *activity_labels.txt* file containing factor/description (*activity_labels.txt*) into a data.table and change column names for next STEP.

**STEP 10**
Merge data.table from STEP 9 with "globalTable" from STEP 8 to join the meaningful activity "labels" related to activity_id.

10.1 Save tidy set to disk.

**STEP 11**
Get the number of different subjects in the tidyTable.

**STEP 12**
Aggregate, by subject and by activiy, the mean() of each and all variables.

12.1 Aggregate, by activiy, the data for subject '1'.
- This allows to maintain the column names and to have a starting data.frame to bind to.
- The column indexes (3:81) to aggregate have been obtained by visually checking with head(tidyTable) during development of the script.
12.2 Loop through the remaining subjects and bind each resulting data.frame to the first dataset obtained in previous STEP.

**STEP 13**
Save tidy dataset and overall-means dataset to disk.

*NOTE:*
Description of each step is also in the script file.


###2. Variables.

####Variables in the *tidyTable.txt* dataset.
All variables have the same meaning as in the original datasets.
The added variables have the explanation to their side.

[1] "activity_id" - added to permit merge: it corresponds to the original factor variable connected to the label.                   
[2] "id" - unique progressive number for each row                           
[3] "tBodyAcc.mean...X"               
[4] "tBodyAcc.mean...Y"              
[5] "tBodyAcc.mean...Z"               
[6] "tBodyAcc.std...X"               
[7] "tBodyAcc.std...Y"                
[8] "tBodyAcc.std...Z"               
[9] "tGravityAcc.mean...X"            
[10] "tGravityAcc.mean...Y"           
[11] "tGravityAcc.mean...Z"            
[12] "tGravityAcc.std...X"            
[13] "tGravityAcc.std...Y"            
[14] "tGravityAcc.std...Z"            
[15] "tBodyAccJerk.mean...X"           
[16] "tBodyAccJerk.mean...Y"          
[17] "tBodyAccJerk.mean...Z"           
[18] "tBodyAccJerk.std...X"           
[19] "tBodyAccJerk.std...Y"            
[20] "tBodyAccJerk.std...Z"           
[21] "tBodyGyro.mean...X"              
[22] "tBodyGyro.mean...Y"             
[23] "tBodyGyro.mean...Z"              
[24] "tBodyGyro.std...X"              
[25] "tBodyGyro.std...Y"               
[26] "tBodyGyro.std...Z"              
[27] "tBodyGyroJerk.mean...X"          
[28] "tBodyGyroJerk.mean...Y"         
[29] "tBodyGyroJerk.mean...Z"          
[30] "tBodyGyroJerk.std...X"          
[31] "tBodyGyroJerk.std...Y"           
[32] "tBodyGyroJerk.std...Z"          
[33] "tBodyAccMag.mean.."              
[34] "tBodyAccMag.std.."              
[35] "tGravityAccMag.mean.."           
[36] "tGravityAccMag.std.."           
[37] "tBodyAccJerkMag.mean.."          
[38] "tBodyAccJerkMag.std.."          
[39] "tBodyGyroMag.mean.."             
[40] "tBodyGyroMag.std.."             
[41] "tBodyGyroJerkMag.mean.."         
[42] "tBodyGyroJerkMag.std.."         
[43] "fBodyAcc.mean...X"               
[44] "fBodyAcc.mean...Y"              
[45] "fBodyAcc.mean...Z"               
[46] "fBodyAcc.std...X"               
[47] "fBodyAcc.std...Y"                
[48] "fBodyAcc.std...Z"               
[49] "fBodyAcc.meanFreq...X"           
[50] "fBodyAcc.meanFreq...Y"          
[51] "fBodyAcc.meanFreq...Z"           
[52] "fBodyAccJerk.mean...X"          
[53] "fBodyAccJerk.mean...Y"           
[54] "fBodyAccJerk.mean...Z"          
[55] "fBodyAccJerk.std...X"            
[56] "fBodyAccJerk.std...Y"           
[57] "fBodyAccJerk.std...Z"            
[58] "fBodyAccJerk.meanFreq...X"      
[59] "fBodyAccJerk.meanFreq...Y"       
[60] "fBodyAccJerk.meanFreq...Z"      
[61] "fBodyGyro.mean...X"              
[62] "fBodyGyro.mean...Y"             
[63] "fBodyGyro.mean...Z"              
[64] "fBodyGyro.std...X"              
[65] "fBodyGyro.std...Y"              
[66] "fBodyGyro.std...Z"              
[67] "fBodyGyro.meanFreq...X"          
[68] "fBodyGyro.meanFreq...Y"         
[69] "fBodyGyro.meanFreq...Z"          
[70] "fBodyAccMag.mean.."             
[71] "fBodyAccMag.std.."               
[72] "fBodyAccMag.meanFreq.."         
[73] "fBodyBodyAccJerkMag.mean.."      
[74] "fBodyBodyAccJerkMag.std.."      
[75] "fBodyBodyAccJerkMag.meanFreq.."  
[76] "fBodyBodyGyroMag.mean.."        
[77] "fBodyBodyGyroMag.std.."          
[78] "fBodyBodyGyroMag.meanFreq.."    
[79] "fBodyBodyGyroJerkMag.mean.."     
[80] "fBodyBodyGyroJerkMag.std.."     
[81] "fBodyBodyGyroJerkMag.meanFreq.."
[82] "subject"  - the factor (1 to 30) corresponding to each different subject participating (30 subjects)                      
[83] "activity" - the readable label corresponding to each different activity_id:
      - 1 WALKING 
      - 2 WALKING_UPSTAIRS
      - 3 WALKING_DOWNSTAIRS
      - 4 SITTING
      - 5 STANDING
      - 6 LAYING


####Variables for the *overallMeansTable.txt* dataset.

All the above, except "activity_id" and "id" have been removed after the grouping.
In this dataset the column names indicate the overall mean for the given variable,
for each suject and activity, as shown by the file name.