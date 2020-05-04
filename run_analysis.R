library(tidyverse)

# upload raw data ---------------------------------------------------------

feat_list <- read_table("./UCI HAR Dataset/features.txt", col_names = c("features"), col_types = "c") 

activity_labels <- 
  read_table(
    "./UCI HAR Dataset/activity_labels.txt", 
    col_names = c("activity_id", "activity"), 
    col_types = cols(activity_id = col_integer(), activity = col_character())
  ) %>%
  mutate(activity = tolower(activity))

# set data
data_train <- read_table("./UCI HAR Dataset/train/X_train.txt",  col_names = c(feat_list$features))
data_test <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = c(feat_list$features))

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


# merge data sets ---------------------------------------------------------

data_train <- data_train %>% bind_rows(data_test)
train_labels <- train_labels %>% bind_rows(test_labels)
train_subject <- train_subject %>% bind_rows(test_subject)

full_set <-
  data_train %>%
  bind_cols(train_labels, train_subject) %>%
  left_join(
    activity_labels, 
    by = c("activity_id" = "activity_id")
  )


#%>%
    pull(features) %>%
    str_to_lower() %>%
    str_replace_all(features, c(
        "[1-9] |[1-9][0-9] |[1-9][0-9][0-9] " = "",
        "^t" = "time_",
        "body" = "body_",
        "gravity" = "gravity_")
    )
    

# Body+mean+X
# str_subset(features, ".Body[a-zA-Z]{3}[:punct:]mean[:punct:]{3}X$")

# activity labels









# create merged set and extract mean/std ----------------------------------


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

# create a new tidy data set ----------------------------------------------


new_set <- 
    full_set %>% 
    group_by(subject, activity) %>% 
    summarise_all(mean, na.rm = TRUE)

write_delim(new_set, path = "tidy_data_set.txt", delim = " ", col_names = TRUE)

# activity labels come factors, con ordine da file txt