#基本数据管理
#代码清单4-1
manager<-c(1:5)
date<-c("10/24/08","10/28/08","10/1/08","10/12/08","5/1/09")
country<-c("US","US","UK","UK","UK")
gender<-c("M","M","F","M","F")
age<-c(32,45,25,39,99)
q1<-c(5,3,3,3,2)
q2<-c(4,5,5,3,2)
q3<-c(5,2,5,4,1)
q4<-c(5,5,5,NA,2)
q5<-c(5,5,2,NA,1)
#由于当前R版本为4.3.2， stringsAsFactors = FALSE 为默认值，因此没有添加
leadership<-data.frame(manager,date,country,gender,age,q1,q2,q3,q4,q5)
leadership

#4.2 创建新变量
#代码清单4-2 创建新变量
mydata<-data.frame(x1=c(2,2,6,4),
                   x2=c(3,4,2,8))
#方法1
mydata1<-data.frame(x1=c(2,2,6,4),
                   x2=c(3,4,2,8))
mydata1$sumx<-mydata1$x1+mydata1$x2
mydata1$meanx<-(mydata1$x1+mydata1$x2)/2
mydata1

#方法2
mydata2<-data.frame(x1=c(2,2,6,4),
                    x2=c(3,4,2,8))
attach(mydata2)
mydata2$sumx<-x1+x2
mydata2$meanx<-(x1+x2)/2
detach(mydata2)
mydata2

#方法3
mydata3<-transform(mydata,
                   sumx=x1+x2,
                   meanx=(x1+x2)/2)
mydata3

#4.3变量的重编码
leadership$age[leadership$age==99]<-NA
leadership

#方法1
leadership1<-leadership
leadership1$agecat[leadership1$age>75]<-"Elder"
leadership1$agecat[leadership1$age>=55 &
                     leadership1$age<=75]<-"Middle Age"
leadership1$agecat[leadership1$age<55]<-"Young"
leadership1

#方法2
leadership2<-within(leadership,{
  agecat<-NA
  agecat[age>75] <-"Elder"
  agecat[age<=75 & age>=55]<-"Middle Age"
  agecat[age<55] <-"Young"
})
leadership2


#4.4变量的重命名
names(leadership)
names(leadership)[2]="testDate"
names(leadership)[2]
leadership

leadership1<-leadership
names(leadership1)[6:10]<-paste0("item",c(1:5))
leadership1

install.packages("plyr")
library("plyr")
leadership2<-rename(leadership,c(manager="managerID"))
leadership2


#4.5缺失值
#R语言除了缺失值NA (not available)，还有无穷大Inf和负无穷大-Inf,
#以及不可能的值NaN (not a number),还有未定义 NULL
y<-c(1:3,NA)
is.na(y)

#代码清单4-3 使用函数is.na
is.na(leadership[,6:10])

#4.5.2 在分析中排除缺失值
x<-c(1,2,NA,3)
y<-x[1]+x[2]+x[3]+x[4]
z<-sum(x)

y<-sum(x,na.rm = TRUE)

#na.omit函数，移除所有包含缺失值的观测
leadership
newdata<-na.omit(leadership)
newdata

#4.6日期值
#日期值导入后通常为字符类型，后续转换成数值型的日期格式
#默认的读取字符型日期数据的格式为yyyy-mm-dd
mydates<-as.Date(c("2007-06-22","2004-02-13"))
mydates                 
str(mydates)

strDates<-c("01/05/1965","08/16/1975")
datas<-as.Date(strDates,"%m/%d/%Y")
datas


myformat<-"%m/%d/%y"
leadership$date<-as.Date(leadership$date,myformat)
leadership

Sys.Date()
date()

today<-Sys.Date()
format(today,format="%B %d %y")
format(today,format="%A")

startDate<-as.Date("2004-02-13")
endDate<-as.Date("2011-01-22")
days<-endDate-startDate
days

today<-Sys.Date()
dob<-as.Date("1956-10-12")
difftime(today,dob,units="week")
format(dob,"%A")

#4.6.1将日期转换为字符型变量
dates<-Sys.Date()
dates

dates1<-format(dates,format="%m/%d/%Y")
dates1
str(dates1)


date2<-as.Date("12/13/14","%m/%d/%y")
date2

#as.character 日期转字符只有一种类型的字符结果，yyyy-mm-dd
strDates<-as.character(dates)
strDates


#4.7类型转换
a<-c(1,2,3)
a
is.numeric(a)
is.vector(a)

a<-as.character(a)
a

is.numeric(a)
is.vector(a)
is.character(a
             )

#4.8数据排序
leadership
newdata<-leadership[order(leadership$age),]
newdata

attach(leadership)
newdata<-leadership[order(gender,age),]
detach(leadership)
newdata

attach(leadership)
newdata<-leadership[order(gender,-age),]
detach(leadership)
newdata


#4.9数据集的合并
#4.9.1向数据框添加列
#merge函数等价于sql语句中的inner join
text1<-"
id a
1 a
2 b
3 c
"
text2<-"
id a b
3 d c
1 d d
1 d a
"

dataframe1<-read.table(text = text1,header = TRUE)
dataframe2<-read.table(text = text2,header = TRUE)
total<-merge(dataframe1,dataframe2,by="id")
total

#cbind要求行数相同
total1<-cbind(dataframe1,dataframe2)
total1

#4.9.2 向数据框添加行
dataframe3<-within(dataframe1,b<-"c")
#不知为何报错
total<rbind(dataframe3,dataframe2)

#4.10 数据集取子集
#4.10.1保留变量
myvars<-paste0("q",c(1:5))
newdata<-leadership[,myvars]
newdata

#4.10.2丢弃变量
#方法1
myvars<-names(leadership) %in% c("q3","q4")
newdata<-leadership[,!myvars]
newdata

#方法2
newdata1<-leadership[,c(-8,-9)]
newdata1

#方法3
newdata2<-leadership
newdata2$q3<-newdata2$q4<-NULL
newdata2

#4.10.3 选入观测
newdata<-leadership[1:3,]
newdata

newdata<-leadership[leadership$gender=="M" &
                      leadership$age>30,]
newdata

attach(leadership)
newdata1<-leadership[gender=="M" &
                       age>30,]
detach(leadership)
newdata1

str(leadership)

startDate<-as.Date("2009-01-01")
endDate<-as.Date("2009-10-31")
newdata<-leadership[which(leadership$date>=startDate &
                            leadership$date<=endDate),]
newdata

#4.10.4 subset() 函数
newdata<-subset(leadership,age>=35 |age<24,
                select = paste0("q",c(1:4)))
newdata

newdata<-subset(leadership,gender=="M" &age>25,
                select = gender:q4)
newdata


#4.10.5 随机抽样
mysample<-leadership[sample(1:nrow(leadership),3,replace=FALSE),]
mysample


#4.11使用SQL语句操作数据框
install.packages("sqldf")
library("sqldf")
newdf<-sqldf("select * from mtcars where carb=1 order by mpg",
             row.names = TRUE)
newdf

sqldf("select avg(mpg) as avg_mpg ,avg(disp) as avg_disp,gear
      from mtcars where cyl in (4,6) group by gear")


