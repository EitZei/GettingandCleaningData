This repository contains the course project assignment for Courseras Getting and Cleaning Data course.

Please refer to the Coursera course page for assignment details.

# Content

The repository contains the following directories and files:
- `UCI_HAR_Dataset` the original data set on which the analysis is based on
- `run_analysis.R` the script that does the data cleaning and analysis (see Script for details)
- `CodeBook.md` that describes the data product `average_by_activity_and_subject.txt`
- `average_by_activity_and_subject.txt` the data product

# Script

On high level the script:
- Reads the category and data files from the original data sets
- Combines, filters and mutates the data as the assignment instructs
- Creates a new data product as described in `CodeBook.md`

Further details are embedded in the comments in the script.

Script can be run with e.g. `RScript run_analysis.R` and it produces table formatted file called `average_by_activity_and_subject.txt`.
