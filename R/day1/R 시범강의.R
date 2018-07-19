#getwd()

# R script에서 실행은 우측 상단의 'Run' 또는 ctrl+Enter

##################### 3장 데이터 타입 ############################

# 변수에 값을 할당할 때는 <- 또는 = 를 사용한다
a <- 25
b <- "Boaz"
c <- FALSE

# 진리값
TRUE & TRUE
TRUE & FALSE
TRUE | TRUE
TRUE | FALSE


# class() : 타입 판별 (numeric, character, logical 등)
class(a)
class(b)
class(c)


# 변수 목록 및 삭제
ls()               # 현재 생성된 변수들을 보여줌
rm(a) ## 특정 변수 제거
rm( list = ls() )  # 모든 변수 제거


# NA(Not Available) : Missing Value
a <- NA
is.na(a)  # a가 NA이면 TRUE를 반환
a + 1     # NA는 연산 불가


## R의 기본형은 벡터 (스칼라는 길이가 1인 벡터로 볼 수 있다.)

x <- c(1,2,3)  # c() 안에 값들을 나열

# 벡터의 인자들은 한 가지 타입이어야 한다. 만약 다를 경우, 한 가지 타입으로 자동 변환된다.
x <- c(1,2,"hello")
x  # 1, 2는 numeric인데 character로 변환됨
class(x)

# 벡터 생성하는 다른 방법들
seq(1, 10, 1)  # sequance (from, to, by)
x <- 1:10      # 1부터 10까지의 숫자
rep ( c(1,2), 5 )        # c(1,2)를 5번 반복
rep( c(1,2), each = 5 )  # 1, 2를 각각 5번 반복

#벡터 내 데이터 접근
Boaz <- c("혜원","강민","준현","찬규","교정")
Boaz[1]
Boaz[c(1,2)]
Boaz[3:6] 
Boaz[-1]        #혜원을 빼고 출력
Boaz[-c(1,2)]   #혜원, 강민을 빼고 출력
length(Boaz)

#벡터의 연산
"혜원" %in% Boaz  #혜원이 Boaz 안에 있는지 파악하기
"연식" %in% Boaz

x = c(1, 2, 3, 4, 5)
x + 1 #사칙연산 가능 
x == c(1, 2, 3, 5, 6)
c(T, T, T) & c(T, F, T)
c(T, T, T) | c(T, F, T)


## factor : 범주형 변수를 위한 데이터 타입(<-> 연속적)

sex <- factor ("m", level = c("m", "f"))  # 일반적으로 첫번째 argument는 데이터, 그 뒤는 옵션 (?factor 참조)
# 옵션 이름을 안 쓰고 순서만 맞춰도 됨
sex
factor("m") # level을 지정하지 않으면 데이터가 가진 level만을 표시
levels(sex)   # level만 확인하고 싶을 때
nlevels(sex)  # level의 개수
class(sex)  # argument가 벡터일 때는 값의 타입(numeric, character, logical 등), 그 외는 데이터 타입(factor, matrix, list, data.frame 등) 반환


## list : 다양한 타입의 값들을 혼합해서 저장 가능 (분석 결과가 list 형태로 출력되는 경우가 많다.)

BigData <- list ( "기획" = c("준현","혜원"), "운영지원" =c("시은","지연"), aaa = c(1,2,3))  # character 벡터와 numeric 벡터 혼합
x

# list 내의 데이터 접근
BigData$"기획" # x라는 list 안의 "기획"이라는 데이터를 가져옴
BigData$"운영지원"
BigData$aaa
x <- 1:5; y <- 6:10  # ex) 선형회귀분석
lm <- lm(y ~ x)

lm$fitted.values     # $를 쳤을 때 나오는 것들이 list 요소들



## matrix

A <- matrix( 1:6 , nrow = 2 )           # nrow : 행의 개수, ncol : 열의 개수 (둘 중 하나만 쓰면 됨)
A <- matrix( 1:6 , nrow = 2, byrow=T )  # byrow=T : 행부터 채우기 (T=TRUE)
A
B <- matrix(1:6, nrow=3)

# 행렬에서의 Index
A[1,2]  # [행, 열]
A[1, ]  # 1행을 모두 가져옴
A[4]   # 열 순서로 4번째인 5
A[1:2,]
nrow(A); ncol(A)

# 행렬의 연산 (다중회귀분석에서 자주 쓰이는 것)
t(A)        # transpose
A*B
A %*% B
A %*% t(A)  # 행렬곱(내적)
solve(A %*%t(A))    # 역행렬

### data.frame (R에서 가장 중요한 데이터 타입)

