
#代码清单5-6 示例的一种解决方案
rm(list=ls())
options(digits = 2)
student<-c("John Davis","Angela Williams","Bullwinke Moose","David Jones",
           "Janice Markhammer","Cheryl Cushing","Reuven Ytzrhak","Greg Knox",
           "Joel England","Mary Rayburn")
math<-c(502,600,412,358,495,512,410,625,573,522)
science<-c(95,99,80,82,75,85,80,95,89,86)
english<-c(25,22,18,15,20,28,15,30,27,18)
roster<-data.frame(student,math,science,english)
roster

z<-scale(roster[,2:4])
z

score<-apply(z, 1, mean)
score

roster<-cbind(roster,score)
roster

y<-quantile(score,c(.8,.6,.4,.2))
y

roster$grade[score>=y[1]]<-"A"
roster$grade[score<y[1] & score>=y[2]]<-"B"
roster$grade[score<y[2] & score>=y[3]]<-"C"
roster$grade[score<y[3] & score>y[4]]<-"D"
roster$grade[score<y[4]]<-"F"

name<-strsplit(roster$student," ")
name
###########################################
lastname<-sapply(name, "[",2)
firstname<-sapply(name, "[",1)


#########################################

roster<-cbind(firstname,lastname,roster[,-1])
roster

roster<-roster[order(lastname,firstname),]
roster


#5.6.1转置

#代码清单 5-9 数据集的转置
cars<-mtcars[1:5,1:4]
cars
t(cars)


#5.6.2 整合数据
#代码清单5-10 整合数据
options(digits = 3)
attach(mtcars)
aggdata<-aggregate(mtcars,by=list(Group.cyl=cyl,Group.gear=gear),FUN=mean,na.rm=TRUE)
detach(mtcars)
aggdata
dropvar<-names(aggdata) %in% c("cyl","gear")
aggdata[,!dropvar]

#5.6.3 reshape2包
install.packages("reshape2")
library("reshape2")

id<-c(1,1,2,2)
time<-c(1,2,1,2)
x1<-c(5,3,6,2)
x2<-c(6,5,1,4)

mydata<-data.frame(id,time,x1,x2)
mydata

md<-melt(mydata,id=c("id","time"))
md

dcast(md,id~variable,mean)
dcast(md,time~variable,mean)
dcast(md,id~time,mean)

dcast(md,id+time~variable)
dcast(md,id+variable~time)
dcast(md,id~variable+time)
