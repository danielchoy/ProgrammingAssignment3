
This code book describes the variables, the data, and any transformations that was performed to clean up the original data set provided.

##Input data set

The original data contains data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original dataset (files):
- Filename: 'README.txt'
- Filename: 'features_info.txt': Shows information about the variables used on the feature vector.
- Filename: 'features.txt': List of features.
- Filename: 'activity_labels.txt': Links the class labels with their activity name.
- Filename: 'test/X_test.txt': Test set.
- Filename: 'test/y_test.txt': Test labels.
- Filename: 'train/X_train.txt': Training set.
- Filename: 'train/y_train.txt': Training labels.

The following data files are found for both the train and test data and their descriptions are the same. 

- Filename: 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- Filename: 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- Filename: 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

- Filename: 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


##Output data (Tidy data)

The output data file (tidy_data.txt) contains the mean and standard deviation for each measurement of test and train data sets. 