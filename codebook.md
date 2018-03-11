# Codebook
1.	Downloading zip file, reading the text files and assigning them variables
2.	testData- combined table of the test measurement results, the subjects’ IDs and the 6 activities identifiers (numbers 1-6)
3.	trainData- combined table of the train measurement results, the subjects’ IDs and the 6 activities identifiers (numbers 1-6)
4.	Combining the test and train data into a single table- allData
5.	Manipulating allData to create a tidy data table:
a.	Extracting only columns that contain mean and standard deviation measurements of each variable
b.	Excluding columns of meanFreq measurements as they are not representing an average measurement of a variable.
c.	Adding the activity classes to the numbers representation of the activities- this column is called activityclass
d.	Labeling the data set with descriptive variable names by excluding “()”,”-“, and “_” and capitalizing.
6.	Create the final summary table called summaryTable:
a.	Stack allData table so that all the different measurements are in one column called parameters. The value column contains the measurement results for each one of the parameters.
b.	Grouping the table by subject, activity class and parameter.
c.	Calculating the mean value of each parameter for each subject and activity in a temporal column called meanVal.
d.	Split the table so that each parameter (or variable) is in a separate column. meanVal  is being spread among the multiple columns.
7.	summaryTable includes the subject column for each subject number, activityclass column for each activity type, and all the other columns contain the average calculation of each mean and std result from the original dataset, by subject and activity class.
8.	Finally, remove all temporal variables and tables to clear memory space.
