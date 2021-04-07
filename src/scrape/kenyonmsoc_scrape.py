# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 18:42:37 2021

@author: kim3
"""

import pandas as pd
import requests
from tqdm import tqdm
from bs4 import BeautifulSoup
from datetime import datetime

now = datetime.now()
dt_string = now.strftime("_%d%m%Y_%H%M%S")
enddir = 'D:\\development\\'
endfile = enddir + 'ka_scrape' + dt_string + '.csv'

print('Attempting to scrape')

games = pd.read_csv('D:\\development\\scratch\\2016_MSOC.csv')
games_df = games['url']
for i in tqdm(games_df):
    time.sleep(1.0)
    url = i
    data = requests.get(url)
    soup = BeautifulSoup(data.text, 'lxml')
    
    goal_table = soup.find("table", attrs = {'class': 'overall-stats'})
    times = goal_table.find_all("th", attrs = {'scope': 'row'})
    scorer = goal_table.find_all("span", attrs = {'class': 'text-bold'})
    assist = goal_table.find_all("span", attrs = {'class': 'text-italic'})
    method = goal_table.find_all("span", attrs = {'class': 'text-capitalize'})
    
    times_list = []
    for i in tqdm(times):
        result = i.text.strip()
        times_list.append(result)
        
    scorer_list = []
    for i in tqdm(scorer):
        result = i.text.strip()
        scorer_list.append(result)
        
    assist_list = []
    for i in tqdm(assist):
        result = i.text.strip()
        assist_list.append(result)
    
    method_list = []
    for i in tqdm(method):
        result = i.text.strip()
        method_list.append(result)
        
    df = pd.DataFrame()
    
    df['times'] = times_list
    df['scorer'] = scorer_list
    df['assist'] = assist_list
    df['method'] = method_list
    
    print('Generating CSV output')
    try:
        with open(endfile, 'a') as f:
            df.to_csv(endfile, header = None, line_terminator = '\n')
    except Exception as e:
        print('Scrape failure')
        print('Failed with code:', str(e))

print('All done!')