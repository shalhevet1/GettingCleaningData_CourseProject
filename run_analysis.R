
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "zipData.zip")
unzip("zipData.zip")

features<-read.table("UCI HAR Dataset/features.txt")
var_names<-features$V2

activities<-read.table("UCI HAR Dataset/activity_labels.txt")
names(activities)<-c("activity","activity_class")

# test files
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
activity_test<-read.table("UCI HAR Dataset/test/y_test.txt")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")

names(activity_test)<-c("activity")
names(test_subject)<-c("subject")
names(xtest)<-var_names
testData<-cbind(test_subject,activity_test,xtest)
rm(test_subject,activity_test,xtest)

# train files
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
activity_train<-read.table("UCI HAR Dataset/train/y_train.txt")
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")

names(activity_train)<-c("activity")
names(train_subject)<-c("subject")
names(xtrain)<-var_names
trainData<-cbind(train_subject,activity_train,xtrain)
rm(train_subject,activity_train,xtrain)

# step 1- merging test and train data
allData<-rbind(testData,trainData)

# step 2- Extracting only mean and standard deviation for each measurement
allData<-allData[,grep("mean()|std()|activity|subject",names(allData))]
allData<-allData[,grep("meanFreq",names(allData), invert=TRUE)]
allData<-tbl_df(allData)

# step 3- adding descriptive activity names 
allData<-merge(activities,allData, by= "activity", all = TRUE)
allData<-allData %>% select(3,2,1,4:69) %>% arrange(subject,activity)

# step 4- labeling the data set with descriptive variable names
names(allData)<-gsub("mean\\()","Mean",names(allData))
names(allData)<-gsub("std\\()","Std",names(allData))
names(allData)<-gsub("-|_","",names(allData))

# step 5- summary each variable for each activity and each subject
summaryTable<- allData %>% 
        gather(parameter,value,-(subject:activity)) %>%
        select(-activity) %>%
        group_by(subject, activityclass, parameter) %>%
        summarise(meanVal=mean(value, na.rm = TRUE)) %>%
        spread(parameter,meanVal)

rm(allData, features, var_names, activities, testData, trainData)