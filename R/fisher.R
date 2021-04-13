### Soccer Goal Analysis
### Josh Katz & Sejin Kim
### STAT 306 S21 @ Kenyon College

library(tidyverse)

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
