# -*- coding: utf-8 -*-
"""
Created on Tue Jul 24 16:57:28 2018

@author: HS PARK
"""
#%%
import requests as rq
import bs4
from bs4 import BeautifulSoup
#%%
url ="https://endic.naver.com/search.nhn?sLn=kr&isOnlyViewEE=N&query=%EC%82%AC%EA%B3%BC"
res =rq.get(url)
print(res)
#%%
soup =BeautifulSoup(res.content, "lxml")
print(soup.prettify())
#%%
results =soup.select("span.fnt_k05")
print(results)
for result in results:
    print(result.string)
#%%
soup.find_all('span',id)