# -*- coding: utf-8 -*-
"""
Created on Thu Jul 26 13:54:38 2018

@author: HS PARK
"""

class cals:
    def __init__(self):
        self.value=0                 #결과값
        self.user_input=[]
        self.user_operater=[]        #연산자
        self.user_num=[]             #항
        self.operater=["+","-","*","/"]
        
    def input(self):
        oh = input("식입력: ")
        for i in oh :
            if (self.user_input == []) | (i in self.operator):
                self.user_input.append(i) 
            elif i ==' ' : 
                pass
            else:
                try:
                    int(i)
                    self.user_num.append(int(i))
                except ValueError:
                    self.user_operater.append(i)

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
                
                
                
                
    def opr(self, num1, num, operator):
        if operator == self.operator[0]:
            num1 += num
        elif operator == self.operator[1]:
            num1 -= num
        elif operator == self.operator[2]:
            num1 *= num
        elif operator == self.operator[3]:
            try:
                num1 /= num
            except ZeroDivisionError:
                print("0으로는 나눌 수 없습니다")
        return num1


a = cals()
a.input()
a.term()
a.output()