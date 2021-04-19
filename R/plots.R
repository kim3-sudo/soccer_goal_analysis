### Soccer Goal Analysis
### Josh Katz & Sejin Kim
### STAT 306 S21 @ Kenyon College

library(waffle)

# Read data
sca <- readRDS(url('https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/data/sca.rds?raw=true'))
View(sca)


kenyon <- filter(sca, ispenalty == 0 & team == 'kenyon')
colcrew <- filter(sca, ispenalty == 0 & team == 'colcrew')
manutd <- filter(sca, ispenalty == 0 & team == 'manutd')
xda <- tally(~ kenyon$event)
xdb <- tally(~ colcrew$event)
xdc <- tally(~ manutd$event)

iron(
  waffle(xda, rows = 8, keep = TRUE, title = "Kenyon Goal Events"),
  waffle(xdb, rows = 8, keep = TRUE, title = "Columbus Crew Goal Events"),
  waffle(xdc, rows = 8, keep = TRUE, title = "Manchester United Goal Events", xlab = "1 sq == 1 goal")
)

