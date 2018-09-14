#week6. linear regression

library(dplyr)
library(ggplot2)

setwd('C:/Users/HS/Documents/GitHub/2018summerBoAZ/homework/6주차 과제')

sales<-read.csv('sales.csv')
multiple<- read.csv('multiple.txt',sep='')
str(sales);str(multiple)

#1
sales %>% ggplot(aes(x,y)) + geom_point()

lr <- lm(y~x, sales)
lr
#yhat = -17.891 + 2.481x

summary(lr)
#p-value: 2.426e-08
#유의수준 0.05 하에서 회귀식이 유의하다다


#2
multiple %>% ggplot(aes(x1,y))+geom_point()
multiple %>% ggplot(aes(x2,y))+geom_point()


lr2<- lm(y~., multiple)
lr2
#yhat= 62.39738 + 0.74071x1 -0.08067x2

summary(lr2)
# p-value: 6.774e-06  
# 유의수준 0.05 하에서 회귀식 유의

step(lr2)
# y~x1
step(lr2, direction="forward")
# y~x1+x2
step(lr2, direction="both")
#y~ x1