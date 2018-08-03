####################
#title: "Week3 Visualization with R"
#author: "BoAZ team C"
#date: "2018년 7월 31일"
#####################
install.packages("ggplot2")
install.packages("dplyr")
install.packages("gapminder")
install.packages("gridExtra")
library(ggplot2)
library(dplyr)
library(gapminder)
library(gridExtra)
'
#############
#EDA 탐색적 자료분석
1. 자료에 대해 궁금한 질문 사항들 정리
2. 자료 시각화, 변형, 모델링 등의 탐색을 통해 질문들에 대한 답 찾기
3. 탐색결과를 이용하여 질문 사항들을 구체화, 새로운 질문 사항들 만들기
- EDA 과정은 자료 분석의 가장 중요한 단계
- 자료정리, 자료 시각화, 자료 변형, 자료 모형화 등이 포함
- ggplot2, dplyr 라이브어리를 함께 사용하며 데이터 전처리

############
#시각화 과정의 원칙
1. 데이터에 대한 설명을 읽는다. 문맥을 파악한다.
2. glimpse(), summary() 함수로 데이터구조를 파악한다. 행의 개수는? 변수의 타입은?
3. pairs() 산점도 행렬로 큰 그림을 본다. 언뜻 눈에 띄는 이상한 점이나 흥미로운 점이 없는지 파악한다. 
4. 주요 변수를 하나씩 살펴본다. 연속형-히스토그램/범주형-막대그래프
5. 두 변수 간의 상관 관계를 살펴본다. 산점도나 상자그림
6. 고차원의 관계를 연구한다. 제3, 제4의 변수를 geom_* 속성에 추가. 
                             적절한 경우 facet_wrap() 함수사용
7. 양질의 의미 있는 결과를 얻을 때까지 위의 과정 반복
8. 의미 있는 플롯은 문서화. 플롯 생성한 코드도 버전 관리

