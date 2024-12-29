#第2章：创建数据集
#R语言大小写敏感

#2.1
#R语言的数据有以下的类型(模式)
#字符型，数值型，逻辑型(TRUE/FALSE)、复数型(虚数)、原生型(字节)

#R语言有以下的数据结构
#向量、矩阵、数组、数据框、列表

#2.2.1向量
#向量中的每个数据必须要相同的类型或模式
a<-c(1,2,5,3,6,-2,4)
b<-c("one","two",'three')
c<-c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)
c

a<-c("K","J","H","A","C","M")
a[3]
a[c(1,3,5)]
a[c(2:6)]


class(a)
mode(a)
str(a)

#2.2.2矩阵
#矩阵和向量一样，里面的数据只能是相同的类型
#代码清单2-1
y<-matrix(c(1:20),nrow = 5,ncol = 4,byrow = TRUE)
y
cells <-c(1,26,24,68)
rnames<-c("R1","R2")
cnames<-c("C1","C2")
mymatrix<-matrix(cells,nrow = 2,ncol = 2,
                  dimnames = list(rnames,cnames),
                  byrow = FALSE)
mymatrix
mymatrix<-matrix(cells,nrow = 2,ncol = 2,
                 dimnames = list(rnames,cnames),
                 byrow = TRUE)
mymatrix
class(mymatrix)
mode(mymatrix)
str(mymatrix)

#代码清单2-2
x<-matrix(1:20,nrow=2)
x
x[2,]
x[,2]
x[1,4]
x[1,c(4,5)]

#2.2.3 数组
#维度>2的向量或数组
#代码清单2-3
dim1<-c(paste("A",c(1,2),sep=""))
dim1
dim2<-c(paste("B",c(1:3),sep=""))
dim3<-c(paste("C",c(1:4),sep=""))

z<-array(c(1:24),c(2,3,4),dimnames = list(dim1,dim2,dim3))
z
class(z)
mode(z)
str(z)

dim4<-c(paste("D",c(1:2),sep=""))
z1<-array(1:48,c(2,3,4,2),dimnames = list(dim1,dim2,dim3,dim4))
z1

#2.2.4   数据框
#代码清单2-4 创建一个数据框
patientID<-c(1,2,3,5)
age<-c(25,34,28,52)
diabetes<-c(paste0("Type",c(1,2,1,1)))
status<-c("poor","imporve","excellent","poor")
patientdata<-data.frame(patientID,age,diabetes,status)
patientdata

class(patientdata)
mode(patientdata)
str(patientdata)

#代码清单2-5 获取数据库中的元素
patientdata[1:2]
patientdata[c("patientID","age")]
patientdata$age
str(patientdata)

table(patientdata$diabetes,patientdata$status)


summary(mtcars$mpg)
plot(mtcars$mpg,mtcars$disp)
plot(mtcars$mpg,mtcars$wt)


#等价于
attach(mtcars)
plot(mpg,disp)
plot(mpg,wt)
detach(mtcars)


#存在问题：如果当前会话有自定义一个对象和mtcars数据框中的变量一致，
#会优先考虑对象，而不是数据框中的变量
#for example
mpg<-c(25,36,47)

attach(mtcars)
plot(mpg,disp)
plot(mpg,wt)
detach(mtcars)


#因此可以使用with 函数

with(mtcars,{
  plot(mpg,disp)
  plot(mpg,wt)
})


#但是存在一个问题，就是with函数中的<-（赋值语句）仅仅在with函数中有效,
#出了with函数是无效的
#for example
with(mtcars,{
    stats<-summary(mpg)
    stats
    str(stats)
})
stats

#但是可以使用特殊赋值符>>-,替代标准赋值符，即可保留到全局环境
with(mtcars,{
    nokeepstats<-summary(mpg)
    keepstats<<-summary(mpg)
})
nokeepstats
keepstats
str(keepstats)

#实例标识符
patientdata1<-data.frame(patientID,age,diabetes,status,row.names=patientID)
patientdata
patientdata1


#2.2.5 因子
diabetes<-c(paste0("Type",c(1,2,1,1)))
status<-c("poor","improve","excellent","poor")
status
status<-factor(status,ordered = TRUE,levels = c("poor","improve","excellent"))
status

sex<-c(1,2,1,1)
sex
sex<-factor(sex,levels = c(1,2),labels = c("male","female"))
sex


#代码清单2-6 因子的使用

patientID<-c(1,2,3,5)
age<-c(25,34,28,52)
diabetes<-c(paste0("Type",c(1,2,1,1)))
status<-c("poor","imporve","excellent","poor")
diabetes<-factor(diabetes)
status<-factor(status,ordered = TRUE)
patientdata<-data.frame(patientID,age,diabetes,status)
patientdata
str(patientdata)
summary(patientdata)

#2.2.6 列表
#列表中的元素可以是任何数据结构，包括列表本身
#代码清单2-7 创建一个列表
g<-"My First List"
h<-c(25,26,18,39)
j<-matrix(c(1:10),nrow = 5)
k<-c("one","two","three")
mylist<-list(title=g,age=h,j,k)
mylist

mylist[[2]]
mylist[["age"]]
mylist$age

class(mylist)
mode(mylist)
str(mylist)

#2.3.1使用键盘输入数据
mydata<-data.frame(age=numeric(),
                   gender=character(),weight=numeric())
mydata
mydata<-edit(mydata)
mydata

fix(mydata)
mydata

#程序中嵌入数据集
mydatatxt<-"
age gender weight
25 m 166
10 f 115
18 f 120
"
mydata<-read.table(header = TRUE,text = mydatatxt)
mydata

#2.3.2 从带分隔符的文本文件导入数据
install.packages("rstudioapi")
#获取当前脚本的路径
path<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)
grades<-read.table("studentgradeS.csv",row.names="Studyid",header=TRUE,sep=",")
grades
str(grades)


grades<-read.table("studentgradeS.csv",row.names="Studyid",header=TRUE,sep=","
                  ,colClasses = c("character","character","character",
                                  "numeric","numeric","numeric"))
grades

str(grades)

#2.3.7导入sas数据
#1.Hmisc 中的sas.get
install.packages("Hmisc")
help("sas.get",package = "Hmisc")
datadir<-"D:\\sashome\\SASFoundation\\9.4\\nls\\zh\\sashelp"
sasexe<-"D:\\sashome\\SASFoundation\\9.4\\sas.exe"
library("Hmisc")
mydata<-sas.get(libraryName=datadir,member="class",sasprog=sasexe,defaultencoding = "gb2312")
#读入后的代码是乱码，不知道为什么
mydata

#2.sas7bat中的read.sas7bat
install.packages("sas7bat")
#当前R版本不可用
library("sas7bat")
mydata<-read.sas7bat(paste0(datadir,"\\","class.sas7bat"))

#2.4.1变量标签
names(patientdata[2])="Age in hospitalization (in years)"
names(patientdata[2])
patientdata

#2.4.2
patientdata$gender<-c(1,2,1,1)
patientdata$gender<-factor(patientdata$gender,levels=c(1,2),
                           labels = c("male","female"))
patientdata$gender

ls()

class(patientdata)
mode(patientdata)
str(patientdata)

dim(a)
dim(mymatrix)
dim(z)
dim(patientdata)
dim(mylist)

length(a)
length(mymatrix)
length(z)
length(patientdata)
length(mylist)

ls()
rm(age)
ls()

head(a)
head(mymatrix)
head(z)
head(patientdata)
head(mylist)

age<-c(1:16)
age
head(age)
tail(age)

head(age,n=8)

rm(list=ls())
