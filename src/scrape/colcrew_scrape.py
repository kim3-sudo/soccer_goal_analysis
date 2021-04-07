# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 19:51:18 2021

@author: kim3
"""

import pandas as pd
import requests
from tqdm import tqdm
from bs4 import BeautifulSoup
from datetime import datetime
import re
import time

now = datetime.now()
dt_string = now.strftime("_%d%m%Y_%H%M%S")
enddir = 'D:\\development\\fbresults\\'
endfile = enddir + 'fbr_scrape' + dt_string

url_list = ['https://fbref.com/en/squads/529ba333/Columbus-Crew-Stats','https://fbref.com/en/squads/529ba333/2019/Columbus-Crew-Stats','https://fbref.com/en/squads/529ba333/2018/Columbus-Crew-Stats']
year = 2020

for i in url_list:
    print('On URL: ', i)
    url = i
    headers = {'User-Agent': 'Mozilla/5.0'}
    data = requests.get(url, headers = headers)
    
    soup = BeautifulSoup(data.text, 'lxml')
    
    table_extract = soup.find_all('table', attrs = {'class': 'stats_table', 'id': 'matchlogs_for'})[0]
    table_extract_items = table_extract.find_all('a')
    
    matches = []
    print('Getting list of matches')
    for anchor in tqdm(table_extract.find_all('a')):
        href = anchor['href']
        if '/en/matches/' in href:
            if href not in matches:
                matches.append('https://fbref.com' + href)
            else:
                pass
    
    print('Scraping data for each match')
    for i in tqdm(matches):
        time.sleep(1.0)
        url = i
        matchid = re.search('[\/]\S\S\S\S\S\S\S\S[\/]', url).group(0)
        matchid = matchid.strip('/')
        headers = {'User-Agent': 'Mozilla/5.0'}
        data = requests.get(url, headers = headers)
        
        soup = BeautifulSoup(data.text, 'lxml')
        
        table = soup.find("table", attrs = {'class': 'stats_table', 'id': 'shots_all'})
        data_rows = ''
        try:
            data_rows = table.find_all('tr')
        
            data = []
            for tr in data_rows:
                td = tr.find_all('td')
                row = [tr.text for tr in td]
                data.append(row)
            
            df = pd.DataFrame(data, columns = ['player','squad','outcome','distance','bodypart', 'note', 'sca1player','sca1event','sca2player','sca2event'])
            df.to_csv(endfile + '_colcrew_' + str(year) + '_' + str(matchid) + '.csv')
        except Exception as e:
            pass
        
        
    year -= 1
    
