#시각화 발제 
#ggplot & R shiny 
#ggplot2란?R 의 데이터 시각화 패키지입니다.함수를 입력하여 그래프를 그릴 수 있습니다. 
#Shiny는 R로 웹 어플리케이션을 만들 수 있게 해주는 프레임워크입니다.
#shiny는 ui라고 불리는 화면, server라고 불리는 데이터 처리 및 관리, 그 안에 입출력과 render와 배포로 구성되어 있습니다.
install.package('ggplot2')
library(ggplot2)

# 변수 1개- 히스토그램, 박스그래프, 막대그림, 원그림
# 변수 2개 - 산점도, 선 , 시계열, 모자이크 그래프
#1.그래프
ggplot(data = iris,mapping = aes(x = Sepal.Length,y = Sepal.Width))

head(diamonds)
ggplot(diamonds, aes(cut))+geom_bar()
#aes()안에는 x축 값만 입력하고, geom_bar()에 stat을 설정해주지 않습니다.
#빈도수가 계산되도록 하기 위해선 geom_bar()에 stat='count'를 입력해주어야 합니다.
#stat='count'는 y축의 높이를 데이터의 빈도(count)로 표시하는 bar그래프 형식으로
#stat='count'는 default 값
head(sleep)
ggplot(data=sleep, aes(x=ID, y=extra)) + geom_bar(stat='identity')
ggplot(sleep, aes(ID, extra, fill=group))+geom_bar(stat='identity') 

ggplot(data=pressure, aes(x=temperature, y=pressure))
ggplot(data=pressure, aes(x=temperature, y=pressure))+geom_point()+geom_line()

diamonds
ggplot(data=diamonds,aes(x=carat,y=price))+geom_point(aes(colour=clarity))+geom_smooth()
ggplot(data=diamonds,aes(x=carat,y=price,colour=clarity))+geom_point()+geom_smooth()

ggplot(data = iris,mapping = aes(x = Sepal.Length,y = Sepal.Width)) + geom_point(colour = c("purple", "blue", "green")[iris$Species],
                                                    pch = c(0, 2, 20)[iris$Species],
                                                    size = c(1, 1.5, 2)[iris$Species])

levels(iris$Species)
#factor형으로
iris$Species <- as.factor(iris$Species)
ggplot(data = iris,
       mapping = aes(x = Sepal.Length,
                     y = Sepal.Width)) + geom_point(colour = c("purple", "blue", "green")[iris$Species],
                                                    pch = c(0, 2, 20)[iris$Species],
                                                    size = c(1, 1.5, 2)[iris$Species])
g <- ggplot(data = iris,
            mapping = aes(x = Sepal.Length,
                          y = Sepal.Width)) + geom_point(colour = c("purple", "blue", "green")[iris$Species],
                                                         pch = c(0, 2, 20)[iris$Species],
                                                         size = c(1, 1.5, 2)[iris$Species])



# dply 함수를 사용하기 위한 패키지 설치 및 라이브러리 불러오기

install.packages(plyr)
library(plyr)

# Species별 Sepal.Length, Sepal.Width의 최소값과 최대값을 tmp에 할당

tmp <- ddply(iris, .(Species), summarise,
             min_x = min(Sepal.Length),
             max_x = max(Sepal.Length),
             min_y = min(Sepal.Width),
             max_y = max(Sepal.Width))
# 도형을 표시할 지점의 좌표를 계산 : 최소값 중에 최대값, 최대값 중에 최소값
start_x <- max(tmp$min_x)
end_x <- min(tmp$max_x)
start_y <- max(tmp$min_y)
end_y <- min(tmp$max_y)

g + annotate(geom = "segment",
             x = c(start_x, end_x, -Inf, -Inf),
             xend = c(start_x, end_x, Inf, Inf),
             y = c(-Inf, -Inf, end_y, start_y),
             yend = c(Inf, Inf, end_y, start_y),
             colour = "black",
             alpha = 0.5,
             lty = 2,
             size = 1)

# geom = "도형종류"
# x = 선 시작점 x좌표
# xend = 선 종료점 x좌표
# y = 선 시작점 y좌표
# yend = 선 종료점 y좌표
# colour = "선색"
# alpha = 투명도
# lty = 선종류
# size = 선두께


g + annotate(geom = "text",
             x = iris$Sepal.Length,
             y = iris$Sepal.Width,
             label = rownames(iris),
             colour = "brown",
             alpha = 0.7,
             size = 3,
             hjust = 0.5,
             vjust = -1)

# geom = "도형종류"
# x = x좌표
# y = y좌표
# colour = "글씨색"
# alpha = 투명도
# size = 글씨크기
# hjust = x축 영점 조절
# vjust = y축 영점 조절

g+ annotate(geom = "rect",
           xmin = start_x,
           xmax = end_x,
           ymin = start_y,
           ymax = end_y,
           fill = "red",
           alpha = 0.2,
           colour = "black",
           lty = 2)

# geom = "도형종류"
# xmin = 왼쪽 아래 x좌표
# xmax = 오른쪽 위 x좌표
# ymin = 왼쪽 아래 y좌표
# ymax = 오른쪽 위 y좌표
# fill = "채우기 색"
# alpha = 투명도
# colour = "선색"
# lty = 선종류


g + annotate(geom = "segment",
             x = c(start_x, end_x, -Inf, -Inf),
             xend = c(start_x, end_x, Inf, Inf),
             y = c(-Inf, -Inf, end_y, start_y),
             yend = c(Inf, Inf, end_y, start_y),
             colour = "black",
             alpha = 0.5,
             lty = 2,
             size = 1)

# geom = "도형종류"
# x = 선 시작점 x좌표
# xend = 선 종료점 x좌표
# y = 선 시작점 y좌표
# yend = 선 종료점 y좌표
# colour = "선색"
# alpha = 투명도
# lty = 선종류
# size = 선두께

g + coord_flip()

ggplot(sleep, aes(ID, extra, fill=group))+geom_bar(stat='identity')+coord_flip() 
ggplot(sleep, aes(ID, extra, fill=group))+ geom_bar(stat='identity', position = 'dodge')+coord_flip()
g + coord_cartesian(xlim = c(start_x, end_x),
                    ylim = c(start_y, end_y))
g + labs(title = "제목",
         subtitle = "부제목",
         caption = "주석",
         x = "x축 이름",
         y = "y축 이름")


#smooth는 회귀선
#추가된 레이어가 아닌 디폴트값에서 clour을 설정해야함

library(dplyr)

#2(2) 
Orange
Orange%>%
  group_by(Tree)%>%
  summarize(Sum.circumference=sum(circumference))%>%
  ggplot(aes(Tree, Sum.circumference))+geom_line(group=1, color='red')+
  theme_bw()
Orange%>%
  group_by(Tree)%>%
  summarize(Sum.circumference=sum(circumference))%>%
  ggplot(aes(Tree, Sum.circumference))+
  geom_bar(stat='identity', color='red', fill='white')+
  theme_bw()
ggplot(Orange, aes(x=age, y=circumference, color=Tree))+geom_line(size=1)
ggplot(Orange, aes(x=age, y=circumference))+geom_line(size=1, aes(color=Tree))
ggplot(Orange, aes(x=age, y=circumference, fill=Tree))+geom_bar(stat='identity')
ggplot(Orange, aes(x=age, y=circumference, color=Tree))+geom_point()

