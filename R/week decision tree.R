
#Decision tree 방법은 회귀(regression) 및 분류(classification)에 사용되는 방법이다.
#Tree-based method는 여러가지 방법이 있지만 대표적으로 세 가지 방법이 있다.


####################################################################################
#1. tree 패키지 [ iris 데이터 사용 ]################################################
####################################################################################

# 1) 데이터 준비
df<-iris

library(caret)
set.seed(0329) #reproducability setting
intrain<-createDataPartition(y=df$Species, p=0.7, list=FALSE) 
train<-df[intrain, ]
test<-df[-intrain, ]


# 2) 의사결정 나무 만들기
library(tree)
treemod<-tree(Species~. , data=train) 
treemod
#105개 데이터 , 들여쓰기 가지, 0.33 비율

plot(treemod)
text(treemod)

# 3) 가지치기 (Pruning) - 과적합 문제 해결

prunes= prune.misclass(treemod)  #3에서 오분류가 제일 낮기 때문에 
plot(prunes)
prune.trees <- prune.misclass(treemod, best=3) #3개로 나눈다
plot(prune.trees)
text(prune.trees)


# 4) 예측하기 & 모델 평가
library(e1071)
treepred <- predict(prune.trees, test, type='class')
confusionMatrix(treepred, test$Species)

#########################################################
#2. rpart 패키지

library(rpart)
rpartmod<-rpart(Species~. , data=train, method="class")
plot(rpartmod)
text(rpartmod)


#깔끔한 플랏 : party, tree는 불가
install.packages('rattle')
library(rattle) # Fancy tree plot
fancyRpartPlot(rpartmod)


# 가지치기 : tree패키지 cv.tree와 유사한 함수 사용
printcp(rpartmod) # cross-validation 계산 함수
plotcp(rpartmod)

#xerror가 가장 낮은 size를 선택하면 됨. => 3

ptree<-prune(rpartmod, cp= rpartmod$cptable[which.min(rpartmod$cptable[,"xerror"]),"CP"]) 


plot(ptree)
text(ptree)

# 예측 및 정확성 평가.
rpartpred<-predict(ptree, test, type='class')
confusionMatrix(rpartpred, test$Species)



#cf. party 패키지

library(party)
partymod<-ctree(Species~., data=train)
plot(partymod)

# 이렇게도 표현 가능.
plot(partymod, inner_panel = node_barplot,
     edge_panel = function(...) invisible(), tnex = 1)

#예측 및 정확성 평가

partypred<-predict(partymod, test)
confusionMatrix(partypred, test$Species)  

##############################################
#### 앙상블 ##################################
##############################################


##### 랜덤포레스트 

# 상대적으로 모델이 불안정한 단점이 있는데 그것을
# Boostrapping, bagging의 방법으로 모델의 정확성을 높일 수 있다.

#다수의 의사결정나무(Decision Tree)를 만든 후 최빈값을 기준으로 예측/분류하는 알고리즘이다.
#Bagging/Bootstrap Aggregating 방법을 사용해 의사결정나무 노드 생성의 Bias를 줄이므로 
#의사결정나무의 과적합화 문제를 해결할 수 있는 대안으로 사용할 수 있다.

#데이터의 일부를 추출하여 의사 결정 나무를 만드는 작업을 반복하고,
#이렇게 만들어진 다수의 의사 결정 나무들의 투표로 최종 결과를 출력한다.
#각 가지를 나누는 변수를 선택할 때 전체 변수를 매번 모두 고려하는 대신 변수의 일부를 임의로 선택한다.


#모델
library(randomForest)
m <- randomForest(Species ~ ., data = iris)
m

#모델을 출력하면 모델 훈련에 사용되지 않은 데이터를 사용한 에러 추정치를 볼 수 있다.
#예측은 Generic Function인 predict()를 사용해 수행한다.

predict(m, newdata = iris)

####################################################################################
#1. X와 Y의 직접 지정###############################################################
####################################################################################

#randomForest()는 설명변수(X)와 예측 대상이 되는 분류(Y)를 인자로 직접 지정할 수 있다.

m <- randomForest(iris[, 1:4], iris[, 5])
m

####################################################################################
#2. 변수 중요도 평가################################################################
####################################################################################

#randomForest()는 설명 변수의 중요도를 평가하는데 사용할 수 있다.
#각 변수들이 모델의 정확도에 얼마만큼 기여하는지를 통해 변수의 중요도를 판별한다.
#변수의 중요도를 평가한 결과를 변수 선택 방법 중 Filter Method에 활용 가능하다.
#randomForest() 호출시 importance = TRUE를 지정한다. 그 뒤 importance(), varImpPlot()를 사용해 결과를 출력한다.

m <- randomForest(Species ~ ., data = iris, importance = TRUE)
importance(m)
varImpPlot(m)

