# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 14:40:10 2018

@author: HS PARK
"""

import os
os.chdir('C:/Users/HS/Documents/GitHub/2018summerBoAZ/Python study')
from day1 import calcul

test = calcul()

test.input()
print(test.sum(7))
print(test.sum(2))
print(test.sub(4))
print(test.mul(2))
print(test.div(0))
print(test.sum(8))

test2 = calcul()

test2.input()
print(test2.sum(7))
print(test2.sum(2))
print(test2.sub(4))
print(test2.mul(2))
print(test2.div(0))
print(test2.sum(8))

