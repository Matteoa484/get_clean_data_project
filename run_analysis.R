library(tidyverse)

# upload raw data

features <- read_table("./UCI HAR Dataset/features.txt", col_names = FALSE) 
test_set <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
test_labels <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE, col_types = "i")
train_set <- read_table("./UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
train_labels <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE, col_types = "i")

activity_labels <- 
    read_table(
        "./UCI HAR Dataset/activity_labels.txt", 
          col_names = FALSE, 
          col_types = cols(X1 = col_integer(), X2 = col_character())
    )

# clean variable names and merge test and train sets

features <- 
    features$X1 %>% 
    str_replace("^[0-9] |[0-9][0-9] |[0-9][0-9][0-9] ", "")

activity_labels <- 
    activity_labels %>%
    rename(activity_id = X1, activity = X2) %>%
    mutate(activity = tolower(activity))

names(train_set) <- features

train_set <- train_set %>% bind_cols(train_labels)


test_set <- test_set %>% bind_cols(test_labels)

full_set <-
    test_set %>%
    bind_rows(train_set) %>%
    rename_all(~features)


full_set <- rbind(test_set, train_set)
names(full_set) <- features

full_set <- 
    full_set %>% 
    select(matches("[Mm]ean|[Ss]td"))

rm("features", "test_set", "train_set")

# bind_cols to merge columns (cbind equivalent)
# x test df, y test lista attivita, da aggiungere come colonna e mettere in relazione con activity labels
# features dovrebbero essere nomi variabili del dataframe finale (nr = a nr colonne in df)