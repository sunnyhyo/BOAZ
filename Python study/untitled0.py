# -*- coding: utf-8 -*-
"""
Created on Thu Jul 26 18:33:46 2018

@author: HS PARK
"""

#crawling1

from selenium import webdriver
dr = webdriver.Chrome("C:\\Users\\HS\Desktop\\chromedriver_win32\\chromedriver")
dr.get("https://www.naver.com")
drt = dr.page_source ; drt
dr.find_element_by_css_selector('span[class="tb_t"]').text

ele = dr.find_element_by_css_selector('a[data-grid="UAT_2966882"]')
ele.find_element_by_tag_name('img')



#find_elements  처음 발견한 것만 반환
#find_elements  발견한 모든 것 반환
#crawling2
from selenium import webdriver
dr = webdriver.Chrome("C:\\Users\\HS\Desktop\\chromedriver_win32\\chromedriver")
dr.get("https://store.musinsa.com/app/items/lists/001001")
drt = dr.page_source ; drt
dr.find_element_by_class_name('division_search_input')


_name("division_search_input")[0].send_keys(50000)
_name("division_search_input")[1].send_keys(100000)