## Raw data

### Source
Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.

www.smartlab.ws

## Raw dataset information

The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, the data captured:
- 3-axial linear acceleration
- 3-axial angular velocity

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For further details about this dataset check the README.txt (link).

For each record it is provided:
- Triaxial acceleration from the accelerometer and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
- README.txt
- features_info.txt: Shows information about the variables used on the feature vector.
- features.txt: List of all features.
- activity_labels.txt: Links the class labels with their activity name.
- train/X_train.txt: Training set.
- train/y_train.txt: Training labels.
- test/X_test.txt: Test set.
- test/y_test.txt: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the total_acc_x_train.txt and total_acc_z_train.txt files for the Y and Z axis. 
- train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

