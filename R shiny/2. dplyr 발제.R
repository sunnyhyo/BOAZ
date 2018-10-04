###############################################
###############################################
# The easiest way to get dplyr is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just dplyr:
install.packages("dplyr")

# install.packages("devtools")
# devtools::install_github("tidyverse/dplyr")

###############################################
###############################################
#dplyr 함수들

'''
행(row)선별 : filter(), slice()
행(row)정렬 : arrange()
열(column)선별 : select()
열(column)조건부 선별 : 
select(df, starts_with()),
select(df, ends_with()),
select(df, contains())
select(df, matchs()), 
select(df, one_of()),
select(df, run_range())
변수이름변경 : rename()

mutate() : 새로운 변수를 추가한다. 기존변수 + 새로운 변수 
summarise() : 변수요약. mutiple values ->  a single summary.
arrange() : 행 정렬
'''


###############################################
###############################################
library(dplyr)
library(MASS)

starwars
glimpse(starwars)


starwars %>% 
  filter(species == "Droid")

starwars %>% 
  select(name, ends_with("color"))
#Error in select() : unused arguments()
#MASS 패키지의 select() 와 dplyr 패키지의 select()

#충돌해결 : select 는 dplyr 패키지의 select 임을 명시적으로 지저
select <- dplyr::select
starwars %>% 
  select(name, ends_with("color"))


starwars %>% 
  mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, bmi)

starwars %>% 
  arrange(desc(mass))

starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1)


###############################################
###############################################
#dplyr 기본문법들

###############################################
#데이터 프레임
#subset Cars93
Cars93_1<- Cars93[,1:8]
str(Cars93_1)


#number of cars by Type
table(Cars93_1$Type)


#########################
#데이터 프레임의 행(row) 부분집합 선별 : filter(), slice()

#filter(dataframe, filter condition1, filter condition2, ....) : &(AND)조건으로 row 데이터 부분집합 선별
#차종(type)이 "compact"이고 & 최대가격(max.price)이 20백$ 이하이고 & 고속도로 연비(MPG.highway) 가 30 이상인 관측치를 선별
Cars93_1 %>% filter( Type == c("Compact"), Max.Price <= 20, MPG.highway >= 30)

#filter(dataframe, filter condition1 | filter condition2 | ....) : |(OR)조건으로 row 데이터 부분집합 선별
#차종(Type)이 "Compact"이거나 | 최대가격(Max.Price)이 20 백$ 이하이거나|  고속도로 연비(MPG.highway) 가 30 이상인 관측치를 선별
Cars93_1 %>% filter( Type == c("Compact") | Max.Price <= 20 | MPG.highway >= 30)

#silce(dataframe, from, to) : 위치를 지정해서 row 데이터 부분집합 선별하기 
Cars93_1 %>% slice(6:10)



##########################
#데이터프레임 행 정렬하기 : arrange()
#arrange(dataframe, order criterion1, order criterion 2, ...)
   #오름차순(asecending) 정렬: 기본정렬 옵션
   #내림차순(descending) 정렬: desc()

#고속도로 연비(MPG.highway) 가 높은 순서대로 정렬을 하시오.  만약 고속도로 연비가 동일하다면 최고가격(Max.Price)가 낮은 순서대로 정렬하시오.
Cars93_1 %>% arrange(desc(MPG.highway), Max.Price) %>% head(20)


######################
#데이터 프레임 변수(column) 선별하기 : select()

#select(dataframe, VAR1, VAR2, ...) : 선별하고자 하는 변수 이름을 기입
#Cars93_1 데이터 프레임으로부터 제조사명(Manufacturer), 최대가격(Max.Price), 고속도로연비(MPG.highway) 3개 변수(칼럼)를 선별하시오.
Cars93_1 %>% select(Manufacturer, Max.Price, MPG.highway)%>% head(20)

#select(dataframe, a:n) : a 번째부터 n 번째 변수 선별
Cars93_1 %>% select(Manufacturer:Price) %>% head(20)
Cars93_1 %>% select(1:5) %>% head(20)

#select(dataframe, -var1, -var2, ....): ㅁa번째부터 n 번째 변수는 빼고 선별
Cars93_1 %>% select(-(Manufacturer:Price)) %>% head(20)
Cars93_1 %>% select(-(1:5)) %>% head(20)

#select(datarame, starts_with("xx_name")) : "xx_name"으로 시작하는 모든 변수 선별
#Cars93_1 데이터 프레임에서 "MPG"로 끝나는 모든 변수를 선별
Cars93_1 %>% select(starts_with("MPG"))%>% head(20)

#select(datarame, ends_with("xx_name")) : "xx_name"으로 끝나는 모든 변수 선별
#Cars93_1 데이터 프레임에서 "Price"로 끝나는 모든 변수를 선별
Cars93_1 %>% select(ends_with("Price"))%>% head(20)

#select(dataframe, contain("xx_name")) : "xx_name"을 포함하는 모든 변수 선별
#Cars93_1 데이터 프레임에서 "P"를 포함하는 모든 변수를 선별
Cars93_1 %>% select(contains("P"))%>% head(20)


