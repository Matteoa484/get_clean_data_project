# Raw data

### Source
Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.

www.smartlab.ws

### Raw dataset information

The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, the data captured 3-axial linear acceleration and 3-axial angular velocity.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For each record it is provided:
- Triaxial acceleration from the accelerometer and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

For further details about this dataset check the README.txt ([link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)).

### Dataset files

The files included in the dataset folder and **used for the Coursera project are**:
1. *README.txt*
2. *features_info.txt*: Shows information about the variables used on the feature vector.
3. *features.txt*: List of all features.
4. *activity_labels.txt*: Links the class labels with their activity name.
5. *train/X_train.txt*: Training set.
6. *train/y_train.txt*: Training labels.
7. *train/subject_train.txt*: Training subjects.
8. *test/X_test.txt*: Test set.
9. *test/y_test.txt*: Test labels.
10. *test/subject_test.txt*: Test subjects.

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

#### Features

The base raw data is the 3-axial (*XYZ*) raw time signals ("t" prefix) from the accelerometer (*tAcc-XYZ*) and gyroscope (*tGyro-XYZ*). *tAcc-XYZ* was then separated into body (*tBodyAcc-XYZ*) and gravity (*tGravityAcc-XYZ*) signals. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (*tBodyAccJerk-XYZ* and *tBodyGyroJerk-XYZ*). The magnitude of these signals were calculated using the Euclidean norm (*tBodyAccMag*, *tGravityAccMag*, *tBodyAccJerkMag*, *tBodyGyroMag*, *tBodyGyroJerkMag*). Finally a Fast Fourier Transform was applied to some of these signals ("f" prefix) producing *fBodyAcc-XYZ*, *fBodyAccJerk-XYZ*, *fBodyGyro-XYZ*, *fBodyAccJerkMag*, *fBodyGyroMag*, *fBodyGyroJerkMag*. 

Those signals were used to estimate the following features for each pattern: tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ,  fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

The variables estimated from these signals are:
- mean(): mean value
- std(): standard deviation
- mad(): median absolute deviation 
- max(): largest value
- min(): smallest value
- sma(): signal magnitude area
- energy(): energy measure 
- iqr(): interquartile range 
- entropy(): signal entropy
- arCoeff(): autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): angle between vectors

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable: gravityMean,  tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean.

The complete features list is saved in the *features.txt* file. The features data are saved in the *X_train.txt* file (~70% of total) and the *X_test.txt* file (~30% of total).

dataset | txt file | cols | rows
--------|----------|----------|---------
features list|features.txt|1|561
features obs. train|X_train.txt|561|7352
features obs. test|X_test.txt|561|2947
features obs. total| - |561|10299

#### Subjects

List of subjects for each observation, data range from subject 1 to subject 30. The list is saved in the *subject_train.txt* file and the *subject_test.txt* file.

dataset | txt file | cols | rows 
--------|----------|------|-------
subjects obs. train|subject_train.txt|1|7352
subjects obs. test|subject_test.txt|1|2947
subjects obs. total| - |1|10299

#### Activities

The list of the 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) are saved in the *activity_labels.txt* file, which is a data frame of 2 columns (activity id and activity label) and 6 rows (the 6 activites). The single observation's activity is saved in the *y_train.txt* for the train dataset and in the *y_test.txt* for the test dataset.

dataset | txt file | cols | rows 
--------|----------|------|-------
6 activities|activity_labels.txt|2|6
activitz obs. train|y_train.txt|1|7352
activity obs. test|y_test.txt|1|2947
activity obs. total|-|1|10299

# Transformations

#### Merge raw data

After uploading all the raw files, the R script merge the *train* and *test* data for each group (observations, labels and subjects) and then bind all together in a "full raw dataset" of **564 columns** and **10299 rows**.

dataset | cols | rows
--------|------|-------
features obs. total|561|10299
subjects obs. total|1|10299
activity obs. total|1|10299
full dataset|564|10299

#### Select mean / std variables

The script selects only the variables based on mean or std, reducing the full dataset to **88 columns and 10299 rows**.

dataset | cols | rows 
--------|------|------
raw dataset|564|10299
filtered dataset|88|10299

#### Clean variables' name

The features list (cols name) is cleaned through `stringr::str_replace_all` and some RegEx, in order to make them easier to read. The words have been lowercased, separated by a "\_" and all the punctuation removed / replaced with "\_".

raw string | replaced string 
-----------|-----------------
\-| \_ 
\( \) | 
(?<=[a-zA-Z]) \( | \_
\, | \_
\) $ | 
\) (?=[:punct:]) | 
[0-9] {1,3} | 
(?<=body) body | 
acc (?=[a-z]) | acc_
gyro (?=[a-z]) | gyro_
^t | time_
^f | fourier_
body (?=[a-z]) | body_
gravity (?=[a-z]) | gravity_
mean (?=[a-z]) | mean_
jerk (?=[a-z]) | jerk_

# New tidy dataset

In the final step, the `run_analysis.R` script group the data by *subject* and *activity* with `dplyr::group_by` and then with `dplyr::summarise_all` computes the variables mean for each sub-group (i.e. subject-1 walking or subject-2 standing, etc).

The outcome is a new tidy dataset, saved as a txt file with the name *tidy_data_set.txt*, composed of **88 columns** and **180 rows**
