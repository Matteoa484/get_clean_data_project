# get_clean_data_project
## Coursera Getting &amp; Cleaning Data - week 4 assignment

This README is part of the final assignment of the "Getting and Cleaning Data" course by Johns Hopkins University on Coursera ([link](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project)).
The goal of the project is 1) to write a script that clean and merge different data sets and which 2) creates a new tidy data set after computing some transformations, and 3) write a Code Book that describes the variables, the data and any transformation performed.

The Github repo contains:
1. This README file
2. A script, `run_analysis.R`, the does all the tasks required
3. A Code Book with the information on all the variables and summaries calculated

Most of the work in the script is done with packages from the core *"tidyverse"*, in particular:
- **Readr**: compared to base read.table, it doesn't need the `StringsAsFactors = FALSE` and it's easier to create column names (`col_names`) and specific column parsing (`col_type`)
- **Dplyr**: it's a grammar of data manipulation, which through specific verbs performs all the main data manipulations with an easy-to-read code
- **Stringr**:
- **Tibble**: a data.frame which prints better on the console
- **Magrittr**: pipe (`%>%`) operator

### run_analysis
The scrip is divided in three sections:
1. Upload raw data from the folder Human Activity Recognition Using Smartphones Dataset ([link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip))
    
    All the data is uploaded via Readr `read_table()` declaring the columns name and the column parse if necessary. For example:
    
    `feat_list <- read_table("./UCI HAR Dataset/features.txt", col_names = c("features"), col_types = "c")`
    
2. Create a "full" data set merging the raw data uploaded

    First, the script combines the *train* and *test* data for each subset (main data, labels and subjects). For example:
    
    `data_train <- data_train %>% bind_rows(data_test)`
    
    Then it merges all the columns together with Dplyr's `bind_cols()` and links the activity label to its activity id with:
    
    `left_join(
    activity_labels, 
    by = c("activity_id" = "activity_id")
  )`
  
3. Create a new tidy data set with the average of each variable for each activity and each subject

    The script first groups the full set by *subject* and *activity* (`group_by()`) and then computes columns' mean for each sub-set (`summarise_all()`). The output is a tidy data set with one variable for each column and one observation for each row.
