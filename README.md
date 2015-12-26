## README file for the Getting and Cleaning Data Course Project

To carry out the analysis required for this CourseProject I have created a R script named: "run_analysis.R"

The main steps of the analysis are explained below.

## Importing Data

The first thing we have to do is import data into R. It is assumed that the .txt raw files are in the working directory.

I read the 'X_test.txt' and 'X_train.txt' files using read.table. After that both are merged to obtain the whole raw dataset. The merging process is done using rbind(). This dataset is in the variable 'X_merge'.

Now, we read the 'features.txt' files that contains the names of the columns of the raw Dataset. These names are saved in the variable 'columnNames'. Once changed to the right format (vector) we associate them as the names of the columns of 'X_merge'.

To finish the importing data process we read the 'y_test.txt', 'y_train.txt', 'subject_test.txt' and 'subject_train.txt' files that contain the information about the activity they measured and the person who did the activity.

We proceed in the same way as we did with 'X_test.txt' and 'X_train.txt', once read they are merged getting two variables 'Activity' and 'Subjects'

Using 'cbind()' we combine X_merge with Activity and Subjects getting the complete raw Data set, saved in the variable 'DataSet'.

## Extracting mean and std columns

In this part of the script we want to extract specific columns that contains information about the mean and std values. To do that we use 'grepl()'. This function look for 'mean()' and 'std()' in the column names of DataSet reporting a logical (TRUE/FALSE) vector.

With these logical vectors we subset the original 'DataSet' obtaining two different ones. 'DataSetMean' and 'DataSetStd', both are combine to get 'DataSetMeanStd'.

## Creating independent dataset.

The final step consists on creating a new data set with the average of each variable for each activity and each subject. To do that we create a nested for loop going trough all the subjects (1:30) and all the activities (1:6) per subject. 

For each iteration we take a new subset attending the Subject and the Activity developed (Subset2) from this subset we have to determine the mean value of eache column, we do that using the apply() function. Each iteration generates a new row with the mean values, this row is combined with the previuos one creating the wanted dataset ('NewSubset').

To initialize 'NewSubset' we include as the first row a vector full of zeros. When the NewSubset is complete, this first row is deleted.

Finally we change the Activity identifiers by the real activity names, after that we edit the column names to indicate that all are Mean values.

The last step consist on saving the 'NewSubset' data frame as FinalDataSubsetScript.txt file using write.table(...,row.names=FALSE).



