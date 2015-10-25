# Getting-and-Cleaning-Data
Project Assignment for Peer Assessment

Script will load Training and Test Data into 3 variables for Data (mergeData), Labels (mergeLabels),
and Subject (mergeSubject).  These core datasets will be manipulated to result into output files
cleaned_data.txt and Summary_Data_Means.txt

After the files are merged into the variables mentioned above, the features.txt file is read to narrow
the variables for mean and standard deviation and the activity.txt file is read to label the activities
in the dataset.

Variables are standardized to tidy data (cleanedData), then output is written to cleaned_data.txt file.

Cleaned data is then summarized by Subject and Activity with the mean for every variable present into a 
Dataset (cleanedGroup) and finally the output is written to Summary_Data_Means.txt.





