

##모델 평가 및검증  

setwd("C:/Users/HS/Documents/GitHub/2018summerBoAZ/R/data")

if(!require(caret)) install.packages("caret"); library(caret)
if(!require(randomForest)) install.packages("randomForest"); library(randomForest)
if(!require(C50)) install.packages("C50"); library(C50)
if(!require(ROCR)) install.packages("ROCR"); library(ROCR)
if(!require(e1071)) install.packages("e1071"); library(e1071)

################################
### linear regression model ####
################################

# 1)첫번째  방법
data.url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'
red.wine = read.csv(url(data.url), sep = ';')
head(red.wine)

model = lm(quality ~ alcohol, red.wine) #linear regression , independent value, dependent
#Multiple R-squared:  0.2267,	Adjusted R-squared:  0.2263 %만큼 설명하고 있다
summary(model)


# 2)두번째 방법
set.seed(123)
idx = createDataPartition(red.wine$quality, p=.8, list=F)
data.train = red.wine[idx, ]
data.test = red.wine[-idx, ]

lin.model = train(
  quality ~ .,
  data=data.train,
  method='lm')

y.pred = predict(lin.model, data.test)
RMSE(data.test$quality, y.pred)
R2(data.test$quality, y.pred) 


#MSE(mean squared error) : 평균제곱오차 
#예측과 실제의 차이_오차를 모두 제곱한 다음에 평균 낸것 -> 작을수록 좋다.
#단점: 크고,작음을 직관적으로 알기 어렵다 

#결정계수(coefficient of determination) 
#변수들이 회귀식을 얼마나 설명해주고 있는가를 알려줌 -> 클수록 좋다.


###########################
###### random forest ######
###########################

data<-read.delim("Hshopping.txt", stringsAsFactors=FALSE)
head(data)

## 우리가 알고 싶은 변수는? = 반품여부
## C50 패키지의 경우 우리 알고싶은 변수를 Factor화 해줘야 함
data$반품여부<-factor(data$반품여부)

# set.seed() 설정을 해주면 결과값이 똑같이 나오게됨
set.seed(123)

# 데이터 나누기(sampling  train=7 : test=3)
idx<-createDataPartition(y=data$반품여부, p=0.7, list=FALSE)

data.train<-data[idx,]
data.test<-data[-idx,]

# 모델 구축
rf_model <- randomForest(반품여부 ~ . -ID, data=data.train, ntree=500, mtry=2)

# confusion matrix로 확인

rf_pred<-predict(rf_model, data.test, type="response")
confusionMatrix(rf_pred, data.test$반품여부)

#TP(True Positive) : 36
#TN(True negative) : 94
#FP(False Positive) : 9
#FN(False Negative) : 10

# accuracy : (TP+TN) / N
(36+94)/(36+94+9+10) 


# ROC curve
data.test$rf_pred_prob<-predict(rf_model, data.test, type="prob")
rf_pred2<-prediction(data.test$rf_pred_prob[,2],data.test$반품여부)
rf_model.perf1 <-performance(rf_pred2, "tpr", "fpr") # ROC-chart
plot(rf_model.perf1)

#true positive rate : sensitivity, false positive rate:1-specifitivy
#performance:모형에 관한 measure를 측정해준다

#AUC
performance(rf_pred2, "auc")@y.values[[1]] #0.5< AUC< 1 : 1에 가까울수록 좋다.


#####################
##### Xgboost #######
#####################

red.url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'
white.url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv'

red.wine = read.csv(url(red.url), sep = ';')
white.wine = read.csv(url(white.url), sep = ';')

red.wine$color = 'red'
white.wine$color = 'white'

wine = rbind(red.wine, white.wine)

set.seed(1234)

idx = createDataPartition(wine$color, p=.8, list=F)

data.train = wine[idx, ]
data.test = wine[-idx, ]

control = trainControl(method='cv', search='grid', number=5)

#nrounds: 최대 반복 횟수 (> 0)
#eta 학습률. eta를 낮추면 모형의 과적합 가능성은 낮아지지만 학습 속도가 느려진다.(0 ~ 1)
#gamma 트리에서 가지를 추가로 치기 위해 필요한 최소한의 손실 감소 기준. 기준값이 클 수록 모형이 더 단순해진다.(> 0)
#max_depth 트리의 최대 깊이.(> 0)
#min_child_weight 트리에서 가지를 추가로 치기 위해 필요한 최소한의 사례 수.(> 0)
#colsample_bytree 각각의 트리를 만들 때 데이터에서 사용할 열(column)의 비율(0 ~ 1)


xgb.grid = expand.grid(
    .nrounds = 100,
    .eta = 0.5,
    .gamma = 1,
    .max_depth = c(3, 5),
    .min_child_weight = 1,
    .colsample_bytree = 1,
    .subsample = 0.8
)

xgb.model <- train(
    color ~ .,
    data = data.train,
    tuneGrid = xgb.grid,
    trControl = control,
    method = 'xgbTree'
)

xgb_pred = predict(xgb.model, data.test)

data.test$color <- as.factor(data.test$color)
confusionMatrix(xgb_pred, data.test$color)


