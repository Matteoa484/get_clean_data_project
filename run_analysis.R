library(tidyverse)

# upload raw data

features <- read_table("./UCI HAR Dataset/features.txt", col_names = FALSE) 
test_set <- read_table("./UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
test_labels <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE, col_types = "i")
train_set <- read_table("./UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
train_labels <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE, col_types = "i")
activity_labels <- read_table("./UCI HAR Dataset/activity_labels.txt", col_names = FALSE)

# clean variable names and merge test and train sets

features <- 
    features$X1 %>% 
    str_replace("^[1-9] ", "")

full_set <- rbind(test_set, train_set)
names(full_set) <- features

full_set <- 
    full_set %>% 
    select(matches("[Mm]ean|[Ss]td"))

# x test df, y test lista attivita, da aggiungere come colonna e mettere in relazione con activity labels
# features dovrebbero essere nomi variabili del dataframe finale (nr = a nr colonne in df)