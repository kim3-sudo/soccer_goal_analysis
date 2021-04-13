### This will contain some R code as we analyze goal scoring data over the last x years for Manchester United and Columbus Crew
library(mosaic)
library(tidyverse)
library(data.table)
library(stringr)

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

manutd_goals <- manutd %>%
  filter(outcome == "Goal")

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

colcrew_goals <- colcrew %>%
  filter(outcome == "Goal")

## Load Kenyon Data

kenyon <- read.csv("/Users/joshkatz/Desktop/ka_scrape_11042021_235957.csv")
kenyon <- kenyon %>%
  filter(Team == "KENM")

## Playing around with data

kenyon <- kenyon %>%
  mutate(
    from_corner = ifelse(
    stringr::str_detect(PlayType, "a corner") | stringr::str_detect(PlayType, "the corner"), 1, 0
  )) %>%
  mutate(
    penalty_kick = ifelse(
      stringr::str_detect(PlayType, "PENALTY KICK"),1,0)
  ) %>%
  mutate(
    is_assisted = ifelse(Assist == "",0,1)
  )


manutd_goals <- manutd_goals %>%
  mutate(
    penalty_kick = ifelse(
      stringr::str_detect(player, "(pen)"),1,0
    )
  ) %>%
  mutate(
    is_assisted = ifelse(stringr::str_detect(sca1event, "Pass") | stringr::str_detect(sca2event, "Pass") & penalty_kick == 0 & !stringr::str_detect(note, "Free kick"),1,0)
  )



colcrew_goals <- colcrew_goals %>%
  mutate(
    penalty_kick = ifelse(
      stringr::str_detect(player, "(pen)"),1,0
    )
  ) %>%
  mutate(
    is_assisted = ifelse((stringr::str_detect(sca1event, "Pass") | stringr::str_detect(sca2event, "Pass")) & penalty_kick == 0 & !stringr::str_detect(note, "Free kick"),1,0)
  )