#해석 방법 - 참고
# MeanDecreaseAccuracy[정확도]에서는 Petal.Length, Petal.Width, Sepal.Length, Sepal.Width 순으로 변수가 중요함을 알 수 있다.
# MeanDecreaseGini[노드 불순도 개선]에서는 Petal.Width, Petal.Length, Sepal.Length, Sepal.Width 순으로 중요하다.


####################################################################################
#3. 파라미터 튜닝###################################################################
####################################################################################

#트리 개수는 ntree, 가지를 칠 때 고려할 변수의 갯수는 mtry로 각각 정한다.
#expand.grid를 사용해 가능한 조합의 목록을 만들 수 있다.

grid <- expand.grid(ntree = c(10, 100, 200), mrty = c(3, 4))
grid

#이 파라미터 조합을 10개로 분할한 데이터(즉, K=10로 한다는 소리)에 적용하여 모델의 성능을
#평가하는 일을 R회 반복하면 교차 검증을 사용한 파라미터를 찾을 수 있게 된다.
install.packages("cvTools")
library(cvTools)
library(foreach)

#참고
#cvTools는 cvFolds를 사용하기 위함이고, cvFolds는 난수를 사용하여 데이터를 분리한다.
#foreach는 값을 반환하여 결과를 한번에 모으는 데 사용하고, .combine을 사용해 결과가 리스트가 아닌 다른 형태로 되게한다.
#randomForest()는 모델의 성능과 변수의 중요도를 평가하기 위해 사용되었다.

set.seed(0329)
K = 10  #cross 
R = 3
cv <- cvFolds(NROW(iris), K = K, R = R)

#cvFolds 참고
#cvFolds의 첫번째 인자는 그룹으로 나눠질 관찰값들의 갯수를 의미한다.
#K는 몇개의 데이터 그룹(Folds)으로 나눌 것인지를 의미한다.
#R은 K-fold cross-validation을 몇 번 반복할 것인지를 의미한다.

#가능한 조합만들기
grid <- expand.grid(ntree = c(10, 100, 200), mtry = c(3, 4))
grid

?foreach   #병렬처리를 하기 위해 
result <- foreach(g = 1:NROW(grid), .combine = rbind) %do% {
  foreach(r = 1:R, .combine = rbind) %do% {
    foreach(k = 1:K, .combine = rbind) %do% {
      
      validation_idx <- cv$subsets[which(cv$which == k), r]
      train <- iris[-validation_idx, ]
      validation <- iris[validation_idx, ]
      
      # training
      m <- randomForest(Species ~ ., data = train, ntree = grid[g, "ntree"], 
                        mtry = grid[g, "mtry"])
      # prediction
      predicted <- predict(m, newdata = validation)
      
      # estimating performance
      precision <- sum(predicted == validation$Species)/NROW(predicted)
      return(data.frame(g = g, precision = precision))
    }
  }
}

# 참고
#cv$which는 몇번째 Fold인지를 나타내주므로 which(cv$which == k)는 는 k번째 Fold의 인덱스를 알려준다.
#그리고 r은 몇번째 반복인지를 나타내므로, cv$subsets[which(cv$which == k), r]는 반복 1의 k번째 Folds의 관찰값 인덱스를 반환한다.
#train데이터는 검증 데이터와 평가 데이터를 떼어놓은 뒤, 이를 제외한 나머지 데이터로, 모델을 생성한다.
#validation데이터는 검증데이터로, 예측한 값과 validation의 값을 비교해 모델의 분류 성능을 검증하기 위해 사용된다.
#foreach에서는 반환값이 리스트 형태이므로, 데이터를 데이터 프레임으로 모으기 위해 rbind를 사용하였다.

result

#g값마다 묶어 평균을 구한다.

library(plyr)

total<-ddply(result, .(g), summarize, mean_precision = mean(precision))
arrange(total,-mean_precision)


#ddply()수행결과 가장 높은 성능을 보인 조합은 1,3,5 번째이다.

grid[c(1,2,3), ]

####################################################################################
#### H20 앙상블 모형 ###############################################################
####################################################################################
#출처1 : https://statkclee.github.io/deep-learning/h2o-ensemble-higgs.html
#출처2 : http://docs.h2o.ai/h2o-tutorials/latest-stable/tutorials/ensembles-stacking/index.html
# 캐글 신용점수 사례

#2년안에 누가 신용불량자로 될 확률이 높은지 예측

#1. H20 클러스터 및 환경설정

#1)h2o 팩키지와 h2oEnsemble 패키지를 설치하고, H2O 클러스터를 생성한다.
#2)h2O 클러스터를 nthreads = -1 최대 코어수와 max_mem_size = '8g' 최대 메모리 8G를 설정하고 생성한다.

