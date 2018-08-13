install.packages("ggplot2")
library(ggplot2)
head(mtcars)
#1-4
p<-ggplot(data=mtcars, aes(wt, mpg, cyl))
p
#1-5
p<- ggplot(mtcars, aes(x=factor(cyl), fill=factor(cyl)))
p<- p+ geom_bar(width= .5)
p<- p+facet_grid(.~gear)
p

#1-6
p<- ggplot(mtcars , aes(wt,mpg))
p<- p+geom_point()
p

p<-p+geom_smooth(method = 'loess')
p

#2-1
qplot(mtcars$wt, mtcars$mpg)
ggplot(mtcars, aes(wt, mpg)) +geom_point()

qplot(mtcars$wt, mtcars$mpg, geom='point')
qplot(wt,mpg, data=mtcars, geom='point')

#2-2
#2-2-1
p <- ggplot(data = mtcars, aes(x=wt, y= mpg)) 
p + geom_point(colour="orange", size = 6)
p <- ggplot(data = mtcars, aes(x=wt, y= mpg)) 
p + geom_point(aes(colour=cyl, size=gear))

#2-2-2
p <- ggplot(mtcars, aes(factor(cyl))) 
p <- p + geom_bar()
p

p <- ggplot(mtcars, aes(factor(cyl))) 
p <- p + geom_bar(aes(fill=cyl), colour="black" )
p

p <- ggplot(mtcars, aes(factor(cyl))) 
p <- p + geom_bar(aes(fill=factor(gear))) 
p

#2-2-3



#2-2-
library(dplyr)
library(ggplot2)
getwd()
setwd("C://Users//HS//Desktop")
data<- read.csv("yunsikus.csv")

str(data)
names(data)
table(data$year)
table(data$place)
table(data$strong)
table(is.na(data))
summary(data$strong)


#
p1<- data %>% ggplot(aes(x=place))+geom_bar() +facet_wrap(.~year); p1
p2<- data %>% ggplot(aes(x=year))+geom_bar() +facet_wrap(.~place); p2
p3<- data %>% ggplot(aes(x=year , y=strong, colour= strong))+ geom_boxplot() +facet_wrap(.~place); p3
p4<- data %>% ggplot(aes(x=year , y=strong, colour= strong))+ geom_violin() +facet_wrap(.~place)+ geom_jitter(col="gray"); p4
p5<- data %>% ggplot(aes(year, strong))+ geom_jitter(col="gray")+ geom_boxplot(alpha=.5) + facet_wrap(.~place); p5

#?group_by()

data %>% group_by(place) %>%summarise(n=n())
data %>% ggplot(aes(year, strong, colour= place)) +geom_line() 
data %>% ggplot(aes(year, strong, colour= place)) +geom_line() +facet_wrap(.~place)

df2<- data %>% group_by(place,year) %>% summarize(mean_strong=mean(strong)); df2
df2 %>% ggplot(aes(year, mean_strong)) + geom_bar(stat="identity") +facet_wrap(.~place)
df2 %>% ggplot(aes(year, mean_strong)) + geom_line(stat="identity") +facet_wrap(.~place)
df2 %>% ggplot(aes(year, mean_strong)) + geom_smooth(stat="identity") +facet_wrap(.~place)

df3<- data %>% group_by(year,place) %>% summarize(mean_strong=mean(strong)); df3
df3 %>% ggplot(aes(place, mean_strong)) +geom_bar(stat="identity")

data %>% ggplot(aes(place, strong, colour= year)) +geom_bar(stat="identity")+ facet_wrap(.~year)
data %>% ggplot(aes(place, fill=year)) +geom_bar(position= 'dodge')






###APPLE 주식
#주식 정보를 가져올 수 있는 패키지 quantmod 설치 #install.packages("quantmod") 
library(quantmod) 

#Apple의 주식 정보 가져오기
getSymbols("AAPL",from=as.Date("2017-10-01"),to=as.Date("2017-10-31")) 

# plot creation 
p <- ggplot(AAPL, aes(x=index(AAPL), y=AAPL.Close))

# ribbon plot 생성 
p <- p + geom_ribbon(aes(min=AAPL.Low, max=AAPL.High),fill="lightblue",colour="black") 

# 종가를 점으로 표현 
p <- p + geom_point(aes(y=AAPL.Close),colour="black",size=5) 

# 종가를 잇는 선 그림 
p <- p + geom_line(aes(y=AAPL.Close),colour="blue") 

# stat_smooth 추가 (빨간색 선) 
p <- p + stat_smooth(method="loess",se=F,colour="red",lwd=1.2)

# 종가를 그래프에 점 위에 표시 
p <- p + geom_text(aes(y=AAPL.Close+2.5,label=round(AAPL.Close,1)),size=3,hjust=0,colour="blue") 
p

install.packages("plotly") 
library(plotly)

ggplotly(p)


