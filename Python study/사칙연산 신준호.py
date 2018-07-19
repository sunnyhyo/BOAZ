# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 14:30:57 2018

@author: HS PARK
"""


class calcul:
    def __init__(self):
        self.initval = 0

    def input(self):
        self.initval = int(input())
        return self.initval

    def sum(self,sum_num):
        self.initval = self.initval+sum_num
        return self.initval

    def sub(self,sub_num):
        self.initval = self.initval - sub_num
        return self.initval

    def mul(self,mul_num):
        self.initval = self.initval * mul_num
        return self.initval

    def div(self,div_num):
        try:
            self.initval = self.initval / div_num
            return self.initval
        except ZeroDivisionError:
            print('0으로는 나눌 수 없습니다.')
            return self.initval
    # def 
test = calcul()

print(test.sum(7))
print(test.sum(2))
print(test.sub(4))
print(test.mul(2))
print(test.div(0))
print(test.sum(8))