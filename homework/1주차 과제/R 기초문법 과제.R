###과제
getwd()
sample<-read.delim("./sample.txt", header=TRUE)
head(sample)
sample
length(c(1,2,3))
nrow(sample)
class(c(1,2,3))
class(sample)
dim(sample)

# 1. sum() 함수와 똑같은 기능을 하는 함수를 for문을 이용하여 작성하시오.

sum(1,2,3)
sum(sample)
a<-c(1,2,3)
a[1]
a[2]
fuc_sum = function(x){
  if(class(x)=="numeric"){
    y=0
    for (i in 1:length(x)){
      y= y+x[i]
    }
    return(y)
  }
  if(class(x)=="data.frame"{
    y=0
    for(i in 1:dim(x)[1]){
      
    }
  }  
  }
fuc_sum(c(1,2,3))

# 2. which.max() 함수와 똑같은 기능을 하는 함수를 for문, if문을 이용하여 작성하시오.




#3.for문을 이용하여 피보나치 수열을 작성하시오.





#4. 1 + 1/(1+2) + 1/(1+2+3) +...+ 1/(1+2+..+N) 을 함수로 구현하시오.





#5. for 문을 활용해서  *         만들어주세요!!
#                      **
#                      ***
#                      ****
#                      *****

