# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 18:42:37 2021

@author: kim3
"""

import pandas as pd
import re
import requests
from tqdm import tqdm
from datetime import datetime

now = datetime.now()
dt_string = now.strftime("_%d%m%Y_%H%M%S")
enddir = 'D:\\development\\'
endfile = enddir + 'ka_scrape' + dt_string + '.csv'

url_list = []
url_file = 'https://raw.githubusercontent.com/kim3-sudo/soccer_goal_analysis/main/src/scrape/sources.txt'
src_file = requests.get(url_file)
text = src_file.text.split("\n")
for line in text:
    print(line)
    url_list.append(line)

df = pd.DataFrame()

for url in tqdm(url_list):
    dfs = pd.read_html(url, header=0)
    playdf = dfs[1].head()
    playerList = []
    goalnoList = []
    assistList = []
    playtyList = []
    for index,row in playdf.iterrows():
        try:
            player = re.findall(r'.{3,} \(', row['Description'])[0]
            player = player[:-2]
            playerList.append(player)
        except:
            print('Could not get player')

        try:
            goalno = re.findall(r'(\d)', row['Description'])[0]
            goalnoList.append(goalno)
        except:
            print('Could not get goalno')

        try:
            assist = re.findall(r'Assisted\sBy:\s.{3,}\s\s', row['Description'])[0]
            assist = assist.lstrip('Assisted By: ')
            assist = assist.rstrip(' ')
            assistList.append(assist)
        except:
            print('No assist data.')
            assistList.append('')

        try:
            playty = re.findall(r'\w\s\s.{3,}', row['Description'])[0]
            playty = playty[3:]
            playtyList.append(playty)
        except:
            try:
                playty = re.findall(r'\)\s\s.{3,}', row['Description'])[0]
                playty = playty[3:]
                playtyList.append(playty)
            except:
                playtyList.append('PK')

    print('Trying to append playerList')
    try:
        playdf['Player'] = playerList
    except:
        pass

    print('Trying to append goalnoList')
    try:
        playdf['GoalNo'] = goalnoList
    except:
        pass

    print('Trying to append assistList')
    try:
        playdf['Assist'] = assistList
    except:
        pass

    print('Trying to append playtyList')
    try:
        playdf['PlayType'] = playtyList
    except:
        pass

    df = df.append(playdf, ignore_index=True)

print(df)
df.to_csv(endfile)
print('All done!')
