## STEP 1
### load raw measurement data tables, bind them, free memory from the orginal files,.

### 1.1 'X_test' and 'X_train' data set (time and frequency measures)
testTable <- read.table("UCI HAR Dataset/test/X_test.txt")
trainTable <- read.table("UCI HAR Dataset/train/X_train.txt")

### 1.2 bind the two together: they contain the same columns in the same order
totalMeasuresTable <- rbind(testTable,trainTable)

### 1.3 free memory from original 2 tables
rm(testTable)
rm(trainTable)


## STEP 2
### change the column names to their feature names

### To do this, load variable names and their column position in the raw data table
### 'V1' column holds the column position in the raw dataset.
### 'V2' holds feature name
varNamesTable <- read.table("UCI HAR Dataset/features.txt")
names <- varNamesTable[,2]
names(totalMeasuresTable) <- names


## STEP 3
## 3.1 using grpl(), obtain a table with only mean and stddev variable names
reducedNamesTable <- varNamesTable [grepl(("-[m,M]ean|-[s,S]td"),varNamesTable$V2),]

## 3.2 We can then make a subset from the measures data, comprising
## only the columns we want, since we have their names in V2.
varsToKeep <- as.vector(reducedNamesTable[,2])
totalMeasuresTable <- subset(totalMeasuresTable, select=varsToKeep)


## STEP 4
### add an 'id' column to each row
totalMeasuresTable$id <- seq(1:nrow(totalMeasuresTable))


## STEP 5
### load raw 'activity' data tables, bind them, free memory and add 'id' column

### 5.1 'y_test' and 'y_train' data sets
### (factor variables for each measure row, indicating type of activity)
testActivityTable <- read.table("UCI HAR Dataset/test/y_test.txt")
trainActivityTable <- read.table("UCI HAR Dataset/train/y_train.txt")

### 5.2 bind the two together:
## they contain 1 column with rows in the same order as the measure tables
totalActivityTable <- rbind(testActivityTable,trainActivityTable)

### 5.3 free memory from original 2 tables
rm(testActivityTable)
rm(trainActivityTable)

### 5.4 add an 'id' column to each row
totalActivityTable$id <- seq(1:nrow(totalActivityTable))


## STEP 6
### load raw 'subject' data tables, bind them, free memory and add 'id' column

### 6.1 'subject_test' and 'subject_train' data sets
### factor variables indicating the id of the subjects taking part to the experiment)
testSubjectTable <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubjectTable <- read.table("UCI HAR Dataset/train/subject_train.txt")

### 6.2 bind the two together:
### they contain 1 column with rows in the same order as the measure tables
totalSubjectTable <- rbind(testSubjectTable,trainSubjectTable)

### 6.3 free memory from original 2 tables
rm(testSubjectTable)
rm(trainSubjectTable)

### 6.4 add an 'measure_id' column to each row
totalSubjectTable$id <- seq(1:nrow(totalSubjectTable))


## STEP 7
### rename factor column in activy and subject tables to be more meaningful
names(totalActivityTable)[1]<- "activity_id"
names(totalSubjectTable)[1]<- "subject"


## STEP 8
### merge by id: first the measures and activity tables
### then, the subject table to the one just obtained from previous merge
temp <- merge(totalMeasuresTable,totalActivityTable,by="id")
globalTable <- merge(temp,totalSubjectTable,by='id')

### free memory from the temp table
rm(temp)


## STEP 9
### load the activity factor/description table and change the column names
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activityNames) <- c("activity_id","activity")


## STEP 10
### merge activityNames with globalTable to join the meaningful "activity label" related to activity_id
tidyTable <- merge(globalTable,activityNames,by="activity_id")
rm(globalTable)

### 10.1 save tidy set to disk
if(!file.exists("./tidyData")){
      dir.create("./tidyData")
}
write.csv(tidyTable, file = "tidyData/tidyTable.csv", row.names = FALSE)

## STEP 11
### => Get the number of different subjects in the tidyTable.
l <- length(split(tidyTable,as.factor(tidyTable$subject)))

## STEP 12
### => Aggregate, by subject and by activiy, the mean() of each and all variables.

### 12.1 Aggregate, by activiy, the data for subject '1'.
### This allows to maintain the column names and to have a starting data.frame to bind to.
### The column indexes (3:81) to aggregate have been obtained visually checking with head(tidyTable)
### during elaboration of this script
subSet <- tidyTable[tidyTable$subject== 1,]
subSet <- aggregate(subSet[, 3:81], list(subSet$activity), mean)
names(subSet)[1] <- 'activity'
subSet <- cbind(subject=1,subSet)
subjectByActivityOverallMeans <- subSet

### 12.2 loop through the remaining subjects and 
### bind each resulting data.frame to subjectByActivityOverallMeans

for (n in 2:l){
      subSet <- tidyTable[tidyTable$subject== n,]
      subSet <- aggregate(subSet[, 3:81], list(subSet$activity), mean)
      names(subSet)[1] <- 'activity'
      subSet <- cbind(subject=n,subSet)
      subjectByActivityOverallMeans <- rbind(subjectByActivityOverallMeans,subSet)      
}

## STEP 13 save tidy dataset and overall means dataset to disk
if(!file.exists("./tidyData")){
      dir.create("./tidyData")
}
write.table(tidyTable, file = "tidyData/tidyTable.txt", sep='\t', row.names = FALSE)
write.table(subjectByActivityOverallMeans, file = "tidyData/overallMeansTable.txt", sep='\t', row.names = FALSE)

