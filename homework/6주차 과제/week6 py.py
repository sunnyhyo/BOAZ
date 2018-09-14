# -*- coding: utf-8 -*-
"""
Created on Thu Aug 30 11:02:02 2018

@author: HS PARK
"""

from sklearn import datasets
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
import matplotlib.pyplot as plt
import pandas as pd

#load data
boston = datasets.load_boston()

X = pd.DataFrame(boston.data, columns = boston.feature_names)
y = pd.DataFrame(boston.target, columns = ['y'])

data = pd.concat([X,y],axis=1 )

data.head()


# y~ LSTAT
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(X, y, test_size = 0.3)
x1_test = x_test['LSTAT']
x1_train = x_train['LSTAT']


import numpy as np
x1_test = np.array(x1_test).reshape(-1,1)
x1_train = np.array(x1_train).reshape(-1,1)

model=LinearRegression()
model.fit(x1_train,y_train)

coef = model.coef_
intercept = model.intercept_
print("intercept : ", intercept)
print("coef : ", coef)

#y= 34.1869 - 0.93117293LSTAT


y1_predict = model.predict(x1_test)
mse = mean_squared_error(y_test, y1_predict)
r2 = r2_score(y_test, y1_predict)
print('mean_squared_error:', mse)
print('r2_score:', r2)

# mean_squared_error: 33.90495197458899
# r2_score: 0.4680246981072772


#산점도
plt.scatter(x1_test, y_test)
plt.plot(x1_test,y1_predict , color='black')
plt.show()

#상관계수 절대값 낮은 col 'CHAS'
abs(data.corr(method='pearson').iloc[:,12]) #CHAS


# y~LSTAT + CHAS
x2_test = x_test[['LSTAT','CHAS']]
x2_train = x_train[['LSTAT','CHAS']]
model.fit(x2_train,y_train)


coef = model.coef_
intercept = model.intercept_
print("intercept : ", intercept)
print("coef : ", coef)
# yhat = 33.6868 - 0.9187LSTAT + 5.0486028CHAS



y2_predict = model.predict(x2_test)
mse2 = mean_squared_error(y_test, y2_predict)
r22 = r2_score(y_test, y2_predict)
print('mean_squared_error:', mse2) #mean squared error값 감소
print('r2_score:', r22) #r-squared값 증가

#mean_squared_error: 37.7023442569815
#r2_score: 0.5360687753240907