#select(dataframe, one_of(Vars)) : 변수 이름 그룹에 포함된 모든 변수 선별
#"Manufacturer", "MAX.Price", "MPG.highway" 의 3개 변수이름을 포함하는 변수 그룹이 있다고 할 때, Cars93 데이터 프레임에서 이 변수 그룹에 있는 변수가 있다면(<- 즉, 있을 수도 있지만 없을 수도 있다는 뜻임!) 모두 선별
vars <- c("Manufacturer", "MAX.Price", "MPG.highway")
Cars93_1 %>% select( one_of(vars)) %>% head(20)
#변수그룹 vars 에 데이터 프레임 포함된 변수는 선별해서 반환, 만약 없으면 Warning Message제시


#######################
#데이터 프레임 변수 이름 변경하기: rename()
#rename(dataframe, new_var1 = old_var1, new_var2 = old_var2, ...)
#새로운 변수 이름을 앞, 이전 변수 이름을 뒤
#따옴표 x, 여러개이면 , 로 나열

names(Cars93_1)

Cars93_2 <- Cars93_1 %>% rename(New_Manufacturer = Manufacturer,
                   New_Model = Model, 
                   New_Type = Type, 
                   New_Min.Price = Min.Price, 
                   New_Price = Price, 
                   New_Max.Price = Max.Price,
                   New_MPG.city = MPG.city, 
                   New_MPG.highway = MPG.highway)
names(Cars93_2)


########################
#중복없는 유일한(distinct, unique) 값 추출: distinct()
#dictinct(dataframe, 기준var1, 기준var2, ...)

names(Cars93)

#Cars93 데이터 프레임에서 '차종(Type)'과 '생산국-미국여부(Origin)' 변수를 기준으로 
#중복없는 유일한 값을 추출
Cars93 %>% distinct( Origin ) 
Cars93 %>% distinct( Type )
Cars93 %>% distinct( Origin, Type )


unique(Cars93[, c("Origin", "Type")])   
# rows names가 dataframe의 row 번호로 반환되는 차이



########################
#무작위 표본 데이터 추출 : sample_n(), sample_frac()

#sample_n(dataframe, a fixed number) : 특정 개수만큼 무작위 추출
#Cars93 데이터 프레임 (1~5 변수만 사용) 에서 10개의 관관측치를 무작위로 추출
Cars93 %>% select(1:5) %>%  sample_n(10)
Cars93 %>% select(1:5) %>%  sample_n(10)


#sample_frac(dataframe, a fixed fraction) : 특정 비율만큼 무작위 추출
#Cars93 데이터 프레임 (1~5 변수만 사용) 에서 10%의 관측치를 무작위로 추출
nrow(Cars93)
nrow(Cars93)*0.1
Cars93 %>% select(1:5) %>%  sample_frac(0.1) #9개 추출


#smaple_n(dataframe, n, replace = TRUE) : 복원 추출
#위 두 함수는 비복원추출이었음(defalt 옵션), 복원추출을 하고 싶다면 replace=TRUE
#Cars93 데이터 프레임(1~5번까지 변수만 사용)에서 20개의 관측치를 무작위 복원추출
Cars93 %>% select(1:5) %>%  sample_n(20, replace=TRUE)

#dataframe %>% group_by(factor_var) %>% sample_n(size) : 집단별 층화 표본
#집단, 그룹별로 동일한 수의 표본을 무작위 추출해서 분석해야 하는 경우 

#Cars93 데이터 프레임에서 '제조국가_미국여부(Origin)'의 'USA', 'non-USA' 요인 속성별로 각 10개씩의 표본
Cars93 %>% select(Manufacturer, Model, Origin) %>% 
  group_by(Origin) %>% sample_n(10)



#####################
#새로운 변수 생성 : nutate(), transmutate()

#mutate(dataframe, 새로운변수= 기존변수 조합한 수식, ...): 기존변수+신규변수 모두 keep
Cars93_1 <- Cars93 %>% select( Model, Min.Price, Max.Price) %>% head(10) # subset for better printing
Cars93_1

Cars93_1 <- Cars93_1 %>% mutate(Price_range = Max.Price - Min.Price,  
                                Price_Min_Max_ratio = Max.Price / Min.Price)
Cars93_1


#transmute(dataframe, 새로운 변수 = 기존 변수 조합한 수식, ...): 신규 변수만 keep
Cars93_1 <- Cars93 %>% select( Model, Min.Price, Max.Price) %>% head(10) # subset for better printing
Cars93_1

Cars93_2 <- Cars93_1 %>%  transmute( Price_range = Max.Price - Min.Price, 
                                     Price_Min_Max_ratio = Max.Price / Min.Price)
Cars93_2 


#####################
#값 요약: summarise()


#summarise(dataframe, mean, sd, ...) : 수치형 값에 대한 요약 통계량 계산
'''
- mean(x, na.rm = TRUE) : 평균, 결측값을 제외하고 계산하려면 na.rm = TRUE 추가
- median(x, na.rm = TRUE) : 중앙값
- sd(x, na.rm = TRUE) : 표준편차
- min(x, na.rm = TRUE) : 최소값
- max(x, na.rm = TRUE) : 최대값
- IQR(x, na.rm = TRUE) : 사분위수 (Inter Quartile Range = Q3 - Q1)
- sum(x, na.rm = TRUE) : 합, 결측값을 제외하고 계산하려면 na.rm = TRUE 추가
'''

