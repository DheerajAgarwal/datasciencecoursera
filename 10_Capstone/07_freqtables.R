#############################################
          #SCRIPT NUMBER: 07
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Create Frequency Tables and Occurance probability
          #DEPENDENCIES: Script 6
          #DATE: April 18, 2016
#############################################


load("alltrains.RData")
source("01_libraries.R")

freq.tbl.uni <- data.table(text = names(train1), as.matrix(train1))
setnames(freq.tbl.uni, "V1", "count")
setnames(freq.tbl.uni, "text", "word0")
tot <- sum(freq.tbl.uni$count)
freq.tbl.uni <- mutate(freq.tbl.uni, appear.percent = round(count/tot, 7))
freq.tbl.uni$count <- NULL
setkeyv(freq.tbl.uni, c("word0", "appear.percent"))
save(freq.tbl.uni, file = "freq.tbl.uni.RData")
rm(tot, freq.tbl.uni)

freq.tbl.bi <- data.table(text = names(train2), as.matrix(train2))
setnames(freq.tbl.bi, "V1", "count")
freq.tbl.bi <- freq.tbl.bi
freq.tbl.bi[, c("word1", "word0")  := do.call(Map, c(f = c, strsplit(text, " ")))]
freq.tbl.bi <- mutate(freq.tbl.bi, appear.percent = round(count/train1[word1][[1]], 7))
freq.tbl.bi$text <- NULL
freq.tbl.bi$count <- NULL
setkey(freq.tbl.bi, word1)
freq.tbl.bi <- freq.tbl.bi[,lapply(.SD, function(x) head(x, 5)), by = key(freq.tbl.bi)]
setkeyv(freq.tbl.bi, c("word1", "appear.percent", "word0"))
save(freq.tbl.bi, file = "freq.tbl.bi.RData")
rm(freq.tbl.bi, train1)

freq.tbl.tri <- data.table(text = names(train3), as.matrix(train3))
setnames(freq.tbl.tri, "V1", "count")
freq.tbl.tri <- subset(freq.tbl.tri, count > 1)
freq.tbl.tri[, c("word2", "word1", "word0")  := do.call(Map, c(f = c, strsplit(text, " ")))]
freq.tbl.tri <- mutate(freq.tbl.tri, appear.percent = round(count/train2[paste(word2, word1)][[1]], 7))
freq.tbl.tri$text <- NULL
freq.tbl.tri$count <- NULL
setkeyv(freq.tbl.tri, c("word2", "word1"))
freq.tbl.tri <- freq.tbl.tri[,lapply(.SD, function(x) head(x, 5)),by = key(freq.tbl.tri)]
setkeyv(freq.tbl.tri, c("word2", "word1", "appear.percent", "word0"))
save(freq.tbl.tri, file = "freq.tbl.tri.RData")
rm(list = ls())