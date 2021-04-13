### Soccer Goal Analysis
### Josh Katz & Sejin Kim
### STAT 306 S21 @ Kenyon College

### This will contain some R code as we analyze goal scoring data over the last x years for Manchester United and Columbus Crew
library(mosaic)
library(tidyverse)
library(data.table)

setwd("/Users/joshkatz/Desktop/fbresults") ## Other users (Sejin) change this to wherever you stored the scraped data

### Load Manchester United Data, 
files <- list.files(pattern = "fbr_scrape_06042021_215822_manutd_2018_")
manutd_2018 <- bind_rows(lapply(files, fread))
manutd_2018 <- manutd_2018 %>%
  mutate(season = "2017-18")

files <- list.files(pattern = "fbr_scrape_06042021_215822_manutd_2019_")
manutd_2019 <- bind_rows(lapply(files, fread))
manutd_2019 <- manutd_2019 %>%
  mutate(season = "2018-19")

files <- list.files(pattern = "fbr_scrape_06042021_215822_manutd_2020_")
manutd_2020 <- bind_rows(lapply(files, fread))
manutd_2020 <- manutd_2020 %>%
  mutate(season = "2019-20")

files <- list.files(pattern = "fbr_scrape_06042021_215822_manutd_2021_")
manutd_2021 <- bind_rows(lapply(files, fread))
manutd_2021 <- manutd_2021 %>%
  mutate(season = "2020-21")

manutd <- rbind(manutd_2018,manutd_2019,manutd_2020,manutd_2021)
manutd <- manutd %>%
  filter(squad == "Manchester Utd")

### Load Columbus Crew Data
files <- list.files(pattern = "fbr_scrape_06042021_215918_colcrew_2018")
colcrew_2018 <- bind_rows(lapply(files, fread))
colcrew_2018 <- colcrew_2018 %>%
  mutate(season = "2018")

files <- list.files(pattern = "fbr_scrape_06042021_215918_colcrew_2019")
colcrew_2019 <- bind_rows(lapply(files, fread))
colcrew_2019 <- colcrew_2019 %>%
  mutate(season = "2019")

files <- list.files(pattern = "fbr_scrape_06042021_215918_colcrew_2020")
colcrew_2020 <- bind_rows(lapply(files, fread))
colcrew_2020 <- colcrew_2020 %>%
  mutate(season = "2020")

colcrew <- rbind(colcrew_2018,colcrew_2019,colcrew_2020)
colcrew <- colcrew %>%
  filter(squad == "Columbus")




