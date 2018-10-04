# -*- coding: utf-8 -*-
"""
Created on Thu Jul 26 13:46:26 2018

@author: HS PARK
"""

class calculator:
    def __init__(self):
        self.value = 0
        self.user_input = []
        self.operator = ['+', '-', '*', '/']

    def input(self):
        ipt = input()
        for i in ipt:
            if (self.user_input == []) | (i in self.operator):
                self.user_input.append(i)
            elif i == " ":
                pass
            else:
                try:
                    self.user_input[-1] = int(self.user_input[-1])*10 + int(i)
                except ValueError:
                    self.user_input.append(i)

        # print(self.user_input)
        print("결과 : " , self.output())

    def output(self):
        self.value = int(self.user_input[0])
        now_opr = ''

        for i in self.user_input:
            if i in self.operator:
                now_opr = i
            else:
                self.value = self.opr(int(i), now_opr)

        return self.value


    def opr(self, num, operator):
        if operator == self.operator[0]:
            self.value += num
        elif operator == self.operator[1]:
            self.value -= num
        elif operator == self.operator[2]:
            self.value *= num
        elif operator == self.operator[3]:
            try:
                self.value /= num
            except ZeroDivisionError:
                print("0으로는 나눌 수 없습니다")
        return self.value


cal = calculator()
cal.input()