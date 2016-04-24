#############################################
          #SCRIPT NUMBER: 01
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Create 2 & 3 N-Grams
          #DEPENDENCIES: Script 05
          #DATE: April 18, 2016
#############################################
load("train.RData")

train1 <- textcnt(train, method = "string", split = "[[:space:]]", n = 1L, decreasing = T)
train2 <- textcnt(train, method = "string", split = "[[:space:]]", n = 2L, decreasing = T)
train3 <- textcnt(train, method = "string", split = "[[:space:]]", n = 3L, decreasing = T)
rm(train)

save.image("alltrains.RData")