'''

######################
# DATASETS
#DATA 1. diamonds data
#캐럿, 컷, 색깔, 등급, 깊이, 가격, 
head(diamonds)
summary(diamonds)
glimpse(diamonds)
#DATA 2. mpg data
#제조사, 모델,자동차 연비, 연도,
head(mpg)
summary(mpg)
glimpse(mpg)
#DATA 3. gapminder
#국가, 대륙, 연도, 기대수명, 인구, 1인당 국내총생산
head(gapminder)
summary(gapminder)
glimpse(gapminder)
#DATA 4. economics
#날짜, 1인당소비지출액, 인구 등
summary(economics)


#################
#plot(), qplot(), ggplot() 비교하기
#plot
plot(mpg$cty, mpg$hwy)

#qplot
qplot(x = cty, y = hwy, color = cyl, data = mpg, geom = "point")

#ggplot2
#ggplot(data = mpg, aes(x = cty, y = hwy))
ggplot(data= mpg, aes(x = cty, y = hwy)) +     # mpg 데이터사용, x축에 cty변수, y축에 hwy변수를 매핑
  geom_point(aes(color=cyl)) +      #산점도 그리기. cyl별로 색깔을 지정
  geom_smooth(method ="lm") +
  coord_cartesian() +
  scale_color_gradient()+
  theme_bw()

mpg %>% ggplot(aes(cty, hwy)) +
  geom_point(aes(color=cyl)) +
  geom_smooth(method ="lm") +
  coord_cartesian() +
  scale_color_gradient()+
  theme_bw()

#직전 plot 저장
ggsave("plot.png", width = 5, height = 5) 

'
ggplot을 사용하는 이유
많은 커스텀화 없이도 보기 좋은 그래프 
다양한 플롯 타입을 하나의 통일된 개념으로 처리
다변량 데이터 플롯에 효율적리  facet_* 함수'


################
#ggplot2 패키지 헤쳐보기
#구성요소 3가지
1. data
2. a set of geoms  
3. a coordinate system 

##############
#1. data
ggplot(data= mpg, aes(x=displ, y=hwy))

#아래 3가지 코드는 모두 동일한 그래프
ggplot(data= mpg, aes(x=displ, y=hwy)) +
  geom_point()
ggplot(mpg, aes(displ, hwy)) +
  geom_point()
mpg %>% ggplot(aes(displ, hwy))+    #dplyr 라이브러리와 함께 데이터 전처리, 시각화하기
  geom_point()                      # 오늘 세션에서는 편의상 3번째 표현으로 통일하겠음

# %>%  파이프 연산자 (ctrl +shift + M)


##############
#2. a set of geoms
#visual marks that represent data points
#Use a geom to represent data points, use the geom’s aesthetic properties to represent variables.
#Each function returns a layer. 

dataset %>% ggplot(aes(x축, y축, 옵션)) +
  geom_smooth() : smooth line 과 se 를 표시 +
  geom_boxplot(): 상자그림 +
  geom_histogram() : 연속변수의 분포 +
  geom_freqpoly() :  연속변수의 분포, 도수를 직선으로 연결 +
  geom_density() : 확률분포밀도함수를 매끄러운 곡선으로 연결 +
  geom_bar() : 막대그림  +
  geom_path(): 점들을 자료 순서대로 선으로 연결한 그림 +
  geom_line(): 산점도에서의 위치에 따라 왼쪽에서 오른쪽순으로 모든 점들을 연결


#3. a coordinate system 




#################
#1. 한 연속형 변수
# 도수 히스토그램(histogram)
# 도수 폴리곤 (frequency polygon) : 막대 대신에 도수를 직선으로 연결
# 커널밀도추정함수(kernal density estimator) : 확률분포밀도함수를 매끄러운 곡선으로 연결

# gapminder 데이터에서 1인당국내총생산(gdpPercap)의 도수 확인
a1<- gapminder %>% ggplot(aes(x=gdpPercap)) + geom_histogram()
a2<- gapminder %>% ggplot(aes(x=gdpPercap)) + geom_histogram()+
  scale_x_log10()
a3<- gapminder %>% ggplot(aes(x=gdpPercap)) + geom_freqpoly()+
  scale_x_log10()
a4<- gapminder %>% ggplot(aes(x=gdpPercap)) + geom_density()+
  scale_x_log10()

grid.arrange(a1,a2,a3,a4)


#QUESTION 1.
# gapminder 데이터에서 1인당국내총생산(gdpPercap)을 대륙별(continent)로 보기
# Hint:  fill= , colour=,   facet_wrap(~continent)

gapminder %>% ggplot(aes(x=gdpPercap, fill= continent)) + geom_histogram()+
  scale_x_log10() +
  facet_wrap(~continent)
gapminder %>% ggplot(aes(x=gdpPercap, colour= )) + geom_freqpoly()+
  scale_x_log10() +
  facet_wrap(~continent)



#################
#2. 한 범주형 변수 
# 막대그래프 (bar chart)
# table() 함수 사용하는 것도 유용


# diamonds 데이터에서 컷의품질별(cut)로 도수 확인
b1<- diamonds %>% ggplot(aes(cut))               #도수분포 막대그래프
b1 + geom_bar()

table(diamonds$cut)                             #도수분포
prop.table(table(diamonds$cut))                 #상대도수
round(prop.table(table(diamonds$cut))*100, 1)   #퍼센트
diamonds %>% group_by(cut) %>%                  #dplyr 활용한 통계량 계산
  tally() %>% 
  mutate(pct= round(n/sum(n)*100, 1)) 


#QUESTION 2. 
# diamonds 데이터에서 컷의품질별(cut)로 bar chart의 막대색깔을 다르게 해보자
n<- b1 + geom_bar(aes(fill=cut));n
n+ scale_fill_brewer(palette="Blues")
n+ scale_fill_grey(start=0.2, end=0.8, na.value = "red")

#diamonds 데이터에서 컷의품질(cut)별로 다이아몬드색깔(color) 정보 추가
b2<- diamonds %>% ggplot(aes(cut, fill=color))
b2+ geom_bar(position = "dodge")
b2+ geom_bar(position = "fill")
b2+ geom_bar(position = "stack")


#################
#3. 두 연속형 변수 
# 산점도 (scatterplot)

c1<- diamonds %>% ggplot(aes(carat, price)) + geom_point()
c2<- diamonds %>% ggplot(aes(carat, price)) + geom_point(alpha=0.05)
c3<- mpg %>% ggplot(aes(cyl, hwy)) + geom_point()
c4<- mpg %>% ggplot(aes(cyl, hwy)) + geom_jitter()

grid.arrange(c1,c2,c3,c4)

# 변수가 두가지 이상의 다변량 자료 
#산점도 행렬(scatterplot matrix)
#pairs(diamonds)
pairs(diamonds %>% sample_n(1000))
cor(diamonds[,c(1,5:10)])

# QUESTION 3.
# c 그래프에 smooth line 그려보기
c<- diamonds %>% sample_n(5000) %>% 
  ggplot(aes(carat, price)) +geom_point();c
c+  geom_smooth(span = 0.2) 
c+  geom_smooth(method = "gam", formula = y ~ s(x)) 
c+  geom_smooth(method = "lm")


##################
#4. 연속형 변수와 범주형 변수 
# 범주의 수준별로 나누어 연속형 변수의 분포 살펴보기 
# X 범주형, Y 수량형인 경우 병렬상자그림 (side-by-side boxplot)

# mpg 데이터에서 차량등급별(class)로  (hwy)의 분포 확인
(d1<- mpg %>% ggplot(aes(class, hwy))+ geom_boxplot() )
(d11<- mpg %>% ggplot(aes(class, hwy))+ geom_violin() )

d2<- mpg %>% ggplot(aes(class, hwy))+ geom_point(col="gray")+
  geom_boxplot(alpha=.5)
d3<- mpg %>% ggplot(aes(class, hwy))+ geom_jitter(col="gray")+
  geom_boxplot(alpha=.5)
d4<- mpg %>% mutate(class=reorder(class, hwy, median)) %>% 
  ggplot(aes(class, hwy))+ geom_jitter(col="gray") +
  geom_boxplot(alpha=0.5)
d5<- mpg %>% mutate(class=factor(class, levels=
                              c("2seater","subcompact","compact","midsize",
                                "minivan","suv", "pickup"))) %>% 
  ggplot(aes(class, hwy))+ geom_jitter(col="gray") +
  geom_boxplot(alpha=0.5)
d6<- mpg %>% mutate(class=factor(class, levels=
                              c("2seater","subcompact","compact","midsize",
                                "minivan","suv", "pickup"))) %>% 
  ggplot(aes(class, hwy))+ geom_jitter(col="gray") +
  geom_boxplot(alpha=0.5) +coord_flip()


d1
unique(mpg$class)
grid.arrange(d2, d3)
grid.arrange(d3, d4, d5, d6)

#QUESTION 4.
# d1 플롯에 제목(title), 축이름(labels) 지정하기
d1 +ggtitle("hwy by class") 
d1 +ggtitle("hwy by class") + xlab("class") + ylab("hwy")
d1 +labs(title="hwy by class", x="new.class", y="new.hwy") 



#############
#5. 두 범주형 변수 
#xtabs()        : 도수 분포 알아내기
#mosaicplot()   : 결과를 시각화하기

# using diamonds dataset for illustration
df <- diamonds %>%
  group_by(cut, clarity) %>%
  summarise(count = n()) %>%
  mutate(cut.count = sum(count),
         prop = count/sum(count)) %>%
  ungroup()
xtabs(cut.count~ cut, df)

xtabs(~ cut, data.frame(diamonds))
xtabs(~ cut+clarity, data.frame(diamonds))
xtabs(~ cut+clarity+color, data.frame(diamonds))



#mosaicplot(diamonds)

diamonds %>% ggplot()+
  geom_count(mapping= aes(cut, color))
diamonds %>% count(color, cut) %>% 
  ggplot(mapping=aes(color, cut))+
  geom_tile(mapping=aes(fill=n))


ggplot(df,
       aes(x = cut, y = prop, width = cut.count, fill = clarity)) +
  geom_bar(stat = "identity", position = "fill", colour = "black") +
  # geom_text(aes(label = scales::percent(prop)), position = position_stack(vjust = 0.5)) + # if labels are desired
  facet_grid(~cut, scales = "free_x", space = "free_x") +
  scale_fill_brewer(palette = "RdYlGn") +
  # theme(panel.spacing.x = unit(0, "npc")) + # if no spacing preferred between bars
  theme_void() 



#############
#6. 시계열 자료

class(economics$date)
economics %>% ggplot(aes(date, unemploy / pop)) +   
  geom_line()
economics %>% ggplot(aes(date, uempmed)) +   
  geom_line() 


################
# 더 많은 정보를 보여주기
#1. 각 geom 의 다른 속성들을 사용하기

gapminder %>% filter(year==2007) %>% 
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point() +
  scale_x_log10() +
  ggtitle("Gapminder data for 2007")

gapminder %>% filter(year==2007) %>% 
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point(aes(size=pop, col=continent)) + 
  scale_x_log10()+
  ggtitle("Gapminder data for 2007")

################
# 더 많은 정보를 보여주기
#2. facet_* 함수를 사용하기

gapminder %>% 
  ggplot(aes(year, lifeExp, group=country))+
  geom_line()
gapminder %>% 
  ggplot(aes(year, lifeExp, group=country, col=continent))+
  geom_line()
gapminder %>% 
  ggplot(aes(year, lifeExp, group=country, col=continent))+
  geom_line()+
  facet_wrap(~continent)



#################
# 옵션 따져보기
#1. Stats 
#An alternative way to build a layer
#레이어를 만드는 또다른 방법


#################
# 옵션 따져보기
#2. Scale
# Scale 은 
General Purpose scales Use with any aesthetic:  
  alpha, color, fill, linetype, shape, size 
scale_*_continuous() - map cont’ values to visual values 
scale_*_discrete() - map discrete values to visual values 
scale_*_identity() - use data values as visual values 
scale_*_manual(values = c()) - map discrete values to  manually chosen visual values X and Y location scales


scale_x_date(labels = date_format("%m/%d"),  breaks = date_breaks("2 weeks")) - treat x  values as dates. See ?strptime for label formats. 
scale_x_datetime() -  treat x values as date times. Use same arguments as scale_x_date(). 
scale_x_log10() - Plot x on log10 scale 
scale_x_reverse() - Reverse direction of x axis 
scale_x_sqrt() - Plot x on square root scale



a<- gapminder %>% ggplot(aes(x=gdpPercap)) 
a + geom_histogram()
a + geom_histogram() + scale_x_log10()
a
gapminder %>% mutate(loggdp=log10(gdpPercap)) %>% 
  ggplot(aes(loggdp))+geom_histogram()



############
#coordinate, labels, legend, themes

##############
#ggplot 은 아니지만 기타시각화 



