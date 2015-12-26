## CourseProject Getting and Cleaning Data 

## Reading X_test and X_train

X_test<-read.table('X_test.txt')
X_train<-read.table('X_train.txt')

## Merging both datasets

X_merge<-rbind(X_test,X_train)

## Extracting the features (column names)

columnNames<-read.table('features.txt')

## Changing columnNames from column format to row format

columnNames<-t(columnNames[2])

## Change class(columnNames) from 'matrix' to 'vector'

columnNames<-as.vector(columnNames)

## Setting the names of the columns with columnNames

colnames(X_merge)<-columnNames

## Reading y_test.txt / y_train.txt and merging

y_test<-read.table('y_test.txt')
y_train<-read.table('y_train.txt')
Activity<-rbind(y_test,y_train)
colnames(Activity)<-c('Activity')

## Reading subject_test.txt / subject_train.txt and merging

subjectTrain<-read.table('subject_train.txt')
subjectTest<-read.table('subject_test.txt')
Subjects<-rbind(subjectTest,subjectTrain)
colnames(Subjects)<-c('Subject')

## Merging X_merge with Activity and Subjects to create DataSet

DataSet<-cbind(X_merge,Activity,Subjects)

## Now we extract the columns attending to mean() and std() values
## and merge them with Activity and Subjects columns.

DataSetMean<-DataSet[,grepl('mean()',names(DataSet))]
DataSetStd<-DataSet[,grepl('std()',names(DataSet))]
DataSetMeanStd<-cbind(DataSetMean,DataSetStd,Activity,Subjects)

## Creating Descriptive variable names

NewNames<-gsub("Acc","Accelerometer",names(DataSetMeanStd))
NewNames<-gsub("Gyro","Gyroscope",NewNames)
colnames(DataSetMeanStd)<-NewNames

## Creating independent dataset

NewSubset<-rep(0,81) ##Initialize NewSubset



for (i in 1:30){

for (j in 1:6){

goods<-DataSetMeanStd$Subject==i
Subset<-DataSetMeanStd[goods,]
goods2<-Subset$Activity==j
Subset2<-Subset[goods2,]


NewSubset<-rbind(NewSubset,apply(Subset2,2,mean))

}
}

## Delete first row

NewSubset<-NewSubset[-1,]
NewSubset<-as.data.frame(NewSubset)


## Replace Activity number --> Activity label.

ActivityNames<-gsub("1","Walking",NewSubset$Activity)
ActivityNames<-gsub("2","Walking Upstairs",ActivityNames)
ActivityNames<-gsub("3","Walking Downstairs",ActivityNames)
ActivityNames<-gsub("4","Sitting",ActivityNames)
ActivityNames<-gsub("5","Standing",ActivityNames)
ActivityNames<-gsub("6","Laying",ActivityNames)

## Replacing Activity column by the new ActivityNames column

NewSubset$Activity<-ActivityNames

## Add Descriptive info.

NewNames<-paste(names(NewSubset),".MeanValue",sep="")
NewNames[80]<-"Activity"
NewNames[81]<-"Subject"

## Set new column names to NewSubset

colnames(NewSubset)<-NewNames

## Save data

write.table(NewSubset,'FinalDataSubsetScript.txt',row.name=FALSE)
