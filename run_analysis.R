library(tidyverse)

# upload raw data

features <- 
    read_table(
      "./UCI HAR Dataset/features.txt", 
      col_names = c("features_list")
    ) %>%
    pull(features_list) %>%
    str_replace("^[0-9] |[0-9][0-9] |[0-9][0-9][0-9] ", "")         
    
activity_labels <- 
  read_table(
    "./UCI HAR Dataset/activity_labels.txt", 
    col_names = c("activity_id", "activity"), 
    col_types = cols(activity_id = col_integer(), activity = col_character())
  ) %>%
  mutate(activity = tolower(activity))

train_set <- 
    read_table(
        "./UCI HAR Dataset/train/X_train.txt", 
        col_names = FALSE
      )


test_set <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
test_labels <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE, col_types = "i")

train_labels <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE, col_types = "i")


# prepare variable and activity names

features_x <- 
    features$features_list %>% 
    str_replace("^[0-9] |[0-9][0-9] |[0-9][0-9][0-9] ", "")


full_labels <- train_labels %>% bind_rows(test_labels)

# create merged data frame

full_set <-
  train_set %>%
  magrittr::set_colnames(features) %>%    # set new variables name
  bind_rows(test_set) %>%   # merge train and test sets
  select(matches("[Mm]ean|[Ss]td")) %>%   # select mean and std columns
  bind_cols(full_labels) %>%    # merge labels column
  rename(activity_id = X1) %>%    # rename new column
  left_join(
      activity_labels, 
      by = c("activity_id" = "activity_id")
    ) %>%
  select(-activity_id) %>%
  select(activity, everything())




rm("features", "test_set", "train_set", "train_labels", "test_labels")

# bind_cols to merge columns (cbind equivalent)
# x test df, y test lista attivita, da aggiungere come colonna e mettere in relazione con activity labels
# features dovrebbero essere nomi variabili del dataframe finale (nr = a nr colonne in df)