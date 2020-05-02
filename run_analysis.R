library(tidyverse)

# 1. upload raw data

# column labels
features <-
    read_table(
        "./UCI HAR Dataset/features.txt",
        col_names = c("features_list")
    ) %>%
    pull(features_list)

# activity labels
activity_labels <- 
    read_table(
        "./UCI HAR Dataset/activity_labels.txt", 
        col_names = c("activity_id", "activity"), 
        col_types = cols(activity_id = col_integer(), activity = col_character())
    ) %>%
    mutate(activity = tolower(activity))

# set data
train_set <- read_table("./UCI HAR Dataset/train/X_train.txt",  col_names = FALSE)
test_set <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
full_set <- train_set %>% bind_rows(test_set) # merge train / test sets

# labels data
train_labels <- 
    read_table(
        "./UCI HAR Dataset/train/y_train.txt", 
        col_names = c("activity_id"), 
        col_types = "i"
    )

test_labels <- 
    read_table(
        "./UCI HAR Dataset/test/y_test.txt", 
        col_names = c("activity_id"), 
        col_types = "i"
    )

full_labels <- train_labels %>% bind_rows(test_labels) # merge labels sets

# subjects data
train_subject <- 
    read_table(
        "./UCI HAR Dataset/train/subject_train.txt", 
        col_names = c("subject"), 
        col_types = "i"
    )

test_subject <- 
    read_table(
        "./UCI HAR Dataset/test/subject_test.txt", 
        col_names = c("subject"), 
        col_types = "i"
    )

full_subject <- train_subject %>% bind_rows(test_subject) # merge subjects sets


# 2. create merged data frame and extract mean/std 

full_set <-
  full_set %>%
  magrittr::set_colnames(features) %>%    # set new variables name
  select(matches("[Mm]ean|[Ss]td")) %>%   # select mean and std columns
  bind_cols(full_labels, full_subject) %>%    # merge labels/subjects columns
  left_join(
      activity_labels, 
      by = c("activity_id" = "activity_id")
  ) %>%
  select(-activity_id) %>%
  select(subject, activity, everything())

new_set <- 
    full_set %>% 
    group_by(subject, activity) %>% 
    summarise_all(mean, na.rm = TRUE)



# activity labels come factors, con ordine da file txt