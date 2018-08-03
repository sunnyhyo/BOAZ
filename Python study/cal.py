# -*- coding: utf-8 -*-
"""
Created on Thu Jul 26 13:46:02 2018

@author: HS PARK
"""


class Stack:
    def __init__(self):
        self.A = list()
    
    def isEmpty(self):
        return len(self.A) == 0
    
    def __len__(self):
        return len(self.A)
   
    def idx(self, i):
        return self.A[i]
    
    def push(self,item):
        self.A.append(item)
        
    def pop(self):
        assert not self.isEmpty(), "스택 공백 오류"
        return self.A.pop()
    
    def peek(self):
        assert not self.isEmpty(), "스택 공백 오류"
        return self.A[-1]
    
    def printstack(self):
        for i in range(0,len(self.A)):
            print(self.A[i])
        

def to_infix(eq):
    infix_list = []
    number_list = []
    op = ""
    for i in range(0,len(eq)):
        if eq[i].isdigit() :
            if i == len(eq) - 1:
                number_list.append(eq[i])
                number_list.reverse()
                num = 0
                d = 0
                for n in range(0,len(number_list)):
                    num = num + int(number_list[n])*(10**d)
                    d = d + 1
                infix_list.append(num)
            else : 
                number_list.append(eq[i]) 
        else:
            op = eq[i]
            if len(number_list) == 0 :
                infix_list.append(op)
            else :
                number_list.reverse()
                num = 0
                d = 0
                for n in range(0,len(number_list)):
                    num = num + int(number_list[n])*(10**d)
                    d = d + 1
                number_list = []
                infix_list.append(num)
                infix_list.append(op)
    return infix_list

def to_postfix(infix_list):
    post_list = []
    op_list = Stack()
    pre = {"(":0, ")":0, "+" : 1, "-" : 1, "*" : 2, "/" : 2}
    for i in range(0,len(infix_list)):
        if type(infix_list[i]) == int :
            post_list.append(infix_list[i])
        elif infix_list[i] == "(":
            op_list.push(infix_list[i])
        elif infix_list[i] == ")":
            while (op_list.isEmpty() == 0):
                op = op_list.pop()
                if (op == "(") :
                    break
                else :
                    post_list.append(op)
        elif infix_list[i] in ["+","-","*","/"]:
            while(op_list.isEmpty() == 0):
                op = op_list.peek()
                if ( pre[infix_list[i]] <= pre[op] ):
                    post_list.append(op)
                    op_list.pop()
                else:
                    break
            op_list.push(infix_list[i])
    while(op_list.isEmpty() == 0):
        op = op_list.pop()
        post_list.append(op)
        
    return post_list          

def cal(post_list):
    ans_list = []
    for i in range(0,len(post_list)):
        c = post_list[i]
        if type(c) == int :
            ans_list.append(c)
        else :
            temp2 = ans_list.pop()
            temp1 = ans_list.pop()
            if c == "+" : 
                ans_list.append(temp1+temp2)
            elif c == "-":
                ans_list.append(temp1-temp2)
            elif c == "*":
                ans_list.append(temp1*temp2)
            elif c == "/":
                ans_list.append(temp1/temp2)
    return ans_list.pop()


eq = input("식을 입력하세요: "  )
eqinfix_list = to_infix(eq)
print("중위표기법: ",eqinfix_list)
eqpostfix_list = to_postfix(eqinfix_list)
print("후위표기법: ",eqpostfix_list)
ans = cal(eqpostfix_list)  
print("입력한 식의 답: ", ans)