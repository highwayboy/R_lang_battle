x=rnorm(5)
x

#代码清单 1-1
age<-c(1,3,5,2,11,9,3,9,12,3)
weight<-c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
mean(weight)
sd(weight)
cor(age,weight)
plot(age,weight)

demo()

demo(package = .packages(all.available = TRUE))

demo(persp)

demo(image)

#R中的帮助函数
help.start()

help("foo")

help.search('foo')

example('foo')

RSiteSearch('foo')

apropos("foo",mode = "function")

data()

vignette()


vignette("foo")

#获取工作目录
getwd()

#设置工作目录
setwd("d:/")

setwd("c:/users/zhoushulian/documents")

ls()

rm("fcol")
rm("age")

options()


history(20)

savehistory("d:/history.txt")
loadhistory("d:/history.txt")
save.image("d:/test.rdata")
load("d:/test.data")

save(i1,file="d:/a.txt")
i1


#代码清单1-2
setwd("d:/")
options()
options(digits = 3)

x<-runif(20)
x
summary(x)

hist(x)


#在当前工作目录下新建aaaa文件夹
dir.create("aaaaa")

#使用source()
filepath <- "D:/学习资料与作业/工作/外企德科&sainofi/资料/R语言/书籍代码/1.R语言实战"
files<-paste(filepath,"script1.r",sep="/")
source(files)




#测试sink()和pdf() 以及 dev.off()的用法
filepath <- "D:/学习资料与作业/工作/外企德科&sainofi/资料/R语言/书籍代码/1.R语言实战"
files<-paste(filepath,"script1.r",sep="/")
sink("myoutput.log",append=TRUE ,split=FALSE)
pdf("mygraphs.pdf")

source(files)
age
#使用sink("xx")和pdf("xx")后，一定要再使用sink()和dev.off()改回来，不然文件和图片会被锁定
sink()
dev.off()


#libPaths() 获知包的路径,执行失败，可能是版本的问题
libPaths("base")

#library() 获知有哪些包
library()

#检测当前会话可用的包有哪些
search()


#安装包
#安装过程中出现当前WARNING，需要安装对于的Rtool
#WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
#.libPaths()获取library所在的位置
.libPaths()
install.packages("glus")
install.packages("outlier")
install.packages("jsonlite")

#列出安装的包的信息
installed.packages()

#查看指定的包的基本信息
help(package="base")
help(package="ggplot2")
#加载包
library("glus")

#删除包
remove.packages("jsonlite")
installed.packages()


#结果的重用
mtcars
#查看数据集的描述
help(mtcars)
lm(mpg~wt,data=mtcars)
lmfit<-lm(mpg~wt,data=mtcars)
lmfit

summary(lmfit)

plot(lmfit)

cook<-cooks.distance(lmfit)
cook
plot(cook)

#运行mtcars自带的示例代码
example(mtcars)


