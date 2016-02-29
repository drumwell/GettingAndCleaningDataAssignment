A description of the variables
====================
Please refer to the file "./UCI HAR Dataset/features_info.txt" for a full and detailed description of all variables in the raw data set. 

The tidy set has undergone the following transformations:
- for each of the test and training data sets, the subjects, activities and features have been combined into a single data frame
- the test and training data frames were then combined into a merged data frame
- the merged data frame was trimmed to columns containing the subject, activity, and all measurements representing mean and standard deviation calculations (mean() and std(), respectively)
- the data set was updated to clean up some column naming


The data
====================
- the fully merged and trimmed data output can be found in extracted_data.txt after running run_analysis.R
- averaged values, grouped by subject and activity, can be found in averaged_data.txt after running run_analysis.R


Transformations/work performed to clean up the data
====================
See the description above for the transformations performed to clean up the data. The script is also well-commented, outlining at each stage of operation what specific transformation is occuring. Self-documenting code FTW. :) 