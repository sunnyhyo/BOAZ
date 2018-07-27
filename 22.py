# -*- coding: utf-8 -*-
"""
Created on Thu Jul 26 13:54:38 2018

@author: HS PARK
"""

class cals:

    def __init__(self):
        self.value=0            #결과값
        self.operater=[]        #연산자
        self.num=[]         #항

        
    def input(self):
        oh = input("식입력")
        for i in oh :
            if i ==' ' : 
                pass
            else:
                try:
                    int(i)
                    self.num.append(int(i))
                except ValueError:
                    self.num.append("@")
                    self.operater.append(i)

        print(self.num)
        print(self.operater)


    def term(self):
        trm=0
        oper=""
        for i in self.num:
            if self.num!= "@":
                trm+=self.num[i]
            else:
                oper=self.num[i]
                
    def output(self,trm,oper):
        if oper=="+":
             self.value +=trm
        if oper=="-":
            self.value -=trm
        if oper=="*":
            self.value *=trm
        
        print(self.value)

a = cals()
a.input()
a.term()
a.output()