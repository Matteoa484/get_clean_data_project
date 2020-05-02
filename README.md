# get_clean_data_project
Coursera Getting &amp; Cleaning Data - week 4 assignment

This README is part of the final assignment of the "Getting and Cleaning Data" course by Johns Hopkins University on Coursera.
The goal of the project is 1) to write a script that clean and merge different data sets and which 2) create a new tidy data set after computing some transformations, and 3) write a Code Book that describes the variables, the data and any transformations performed.

Almost all the work in the script is done with different packages which are part of the core "tidyverse", in particular:
- Readr: compared to base read.tbale, it doesn't need the "StringsAsFactors = FALSE" and it's easier to create column names (col_names) and specific column parsing (col_type)
- Dplyr: it a grammar of data manipulation, that that through specific verbs perform all the most important data manipulation
- Stringr
- Tibble
- Tidyr
- Magrittr