# 행렬과 마찬가지의 모습을 하고 있지만 행렬과 달리 다양한 변수, 관측치(observations), 범주 등을 표현하기 위해 특화되어있다.
# 여러 가지 데이터 타입을 혼용해서 사용할 수 있어, 데이터를 불러오면 기본적으로 data frame의 형식으로 저장됨
df <- data.frame( x = c(1, 2, 3, 4, 5), y = c(2, 4, 6, 8, 10), z = c('M', 'F', 'M', 'F', 'M') )
# 이미 정의된 데이터프레임에 새 열을 추가
df$yunsik <- c(1,2,3,4,5)
df

# 데이터 프레임 내의 접근
df$x     # list와 같은 접근
df[,1]   # matrix와 같은 접근
df[1,2]
df[,"x"]  

# colnames(), rownames()
colnames(df)<-c("연식","강민","소현","지원")
df
rownames(df)<- c("a","b","c","d","e")
df

# 데이터 프레임 살펴보기
dim(df)             # 5개의 observation과 4개의 변수 (5행 4열)
head(df); tail(df)  # 앞 6개와 뒤 6개 observation을 보여줌
names(df)           # 변수들의 이름

# NA 처리
df[2,2] <- NA
df
complete.cases(df)  # 각 행이 NA를 포함하고 있지 않는지 판별
na.omit(df)         # NA가 포함된 항을 제거



######################### 제 4장 제어문, 연산, 함수 #########################

##if 문
a = 4
if(a == 13){
  print('true')
  print("hello")
}else{
  print('false')
  print('bye')
}

x=1:10
ifelse(x%%2 == 0, "even", "odd") ##ifelse(조건문,"조건에 맞는경우 표시되는 문구","조건에 맞지 않는 경우 표시되는 문구")

d <- data.frame(x=c(1, 2, 3, 4, 5) , y=c("a", "b", "c", "d", "e"))
d
d[d$x %% 2 == 0, ] ##true 인 행만 반환

#반복문

for(i in 1:10){
  print(i)
}


i = 0
while(i < 10){
  print(i)
  i = i + 1
}

##function
# '함수명 <- function(인자, 인자, ...) { 함수 본문 }'

f <- function(x) {
  if (x==1) {
    return("T")
  } else {
    return("F")
  }
}
f(1)
f(2)

fibo = function(n){
  if(n == 1 | n == 2){
    return(1)
  }
  else{
  return(fibo(n - 1) + fibo(n - 2))
}}

fibo(1)
fibo(2)
fibo(3)
fibo(4)




##같이 풀어봐요
fibo2 <- function(n,x1,x2){
  TEMP.1<- x1
  TEMP.2<- x2
  
  for(k in 3:n){
    temp.3<- TEMP.1 +TEMP.2
    TEMP.1 <-TEMP.2
    TEMP.2 <-TEMP.3
  }

}

fibo2(3,1,1)
fibo2(4,1,2)
fibo2(5,1,2)






## getwd() setwd()
getwd()
data<-read.csv("final2.csv")
head(data)

##install.packages() library() rshiny
install.packages("shiny")
install.packages("leaflet")
install.packages("dplyr")
library(dplyr)
library(leaflet)
library(shiny)


ui<-fluidPage(
  # Application title
  titlePanel("yunsik card expense"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      sliderInput("month", "Choose a month:",
                  min=0,max=12,value=c(11,12)),
      hr(),
      sliderInput("time",
                  "time 0 to 24",
                  min = 0,  max = 24, value=c(6,20)),
      sliderInput("expense",
                  "Price:",
                  min = 0,  max = 60000,  value = c(0,10000)),
      actionButton("update", "Click me")
    ),
    
    
    mainPanel(
      leafletOutput("mymap"),
      p(),
      
      
      # Output: Header + summary of distribution ----
      h4("Summary"),
      verbatimTextOutput("summary")
    )))



server <- function(input, output) {
  
  yunsikus <- eventReactive(input$update, {
    minmonth<-input$month[1]
    maxmonth<-input$month[2]
    minexpense<- input$expense[1]
    maxexpense<-input$expense[2]
    mintime<- input$time[1]
    maxtime<- input$time[2]
    m<-data%>%
      filter(
        Expense>=minexpense,
        Expense<=maxexpense,
        Month>=minmonth,
        Month<=maxmonth,
        Hour>=mintime,
        Hour<=maxtime)
    m<-as.data.frame(m)
    m
  }, ignoreNULL = FALSE)
  
  
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(lat = yunsikus()$lat, lng = yunsikus()$lon, popup=paste("장소 : ", yunsikus()$location,"<br>","금액 : ",yunsikus()$Expense,"<br>","시간 : ",yunsikus()$Hour)) })
  
  
  output$summary <- renderPrint({
    hahaha<-data.frame(lo=yunsikus()$location,ex=yunsikus()$Expense)
    rrrr<-aggregate(hahaha$ex,by=list(hahaha$lo),sum)
    colnames(rrrr) <-c("location","Total Expense")
    rrrr
  })}

shinyApp(ui=ui,server=server)








