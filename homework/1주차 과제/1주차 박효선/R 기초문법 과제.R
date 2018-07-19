###과제


# 1. sum() 함수와 똑같은 기능을 하는 함수를 for문을 이용하여 작성하시오.


fuc_sum = function(x){
  a=0
  for(i in x){
    a=a+x[i]
  }
  return(a)
}

fuc_sum(c(1,2,3,4))

# 2. which.max() 함수와 똑같은 기능을 하는 함수를 for문, if문을 이용하여 작성하시오.


fuc_max = function(x){
  a=x[1]
  for(i in x){
    if (x[i] > a){
      a=x[i]
    }
  }
}


which.max(c(1,2,3,4))



#3.for문을 이용하여 피보나치 수열을 작성하시오.

fibo = function(x){
  fibo1<-1
  fibo2<-1
  for(i in 3:x){
    tmp <-fibo1+fibo2
    fibo1<- fibo2
    fibo2<- tmp
  }
  return(fibo2)
      
}

fibo(10)


#4. 1 + 1/(1+2) + 1/(1+2+3) +...+ 1/(1+2+..+N) 을 함수로 구현하시오.

fuc4 = function(n){
  sum=0
  oh=0
  for(i in 1:n){
    oh=oh+i
    a=1/oh
    sum=sum+a
  }
  return(sum)
}

fuc4(3)

1+1/3+1/6

#5. for 문을 활용해서  *         만들어주세요!!
#                      **
#                      ***
#                      ****
#                      *****

for(i in 1:5){
  for(j in 1:i){
    cat('*') 
  }
  cat('\n')
}

?cat()
?print()
