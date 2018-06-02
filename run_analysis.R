#Getting Data Course: Final Assignment
library(dplyr)

#step 1: merge training and test sets to create one dataset
#-------------------------------------------------------------
#Collect feature names to use as column names
featurenames<-read.table("./UCI HAR Dataset/features.txt",sep=" ",header=FALSE,colClasses = "character")

#Read in training data
trainx<-read.fwf("./UCI HAR Dataset/train/X_train.txt",c(17,rep(16,560)),col.names=featurenames[,2])
trainy<-read.csv("./UCI HAR Dataset/train/y_train.txt",sep=" ",header=FALSE,col.names="activity")
trainsubs<-read.csv("./UCI HAR Dataset/train/subject_train.txt",sep=" ",header=FALSE,col.names="subject")

#Read in test data
testx<-read.fwf("./UCI HAR Dataset/test/X_test.txt",c(17,rep(16,560)),col.names=featurenames[,2])
testy<-read.csv("./UCI HAR Dataset/test/y_test.txt",sep=" ",header=FALSE,col.names="activity")
testsubs<-read.csv("./UCI HAR Dataset/test/subject_test.txt",sep=" ",header=FALSE, col.names="subject")

#Collapse training and test data (Mean and SD only; Step 2 included here)
relevantmeasures<-sort(c(grep("mean\\.",names(trainx)),grep("std",names(trainx))))
trainingdata<-cbind(trainsubs,trainy,trainx[relevantmeasures])
testdata<-cbind(testsubs,testy,testx[relevantmeasures])

#Merge training and test data, order by subject then activity
merged<-arrange((rbind(trainingdata,testdata)),subject,activity)

#Remove raw dataframes to save memory
rm(featurenames,testsubs,testx,testy,trainsubs,trainx,trainy,relevantmeasures,testdata,trainingdata)


#step 2: subsetting mean and std variables occurs above
#-------------------------------------------------------

#step 3: use descriptive activity names to name the activities in the dataset
#----------------------------------------------------------------------------
merged$activity[merged$activity == 1] <- "walking"
merged$activity[merged$activity == 2] <- "upstairs"
merged$activity[merged$activity == 3] <- "downstairs"
merged$activity[merged$activity == 4] <- "sitting"
merged$activity[merged$activity == 5] <- "standing"
merged$activity[merged$activity == 6] <- "laying"


#step 4: appropriately label the dataset with the descriptive variable names
#----------------------------------------------------------------------------
#variables names were imported during step 1
#below, I simply clean them up
names(merged)<-gsub("\\.","",names(merged))
#fixing the typographical error in the original dataset variable names
names(merged)<-sub("BodyBody","Body",names(merged))


#step 5: from the dataset in step 4, create a second independent, tidy dataset
# with the mean of each variable for each activity and each subject
#----------------------------------------------------------------------------
tidy<-group_by(merged,subject,activity)
tidy<-summarize_all(tidy,mean)
write.table(tidy,file="tidydata.txt", row.names=FALSE)