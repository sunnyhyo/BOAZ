
from bs4 import BeautifulSoup
from urllib.request import urlopen
import pandas as pd
import csv
import requests
import re


# 크롤링한 파일 저장 경로
file_path = 'C:\\Users\\HS\\Documents\\GitHub\\2018summerBoAZ\\homework\\3주차 과제'
file_name = 'result_example.csv'
page_num = []
star = []
review = []

for i in range(1,16):
    url ="http://deal.11st.co.kr/product/SellerProductDetail.tmall?method=getProductReviewList&prdNo=87595509&page="+str(i)+"&pageTypCd=first&reviewDispYn=Y&isPreview=false&reviewOptDispYn=n&optSearchBtnAndGraphLayer=n&reviewBottomBtn=Y&openDetailContents=Y&pageSize=10&isIgnoreAuth=false&lctgrNo=1001369&leafCtgrNo=0&groupProductNo=0&groupFirstViewPrdNo=0&selNo=16674487#this"
    url2 = urlopen(url)
    soup = BeautifulSoup(url2,"html.parser") 
    
    reviews = soup.find_all("a",{"id":"reviewContTxt"})
    p = re.compile('^selr_star selr_star')
    stars= soup.find_all("span", class_=p)
    star_list = [int(x.text[-2]) for x in stars]
    
    for ii in reviews:
        review.append(ii.text.strip())
        
    for jj in star_list:
        star.append(jj)
        page_num.append(i)



result = pd.DataFrame({'페이지': page_num, '별점': star, '리뷰': review})
result 

