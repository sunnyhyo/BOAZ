# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 13:57:07 2018

@author: HS PARK
"""

class cal:
    def __init__(self):
        self.AB = input()
        self.A = int(self.AB.split(" ")[0])
        self.B = int(self.AB.split(" ")[1])
    def summ(self):
        return self.A+self.B
        
    def sub(self):
        return self.A-self.B
    
    def mul(self):
        return self.A*self.B
    def div(self):
        return self.A/self.B

a= cal()
a.summ()
a.sub()
a.mul()
a.div()     