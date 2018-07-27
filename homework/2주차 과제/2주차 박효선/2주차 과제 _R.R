#2주차 과

setwd("C:/Users/HS/Documents/GitHub/2018summerBoAZ/homework/2주차 과제/R")


#1. 주어진 벡터 kor, mat, eng를 column으로 갖는 dataframe grade를 만들라

kor <- c(8,6,9,4,5,5,4,10,7,7)
mat <- c(7,5,4,5,8,9,7,10,5,7)
eng <- c(2,7,9,7,9,6,10,9,4,5)

grade<- data.frame(kor,mat,eng)
grade

# 1.1 행 단위의 계산(평균) 값을 벡터로 출력하라

apply(grade, 1, mean)


#1.2 열 단위의 계산(합계) 값을 벡터로 출력하라

apply(grade, 2, sum)

#1.3 grade의 모든 요소 값에 2를 곱해 matrix로 출력하라

as.matrix(grade*2)

# 2. dplyr 패키지를 활용, 다음 문제를 풀어주세요

library(dplyr)
library(tidyr)
ms <- read.csv("./2018-3-mobile-user-data.csv", header=TRUE)
head(ms)

# 2.1 gather함수를 이용해 월(달), 가입자 라는 새로운 변수를 만들어서 월별 가입자수를 
아래로 길게 볼 수 있도록 늘어진 형태의 데이터를 만들어주세요

ms_gather <- ms %>% gather(year_month, member, starts_with("X"))
ms_gather <- ms_gather %>%  separate(year_month, into=c("year","month"), sep="\\.", remove = TRUE)

# 2.2 위의 데이터를 활용하여 통신사별+월별 가입자수 집계해주세요(합계) 

ms_gather %>% 
  group_by(통신사, month) %>% 
  summarize(tot_member = sum(member)) %>% View()


# 2.3 가입 구분별+ 월별 가입자수 집계해주세요(합계)

ms_gather %>% 
  group_by(구분, month) %>% 
  summarize(tot_member = sum(member)) %>% View()


# 2.4 통신사별 3월 가입자수의 합계를 보여주세요

ms_gather %>% 
  filter(month=="3월") %>% 
  group_by(통신사) %>% 
  summarize(tot_member=sum(member)) %>% View()



