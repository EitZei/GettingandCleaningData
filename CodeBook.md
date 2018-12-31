# Source of data

The work is based on [Human Activity Recognition Using Smartphones Data Set
](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.

# Analysis

Data for both training and test phase is combined and features describing either mean or standard deviation are grouped by activity and subject and then averaged.

# Files

- `average_by_activity_and_subject.txt` table formatted data file with each fow representing one subject-activity pair with averages of features in columns

# Variables

- `activity` the type of activity detected. Value from set `{LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS}`
- `subject` the numerical ID of the subject
- 66 columns containing the averages of named features. The feature names are the ones described in `./UCI_HAR_Dataset/features.txt` and `./UCI_HAR_Dataset/features_info.txt` except that dashes are converted (`-`) to dots (`.`) and parenthesis are removed.