#Cars93 데이터 프레임에서 가격(Price)의 (a) 평균, (b) 중앙값, (c) 표준편차, (d) 최소값, (e) 최대값, (f) 사분위수(IQR), (g) 합계

Cars93 %>% summarise(Price_mean = mean(Price, na.rm = TRUE), # mean of Price
          Price_median = median(Price, na.rm = TRUE), # median of Price
          Price_sd = sd(Price, na.rm = TRUE), # standard deviation of Price
          Price_min = min(Price, na.rm = T), # min of Price
          Price_max = max(Price, na.rm = T), # max of Price
          Price_IQR = IQR(Price), na.rm = T, # IQR of Price
          Price_sum = sum(Price, na.rm = TRUE)) # sum of Price



#summarise(dataframe, n(), n_distinct(x), first(x), last(x), nth(x, n)) : 개수 계산, 관측값 indexing
'''
- n() : 관측치 개수 계산, x 변수 입력하지 않음
- n_distinct(x) : 중복없는 유일한 관측치 개수 계산, 기준이 되는 x변수 입력함
- first(x) : 기준이 되는 x변수의 첫번째 관측치
- last(x) : 기준이 되는 x변수의 마지막 관측치
- nth(x, n) : 기준이 되는x변수의 n번째 관측치
'''
#Cars93_1 데이터 프레임에서 (a) 총 관측치의 개수, (b) 제조사(Manufacturer)의 개수(유일한 값), (c) 첫번째 관측치의 제조사 이름, (d) 마지막 관측치의 제조사 이름, (e) 5번째 관측치의 제조사 이름
Cars93_1 <- Cars93[c(1:10), c("Manufacturer", "Model", "Type")] # subset for better print
Cars93_1

Cars93_1 %>% summarise( tot_cnt = n(), # counting the number of all observations
                        Manufacturer_dist_cnt = n_distinct(Manufacturer), # distinct number of var 
                        First_obs = first(Manufacturer), # first observation 
                        Last_obs = last(Manufacturer), # last observation 
                        Nth_5th_obs = nth(Manufacturer, 5)) # n'th observation



#summarise(group_by(dataframe, factor_var), mean, sd, ...): 그룹별 요약 통계ㄹ
#Cars93 데이터 프레임에서 '차종(Type)' 별로 구분해서 
#(a) 전체 관측치 개수, (b) (중복 없이 센) 제조사 개수, (c) 가격(Price)의 평균과 (d) 가격의 표준편차

group_df <- Cars93 %>% group_by(Type)
group_df %>% summarise(tot_conut = n(), # counting the number of cars
                       Manufacturer_dist_cnt = n_distinct(Manufacturer), # distinct number of var
                       Price_mean = mean(Price, na.rm = TRUE), # mean of Price
                       Price_sd = sd(Price, na.rm = TRUE) # standard deviation of Price
                       )


#summarise_each() : 다수의 변수에 동일한 summarise 함수 적용
#Cars93 데이터 프레임의 (i) 가격(Price) 변수와 (ii) 고속도로연비(MPG.highway) 의 두개의 변수에 대해 
#(a) 평균(mean), (b) 중앙값(median), (c) 표준편차(standard deviation) 의 3개의 함수를 동시에 적용
Cars93 %>% summarise_each( funs(mean, median, sd), Price, MPG.highway)


###############################################
#그룹별로 행의 개수 세기 
#dataframe %>% group_by( factor ) %>% summarise(n=n())
#차 종류(Type) 별로 그룹개수 세기
Cars93 %>% group_by(Type) %>% summarise(n=n())
Cars93 %>% group_by(Type) %>% summarise(n=n(), n_distinct_maker= n_distinct(Manufacturer))

#dataframe %>%  group_by( factor ) %>% tally()
Cars93 %>% group_by(Type) %>% tally()

#dataframe %>%count( factor )
Cars93 %>% count(Type) 
# doing both grouping and counting (no need for group_by())



###############################################
###############################################
#join 함수
####data frame을 조건에 맞게 join 시켜줌 ,sql 하고 비슷
####left , right , inner, full join 이 있음
set.seed(1)

log <- data.frame( user_id = sample(c(1,2,3), 10, TRUE), item_id =
                     sample( c(1,2,3), 10, TRUE ), correct = sample(c(0,1), 10, TRUE) )
users <- data.frame( user_id = c(1,2,4), age = c(20,20,30) )
items <- data.frame( item_id = 1:3, item = c("1+1","2*2","3/3") )

log ; users; items
#user_id 가 key 값 으로 dataframe 이 join된다

log %>% left_join(users,"user_id")
log %>% left_join(users,"user_id") %>% left_join(items,"item_id")

log %>% right_join(users,"user_id")

log %>% inner_join(users,"user_id")
log %>% inner_join(users,"user_id") %>% inner_join(items,"item_id")


log %>% full_join(users,"user_id")













