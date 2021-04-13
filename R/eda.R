### Soccer Goal Analysis
### Josh Katz & Sejin Kim
### STAT 306 S21 @ Kenyon College

library(mosaic)

# Read data
sca <- readRDS(url('https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/data/sca.rds?raw=true'))
View(sca)

tally(event~team, data = sca)
