library(dplyr)
x_train<-read.table("./train/x_train.txt")
y_train<-read.table("./train/y_train.txt")
sub_train<-read.table("./train/subject_train.txt")

x_test<-read.table("./test/x_test.txt")
y_test<-read.table("./test/y_test.txt")
sub_test<-read.table("./test/subject_test.txt")

variable_names<-read.table("features.txt")

activity_labels<-read.table("activity_labels.txt")

x_total<-rbind(x_train,x_test)
y_total<-rbind(y_train,y_test)
sub_total<-rbind(sub_train,sub_test)

selected_var<-variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
x_total<-x_total[,selected_var[,1]]

colnames(y_total)<-"activity"
y_total$activitylabel<-factor(y_total$activity,labels=as.character(activity_labels[,2]))
activitylabel<-y_total[,-1]


colnames(x_total)<-variable_names[selected_var[,1],2]

colnames(sub_total)<-"subject"
total<-cbind(x_total,activitylabel,sub_total)
total_mean<-total %>% group_by(activitylabel,subject) %>%summarise_each(funs(mean))
write.table(total_mean,file="tidydata.txt",row.names=FALSE,col.names = TRUE)

