####dplyr 패키지####
install.packages("dplyr") ; install.packages("Amelia")
library(dplyr);library(Amelia)


####데이터 불러오기####
getwd()    ##경로가 어디로 설정 되어있는지 확인
setwd("C:/Users/HS/Documents/GitHub/2018summerBoAZ/R/day2")   ##지정된 곳에 파일이 있어야함


titanic <- read.csv("titanic3.csv",sep=",")
titanic
class(titanic)
class(titan)
titi <- fread("titanic3.csv") #대용량자료를 빨리 불러옴
#fread

####tbl_df####
####그냥 불러와서 데이터를 읽게되면 보기가 불편함###

titan <- tbl_df(titanic)
titan
?tbl_df()

####결측치 ####

sum(is.na(titan))  ##총 1452개의 결측치가 있다.
windows()  ##R에서 시각화를 할 때 항상 윈도우 창을 켜주고 하는게 편하다.
missmap(titan)  ##시각화를 통해서 어느 변수에 결측치가 존재하는지 알아보기 쉬움
which(is.na(titan)) ##보기 불편함 
which(is.na(titan),arr.ind=T)  ##결측치가 있는 위치의 행과 열번호를 보여줌
na.omit(titan) #결측치가 존재하는 모든 행을 삭제


####apply류 함수####
set.seed(2)   #난수생성시 고정
x <- round(rnorm(25, 50, 10))
y<- round(rnorm(25,100,15))
alpha <- sample(c("A", "B", "C"), 25, replace=T)
f <- factor(alpha)
xyf<-data.frame(x=x,y=y, f=f)
str(xyf)
head(xyf)

###apply 

apply(xyf[,1:2],2,sum)
apply(xyf[,1:2],2,mean) #열방향 계산
apply(xyf[,1:2],1,mean) #행방향 계산

###tapply  data.frame

tapply(xyf$x,xyf$f,mean) #그룹별 평균
tapply(xyf$y,xyf$f,sum)  #그룹별 합 

###에제

iris

tapply(iris$Sepal.Length,iris$Species,mean)
tapply(iris$Sepal.Width,iris$Species,mean)
tapply(iris$Petal.Length,iris$Species,max)

##mapply
##lapply   list

m1 <- list(a = c(1:10), b = c(11:20))
m2 <- list(c = c(21:30), d = c(31:40))


lapply(m1,sum)
lapply(m2,mean)


mapply(sum,m1$a,m2$d)
mapply(mean,m1$a,m1$b,m2$d,m2$c)



#########################dplyr############################
#### %>% 
#### 파이프라는 연결코드 인데, 여러가지 함수를 묶어서 실행을 시켜줌 
#### ex)
titan %>% select(pclass,survived,name,sex,age) %>%
  filter() %>% group_by() %>% summarise 


####select####
####보고싶은 변수(열)만 선택해서 보는 함수####
colnames(titan) 
select(titan,pclass,survived) %>% head()
titan %>% select(pclass,survived,sex,age) %>% head(10)
titan %>% select(survived,sex,age,fare)
titan_select <- titan %>% select(pclass,survived,sex,age) 
titan_select


####filter####
####원하는 조건에 맞춰서 보여줌####
titan %>% filter(age==60,sex=="female")
titan %>% filter(age==60|age==30,sex=="female")


####예제 해보세요
####나이가 20대이고 여성(female)인 사람의 pclass(자리등급),survived(생존여부),sex,age를 출력
############################################################################################

titan %>% select(pclass, survived, sex, age) %>% 
  filter(age==20 , sex=="female")
#같은 변수에서는 & | 다른 변수에서는 ,

####arrange
####변수를 정렬해주는 기능 sort 와도 같음 함수이다.


titan %>% select(age) %>% arrange(age) %>% head()
titan %>% select(age) %>% arrange(-age) %>% head()
titan %>% select(age) %>% arrange(desc(age)) %>% head()


####mutate
####data frame 에 원하는 변수를 변환 해서 추가해줌

titan %>% mutate(fare_Won = fare*1200)
titan %>% mutate(fare_1000=fare/1200)
titan %>% transmute(fare_Won = fare*1200 , fare_1000=fare/1200) %>%head() #추가한 변수만 보여줌
names(titan)

###에제 해보세요
###fare 변수에 평균을 빼고 표준편차를 나눈값(표준화)을 새로운 변수로 추가한후, 이 변수만 보여주되 상위 6개 까지 출력.
####################################################################################################################

titan %>% transmute(fare_std = (fare - mean(fare, na.rm=T))/ sd(fare, na.rm=T))  %>%
  arrange(-fare_std) %>% head(6)



####group_by & summarise ####
###지정한 변수를 그룹별로 묶어서 요약해줌###

titan %>% group_by(sex) %>% summarise(mean_age=mean(age,na.rm=T))
titan %>% group_by(pclass) %>% summarise(mean_age=mean(age,na.rm=T))
titan %>% group_by(pclass) %>% summarise(mean_fare=mean(fare,na.rm=T))
titan %>% group_by(survived) %>% summarise(max=max(age,na.rm=T))
titan %>% group_by(survived) %>% summarise(min=min(age,na.rm=T))

titan %>% group_by(survived) %>% summarise(n=n()) ##도수
###이렇게 여러가지 함수를 적용할 수 있다.



####에제 같이해봐요
####pclass가 1이고 나이가30대 여성인 사람의 survived별 수를 알고싶다.


titan %>% filter(pclass==1,age>30&age<40,sex=="female") %>% group_by(survived) %>%
  summarise(n=n())


####join 함수
####data frame을 조건에 맞게 join 시켜줌 ,sql 하고 비슷
####left , right , inner, full join 이 있음
set.seed(1)

log <- data.frame( user_id = sample(c(1,2,3), 10, TRUE), item_id =
                     sample( c(1,2,3), 10, TRUE ), correct = sample(c(0,1), 10, TRUE) )
users <- data.frame( user_id = c(1,2,4), age = c(20,20,30) )
items <- data.frame( item_id = 1:3, item = c("1+1","2*2","3/3") )

log %>% left_join(users,"user_id")
log %>% left_join(users,"user_id") %>% left_join(items,"item_id")

log %>% right_join(users,"user_id")

log %>% inner_join(users,"user_id")
log %>% inner_join(users,"user_id") %>% inner_join(items,"item_id")


log %>% full_join(users,"user_id")


