# Load necessary packages
library("dplyr")

# Set some global variables
dir_data = "UCI_HAR_Dataset"
interesting_features_regex <- "\\.(mean|std)($|\\.)"

# Load the activity labels
get_activity_labels <- function() {
  read.table(
    file.path(dir_data, "activity_labels.txt"), 
    header = FALSE, 
    col.names = c("key", "value"))
}

# Load and normalize the feature names
get_feature_names <- function() {
  features <- read.table(
    file.path(dir_data, "features.txt"), 
    header = FALSE, 
    col.names = c("key", "value"))
  
  feature_names <- as.character(features$value)
  feature_names <- gsub("-", ".", feature_names)
  feature_names <- gsub("\\(\\)", "", feature_names)
  
  feature_names
}

# Load the phase data set
#   - Use features as variables names for training data set
#   - Filter features only to the interesting ones
#   - Change activity indices to labels
#   - Combine datasets by row
load_phase_data = function(phase, activity_labels, feature_names) {
  interesting_features_idx <- grep(interesting_features_regex, feature_names)
  
  phase_X <- read.table(
    file.path(dir_data, phase, paste("X_", phase, ".txt", sep = "")),
    header = FALSE,
    col.names = feature_names)
  phase_X <- phase_X[, interesting_features_idx]
  
  phase_y <- read.table(
    file.path(dir_data, phase, paste("y_", phase, ".txt", sep = "")),
    header = FALSE, 
    col.names = c("activity"))
  phase_y$activity <- sapply(
    phase_y$activity, 
    function(idx) { 
      activity_labels[activity_labels$key == idx, 2] 
    })
  
  phase_subject <- read.table(
    file.path(dir_data, phase, paste("subject_", phase, ".txt", sep = "")),
    header = FALSE, 
    col.names = c("subject"))

  cbind(phase = as.factor(phase), phase_subject, phase_y, phase_X)
}

# Load training and test data and combine them
load_data <- function() {
  activity_labels <- get_activity_labels()
  feature_names <- get_feature_names()
  
  train <- load_phase_data("train", activity_labels, feature_names)
  test <- load_phase_data("test", activity_labels, feature_names)
  
  data <- rbind(train, test)
  
  as_tibble(data)
}

# Average the features by subject and activity
average_by_activity_and_subject <- function(data) {
  data %>% 
    group_by(activity, subject) %>% 
    select(matches(interesting_features_regex)) %>% 
    summarise_all(mean)
}

# Load the data
data <- load_data()

# Average the data by subject a
by_activity_and_subject <- average_by_activity_and_subject(data)

# Write data to file
write.table(by_activity_and_subject, "./average_by_activity_and_subject.txt")