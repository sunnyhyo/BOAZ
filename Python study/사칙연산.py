# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 14:37:29 2018

@author: HS PARK
"""
#사칙연산 두번
class calcal:
    def __init__(self):
        self.input = input("사칙연산: ")
        self.a = int(self.input[0])
        self.b = self.input[1]
        self.c = int(self.input[2])
        
        if self.b =="+":
            self.sum()
        elif self.b =="-":
            self.sub()
        elif self.b =="*":
            self.mul()
        else:
            self.div()

    def sum(self):
        print(self.a+self.c)
    def sub(self):
        print(self.a-self.c)
    def mul(self):
        print(self.a*self.c)
    def div(self):
        print(self.a/self.c)
    

a= calcal()
