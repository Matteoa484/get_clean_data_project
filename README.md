# get_clean_data_project
## Coursera Getting &amp; Cleaning Data - week 4 assignment

This README is part of the final assignment of the "Getting and Cleaning Data" course by Johns Hopkins University on Coursera ([link](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project)).
The goal of the project is 1) to write a script that clean and merge different data sets and which 2) creates a new tidy data set after computing some transformations, and 3) write a Code Book that describes the variables, the data and any transformation performed.

The Githu repo contains:
1. This README file
2. A script, run_analysis.R, the does all the tasks required
3. A Code Book with the information on all the variables and summaries calculated

Most of the work in the script is done with packages from the core *"tidyverse"*, in particular:
- **Readr**: compared to base read.table, it doesn't need the "StringsAsFactors = FALSE" and it's easier to create column names (col_names) and specific column parsing (col_type)
- **Dplyr**: it's a grammar of data manipulation, which through specific verbs performs all the main data manipulations with an easy-to-read code
- **Stringr**:
- **Tibble**: a data.frame which prints better on the console
- **Tidyr**:
- **Magrittr**: pipe (%>%) operator

### run_analysis
The scrip is divided in three sections:
1. Upload raw data from the folder UCI HAR ([link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip))
    
    test
    
2. Create a "full" data set merging the different parts and filtering for the columns on the mean and standard deviation
3. Create a new tidy data set with the average of each variable for each activity and each subject
