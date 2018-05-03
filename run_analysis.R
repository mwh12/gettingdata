> #download the file and unzip
> if(!file.exists("./data")){dir.create("./data")}
> download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="./data/myds.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> unzip(zipfile="./data/myds.zip",exdir="./data")
> #reading the text files
> test_subject<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
>  test_y<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
> test_x<-read.table("./data/UCI HAR Dataset/test/x_test.txt")
> train_subject<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
> train_y<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
> train_x<-read.table("./data/UCI HAR Dataset/train/x_train.txt")
> combined_test<-cbind(test_subject,test_y)
> combined_train<- cbind(train_subject,train_y)
> merged_two<-rbind(combined_train,combined_test)
> merged_x <-rbind(train_x,test_x)
> #features file
> features <- read.table('./data/UCI HAR Dataset/features.txt')
>  colnames(merged_x)<-features[,2]
> merged_all<-cbind(merged_two,merged_x)
> #Extracts only the measurements on the mean and standard deviation for each measurement. 
> subset_ds<-merged_all[, grepl("mean()|std()", features[, 2])]
> #give names to columns
> colnames(subset_ds)[1]="Subject Id"
> colnames(subset_ds)[2]="Activity"
> #read activity labels file
> activitylabels =read.table('./data/UCI HAR Dataset/activity_labels.txt')
> colnames(activitylabels)[1]="Activity"
> subset_ds2<-merge(activitylabels,subset_ds,by="Activity")
            
> colnames(subset_ds2)[2]="Activity_id"

> library(plyr)
Warning message:
package ‘plyr’ was built under R version 3.4.4 


>  Data2<-aggregate(. ~ Subject + Activity ,subset_ds2,mean)
> write.table(Data2, file = "tidydata.txt",row.name=FALSE)
