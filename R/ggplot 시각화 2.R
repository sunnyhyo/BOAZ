##R 기초는 생략.... 보아즈카페에 있는 R기초랑 r데이터분석 실무 5장까지 따라쳐보면 금방 된다.'
setwd("C:/Users/HS/Documents/GitHub/Tableau/Homework/과제 2")
####데이터 불러오기만...
cali <- read.csv("california.csv")
head(cali)
####R에 존재하는 다양한 내장함수들...
install.packages("shiny")
library(shiny)
library(ggplot2)
shiny::runGitHub("shiny-examples","rstudio",subdir="050-kmeans-example")

##Rshiny의 장점
shiny::runExample("01_hello")
## 1.샤이니가 제공하는 인터렉션 기능을 이용하여 데이터를 잘 이해할 수 있다.(태블로도 가능)
#### 그렇다면 이 수 많은 코드들을 다 외어야 하는가??? 그럴 필요 없다. 남들이 만들어놓은 템플릿에 조금만 변형을 가하면 된다.
#### https://github.com/rstudio/shiny-examples 여기에 수많은 예제들이 있다. 

https://stat501.wixsite.com/song2song2
## 2.샤이니가 제공하는 서버로 내가 만든 웹페이지를 공유 할 수 있다.
#### 웹을 구성하는 수많은 복잡한 언어들....(HTML, CSS, JAVASCRIPT) 몰라도 r로 쉽게 웹페이를 만들 수 있다.
#### 12월에 있는 rshiny project는 위에 있는 것처럼 간단한 웹피이지를 구성하는 것으로 생각중(여행 추천 웹페이지, 간단한 맥주 추천 웹페이지..)


shiny::runGitHub("shiny-examples","rstudio",subdir="050-kmeans-example")
## 3. 간단한 로직만 표현하는 것이 아니라 분석알고리즘까지 표현하여 데이터에서 더 많은 인사이트를 얻어낼 수 있다. 


#### 오늘은 R시각화의 대표 패키지인 "ggplot2"를 공부해보도록 하자.
#### 기본 그래픽 시스템은 그림을 그리기 위해 좋은 툴이지만 ggplot2는 데이터를 이해하는데 좋은 툴이다.
#### 단순한 그래프 이상을 그리고 싶다면 ggplot2를 배워야 한다! ggplot2를 능숙하게 사용할 수 있다면 산점도나 히스토그램 바이올린 그래프 지도에까지 응용을 할 수 있다.

##R 내장함수를 이용한 base graphics
par(mae(c(4,4,1,1)))
plot(mpg~hp,
     data=subset(mtcars,am==1),
     xlim=c(50,450),ylim = c(5,40))
points(mpg ~ hp,col="red",
       data = subset(mtcars, am==0))
legend(250,40,c("1","0"),title="am",
       col=c("black","red"),pch=c(1,1))

##ggplot2를 이용한 graphics
ggplot(mtcars,aes(x=hp,
                  y=mpg,color=factor(am))) + geom_point()





## 깔아준다
install.packages("ggplot2")
library(ggplot2)

##ggplot의 장점은 그래프를 구성하는 요소를 "문법"처럼 체계화 했다는 점임
ggplot(cali,aes(median_income,total_rooms,color=ocean_proximity)) +
  geom_point() +
  facet_grid(.~ocean_proximity)

#### 데이터프레임(dataframe)
#### 색상 크기 같은 외적 요소(aes)
#### 점 선 모양 같은 기하학적 요소(geoms)
#### 통계적 처리 방법(stats)
#### aes에서 사용할 스케일(scale)




##지지플랏 객체 만들기

g<- ggplot(data = iris,aes(x=Sepal.Length, y = Sepal.Width))
g

## 위 상태는 ggplot2의 1번 단계. 어떤 데이터를 사용할 것인지만 지정
## 모양의 그래프를 원하는지 입력하지 않았기 때문에 위 상태에서는 그래프가 출력되지 않음

##geom 요소를 추가하기##

##geom요소를 추가하려면 "+geom_원하는 형태의 그래프()" 형식으로 추가하면 됨



#### scatter plot ####
g + geom_point()
## 이외에도 geom_bar(), geom_line()등이 있다. 


####여기에 미적요소를 더하면 색상이나 크기등이 변하게 됨
##aes요소를 추가라여면 변경하고 싶은 geom요소(도형이나 점 선등)의 괄호안에 "aes(색상,크기등의 원하는 디자인)" 요소를 추가
g + geom_point(aes(color=Species,shape=Species))

## geom 트깅 조절하기 alpha=투명도, size = 크기
g + geom_point(alpha=(1/3), size = 5)
g+geom_point(alpha=(1/3), size=5)



#Quiz1 ggplot2를 이용하여 과제2에 나온 California주택 자료를 시각화하는데데
#      x축은 medain_income y축은 total_rooms로 하고 ocran_proximity별로 다른 색깔을 주어라

ggplot(cali, aes(median_income, total_rooms, color=ocean_proximity)) +
  geom_point()
ggplot(cali, aes(median_income, total_rooms)) +
  geom_point(aes(color=ocean_proximity))

#### barplot - geom_bar() ####
head(cali)
ggplot(cali,aes(x=ocean_proximity))+ geom_bar() #y 설정 안하면 count
ggplot(cali, aes(x=ocean_proximity, y=median_income)) +geom_bar()

#### box plot - geom_boxplot ####
ggplot(cali, aes(x=factor(ocean_proximity),y=median_income)) + geom_boxplot() +geom_point()
ggplot(cali, aes(x=ocean_proximity,y=median_income)) + geom_boxplot() +geom_point()
class(cali$ocean_proximity)
as.character(cali$ocean_proximity)

####Single colum Multiple rows
ggplot(cali, aes(x=median_income, y= total_rooms, color= ocean_proximity)) +
         geom_point() +
         facet_grid(.~ocean_proximity)
ggplot(cali, aes(x=ocean_proximity, y= total_rooms, color= ocean_proximity)) +
  geom_point() +
  facet_grid(.~ocean_proximity)
ggplot(cali, aes(x=population, y= total_rooms, color= ocean_proximity)) +
  geom_point() +
  facet_grid(.~ocean_proximity)


####Single Column Multiple rows
ggplot(iris, aes(Sepal.Length, Sepal.Width,color=Species)) +
  geom_point() +
  facet_grid(.~Species)


ggplot(cali,aes(median_income,total_rooms,color=ocean_proximity)) + 
  geom_point()+
  facet_grid(.~ocean_proximity)


####Quiz2 cctv자료에서 x축을 총인구 y축을 총 범죄 발생수라 하고 scatterplot을 그려보시오
getwd()
setwd("./과제 1")
cctv<- read.csv("total.csv")
g2<- ggplot(cctv, aes(x=total.pop, y=총발생범죄), ) 
g2 + geom_point(alpha=(1/2), size=5) 