##=========================================================================
## 01. H2O 설치: http://learn.h2o.ai/content/tutorials/ensembles-stacking/
##=========================================================================
# 1. 기존 H2O 제거
#if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
#if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# 2. H2O 의존성 설치
pkgs <- c("methods","statmod","stats","graphics","RCurl","jsonlite","tools","utils")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}

# 3. H2O 설치
install.packages("h2o", repos=(c("http://s3.amazonaws.com/h2o-release/h2o/master/1497/R", getOption("repos"))))

# 4. h2o-ensemble 팩키지 설치
#library(devtools)
#install_github("h2oai/h2o-3/h2o-r/ensemble/h2oEnsemble-package")
install.packages("https://h2o-release.s3.amazonaws.com/h2o-ensemble/R/h2oEnsemble_0.1.8.tar.gz", repos = NULL)

#-------------------------------------------------------------------------
# 01.1. H2O 클러스터 환경설정
#-------------------------------------------------------------------------

library(h2o)
library(h2oEnsemble)  # This will load the `h2o` R package as well

h2o.init(nthreads = -1, ip = 'localhost', port = 54321, max_mem_size = '8g')  # H2O 클러스터를 최대 코어수에 맞춰 생성 

## 자바 64비트 설치되어있어야함. r 최신버전 이어야 함.

h2o.removeAll() # Clean slate - just in case the cluster was already running
# 작업 종료후 h2o 클러스터 종료 명령어
#h2o.shutdown()

#2.캐글 신용평가 데이터 준비
#Give Me Some Credit 데이터 다운로드 사이트로 이동해서 cs-training.csv (7.21 MB) 데이터를 다운로드 받는다.
#그리고, 종속변수 2년내 신용불량 여부가 SeriousDlqin2yrs 변수에 저장되어 있으니 이를 종속변수로 두고, 나머지를 독립변수로 설정한다.

##=========================================================================
## 02. H2O 데이터 가져오기
##=========================================================================

paste(getwd(),"cs-training.csv",sep='/')

train <- h2o.importFile(path = normalizePath(paste(getwd(),"cs-training.csv",sep='/')))

y <- "SeriousDlqin2yrs"
x <- setdiff(names(train), y)

train[,y] <- as.factor(train[,y])  

##=========================================================================
## 03. H2O 데이터 정제 과정
##=========================================================================

# 별도 정제 및 변환과정 생략

#3. 슈퍼학습기 모형 적합
#일반화 선형모형(GLM), 확률숲(RF), Gradient Boosting Machine, 딥러닝(DL)을 기본 학습기로 두고,
#2차 메타학습기로 일반화 선형모형(GLM)을 두는 슈퍼학습기 모형을 설정하고 H2O 클러스터에서 신용불량 예측모형을 개발한다.
# Stacking의 결합메카니즘은 classifier(Level O classifier)의 결과가 다른  classifier(Level 1 classifier)에 training data로 사용된다는 점이다.
# 참고: https://flonelin.wordpress.com/2016/08/02/stacking%EC%9D%B4%EB%9E%80/

##=========================================================================
## 04. 슈퍼 학습기
##=========================================================================

learner <- c("h2o.glm.wrapper", "h2o.randomForest.wrapper", 
             "h2o.gbm.wrapper")
metalearner <- "h2o.glm.wrapper"

fit <- h2o.ensemble(x = x, y = y, 
                    training_frame = train, 
                    family = "binomial", 
                    learner = learner, 
                    metalearner = metalearner,
                    cvControl = list(V = 5))

pred <- predict(fit, train)
predictions <- as.data.frame(pred$pred)[,3]  #third column is P(Y==1)
labels <- as.data.frame(train[,y])[,1]

# 4. 모형 평가

#cvAUC 팩키지를 통해 AUC 면적을 최대화한 개별 모형성능을 살펴본다.
#가장 성능이 좋게 나온 것은 확률숲(randomForest)으로 거의 1에 수렴하는 0.985가 나온다.

library(cvAUC)
L <- length(learner)
auc <- sapply(seq(L), function(l) cvAUC::AUC(predictions = as.data.frame(pred$basepred)[,l], labels = labels)) 
data.frame(learner, auc)

# https://www.researchgate.net/figure/Base-learning-versus-meta-learning_fig1_228376299
#슈퍼학습기를 통해 두번째 모형을 돌린 결과 성능이 0.9828640로 확률숲보다 약간 떨어지는 것으로 나온다.
#생각해보면 기본 학습기 중 일반화 선형모형의 AUC가 0.698로 낮은 것도 설명이 가능한 것으로 보인다.

cvAUC::AUC(predictions = predictions, labels = labels)

# boosting & bagging description
# https://www.slideshare.net/freepsw/boosting-bagging-vs-boosting