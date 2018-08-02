class calcul:
    def __init__(self):
        self.str=input('계산할 식을 입력해주세요: ')
        self.opr=[]
        self.idx=[]
        self.numbers=[]
        
        
    def outcome(self):
        for i in self.str:
            if i in ('+','-','*','/'):
                self.opr.append(i)
            else:
                print('올바른 식을 입력해주세요')
        self.str=self.str.split(self.str)
        for i in self.opr:
            self.str.remove(i)

        for n in range(len(self.opr)):
            if self.opr[n]=='+':
                return int(self.str[n])+int(self.str[(n+1)])
            elif self.opr[n]=='-':
                return int(self.str[n])-int(self.str[(n+1)])
            elif self.opr[n]=='*':
                return int(self.str[n])*int(self.str[(n+1)])
            elif self.opr[n]=='/':
                return int(self.str[n])/int(self.str[(n+1)])
            else:
                pass
            
cal=calcul()
print(cal.outcome())