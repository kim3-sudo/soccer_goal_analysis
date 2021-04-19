### Soccer Goal Analysis
### Josh Katz & Sejin Kim
### STAT 306 S21 @ Kenyon College

library(Barnard)
library(tidyverse)
library(mosaic)

# Read data
sca <- readRDS(url('https://github.com/kim3-sudo/soccer_goal_analysis/blob/main/data/sca.rds?raw=true'))
View(sca)

# Run a fisher test without PKs
sca_nopenalty <- filter(sca, ispenalty == 0)
fisher.test(table(sca_nopenalty$team, sca_nopenalty$event), simulate.p.value = TRUE, B = 100000)

# Compare just manutd and colcrew
sca_mancol <- filter(sca_nopenalty, team == 'manutd' | team == 'colcrew')
fisher.test(table(sca_mancol$team, sca_mancol$event), simulate.p.value = TRUE, B = 100000)

# Compare just kenyon and colcrew
sca_kencol <- filter(sca_nopenalty, team == 'kenyon' | team == 'colcrew')
fisher.test(table(sca_kencol$team, sca_kencol$event), simulate.p.value = TRUE, B = 100000)

# Compare just kenyon and manutd
sca_kenman <- filter(sca_nopenalty, team == 'kenyon' | team == 'manutd')
fisher.test(table(sca_kenman$team, sca_kenman$event), simulate.p.value = TRUE, B = 100000)

# Run a fisher test on PKs
fisher.test(table(sca$team, sca$ispenalty))

# Run a fisher test on assists
fisher.test(table(sca_nopenalty$team, sca_nopenalty$isassisted))

# Just for curiosity
# Compare just manutd and colcrew with PKs
scapen_mancol <- filter(sca, team == 'manutd' | team == 'colcrew')
fisher.test(table(scapen_mancol$team, scapen_mancol$event), simulate.p.value = TRUE, B = 100000)
# Compare just kenyon and colcrew
scapen_kencol <- filter(sca, team == 'kenyon' | team == 'colcrew')
fisher.test(table(scapen_kencol$team, scapen_kencol$event), simulate.p.value = TRUE, B = 100000)
# Compare just kenyon and manutd
scapen_kenman <- filter(sca, team == 'kenyon' | team == 'manutd')
fisher.test(table(scapen_kenman$team, scapen_kenman$event), simulate.p.value = TRUE, B = 100000)

# Try a Barnard test
sca_nopen_table <- sca_nopenalty %>% count(team, event)
print(sca_nopen_table)

barnard.test(182, 52, 28, 22, dp = 0.0001, pooled = TRUE) # Test manutd livepass, kenyon livepass, manutd noevent, kenyon noevent
barnard.test(12, 6, 28, 22, dp = 0.0001, pooled = TRUE) # Test manutd deadpass, kenyon deadpass, manutd noevent, kenyon noevent
barnard.test(21, 5, 28, 22, dp = 0.0001, pooled = TRUE) # Test manutd shot, kenyon shot, manutd noevent, kenyon noevent
barnard.test(23, 7, 28, 22, dp = 0.0001, pooled = TRUE) # Test manutd dribble, kenyon dribble, manutd noevent, kenyon noevent
barnard.test(182, 52, 23, 7, dp = 0.0001, pooled = TRUE) # Test manutd livepass, kenyon livepass, manutd dribble, kenyon dribble
barnard.test(12, 6, 23, 7, dp = 0.0001, pooled = TRUE) # Test manutd deadpass, kenyon deadpass, manutd dribble, kenyon dribble
barnard.test(21, 5, 23, 7, dp = 0.0001, pooled = TRUE) # Test manutd shot, kenyon shot, manutd dribble, kenyon dribble

barnard.test(78, 52, 13, 22, dp = 0.0001, pooled = TRUE) # Test colcrew livepass, kenyon livepass, colcrew noevent, kenyon noevent
barnard.test(8, 6, 13, 22, dp = 0.0001, pooled = TRUE) # Test colcrew deadpass, kenyon deadpass, colcrew noevent, kenyon noevent
barnard.test(11, 5, 13, 22, dp = 0.0001, pooled = TRUE) # Test colcrew shot, kenyon shot, colcrew noevent, kenyon noevent
barnard.test(3, 7, 13, 22, dp = 0.0001, pooled = TRUE) # Test colcrew dribble, kenyon dribble, colcrew noevent, kenyon noevent
barnard.test(78, 52, 3, 7, dp = 0.0001, pooled = TRUE) # Test colcrew livepass, kenyon livepass, colcrew dribble, kenyon dribble
barnard.test(8, 6, 3, 7, dp = 0.0001, pooled = TRUE) # Test colcrew deadpass, kenyon deadpass, colcrew dribble, kenyon dribble
barnard.test(11, 5, 3, 7, dp = 0.0001, pooled = TRUE) # Test colcrew shot, kenyon shot, colcrew dribble, kenyon dribble
