setwd("C:/Users/HS/Documents/GitHub/2018summerBoAZ/homework/5주차 과제")
set.seed(180808)
library(caret)

######1.
# caret의 confusionMatrix 이용하여 predict된 결과의 성능을 확인하세요
## 기회가 된다면 Kappa 통계량에 대해 좀더 알아보세요
sms_results <- read.csv("sms_results.csv")
head(sms_results)
table(sms_results$actual_type, sms_results$predict_type)


confusionMatrix(sms_results$actual_type, sms_results$predict_type)

######2.
#glm 모델의 성능을 평가합니다
##ifelse 함수를 이용해 glm$fitted.values가 0.5 이상이면 yes, 아니면 no로 지정하고 결과를 out에 할당하세요(factor)
###역시 confusionMatrix로 성능을 확인하세요

credit <- read.csv("credit.csv")
glm <- glm(default ~ ., data=credit,family = binomial)
summary(glm)
head(glm$fitted.values)

out = glm$fitted.values
out[glm$fitted.values >= 0.5] = 'yes'
out[glm$fitted.values < 0.5] = 'no'
out = as.factor(out)

table(credit$default,out)
confusionMatrix(credit$default,out)
