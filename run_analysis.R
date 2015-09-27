
init<- function() {
  #Verify if required libraries are installed, if not get them installed 1st.
  
  if("dplyr" %in% rownames(installed.packages()) == FALSE) 
    {install.packages("dplyr")}
  if("plyr" %in% rownames(installed.packages()) == FALSE) 
    {install.packages("plyr")}
  library(dplyr)
  library(plyr)
}

# Step 1: Get the source compressed file, extract and merge files.
getDataObs = function()
{
  if (!file.exists("dataset")) 
  {
    dir.create("dataset")
  }
  if (!file.exists("dataset/Week3Project")) 
  {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    filename ="dataset/SourceFile.zip"
    download.file(url, destfile=filename, method ="curl")
    unzip(filename, exdir="dataset/Week3Project")
  }

  # Load test data files
  test_x <- read.table("dataset/Week3Project/UCI HAR Dataset/test/X_test.txt")
  test_y <- read.table("dataset/Week3Project/UCI HAR Dataset/test/y_test.txt")
  test_subject <- read.table("dataset/Week3Project/UCI HAR Dataset/test/subject_test.txt")  
  
  # Load train data files
  train_x <- read.table("dataset/Week3Project/UCI HAR Dataset/train/X_train.txt")
  train_y <- read.table("dataset/Week3Project/UCI HAR Dataset/train/y_train.txt")
  train_subject <- read.table("dataset/Week3Project/UCI HAR Dataset/train/subject_train.txt")

  # Merge data files
  merged_x_data <- rbind(train_x, test_x)
  merged_y_data <- rbind(train_y, test_y)
  merged_subject_data <- rbind(train_subject, test_subject)
  list(x=merged_x_data, y=merged_y_data, subject=merged_subject_data)
}

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
extractMean_StdDev = function(dataframe) 
{ 
  features <- read.table("dataset/Week3Project/UCI HAR Dataset/features.txt")
  extracted_means <- sapply(features[,2], function(x) grepl("mean()", x, fixed = TRUE))
  extracted_stds <- sapply(features[,2], function(x) grepl("std()", x, fixed = TRUE))
  extracted <- dataframe[, (extracted_means | extracted_stds)]
  colnames(extracted) <- features[(extracted_means | extracted_stds), 2]
  extracted
  
}

# Step 3: Set descriptive activity names to name the activities in the data set
setDescriptiveNames = function(dataframe)
{
  colnames(dataframe) <- "activity"
  dataframe$activity[dataframe$activity == 1] = "WALKING"
  dataframe$activity[dataframe$activity == 2] = "WALKING_UPSTAIRS"
  dataframe$activity[dataframe$activity == 3] = "WALKING_DOWNSTAIRS"
  dataframe$activity[dataframe$activity == 4] = "SITTING"
  dataframe$activity[dataframe$activity == 5] = "STANDING"
  dataframe$activity[dataframe$activity == 6] = "LAYING"
  dataframe
}  

run<- function(){
  # Verify if required libraries are installed. If not, get them installed.
  init()
  # Get source files, extract and merge files.
  merged_data<-getDataObs()
  # Extract measurements on the mean and standard deviation for each measurement. 
  meanStd <- extractMean_StdDev(merged_data$x)
  activities<-setDescriptiveNames(merged_data$y)
  colnames(merged_data$subject) <- "subject"
  # Merge mean and standard deviation with activities data frame
  binded_data <- cbind(meanStd, activities, merged_data$subject)
  # Create tidy dataset.
  tidy_data <- ddply(binded_data, .(subject, activity), function(x) colMeans(x[,1:60]))
  # Write tidy dataset into a text file. 
  write.table(tidy_data, "dataset/Week3Project/tidy_dataset.txt", row.names=FALSE)  
    
}