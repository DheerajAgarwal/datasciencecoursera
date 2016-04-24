#############################################
          #SCRIPT NUMBER: 08
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Shiny functions to be used for application
          #DEPENDENCIES: Script 07
          #DATE: April 18, 2016
#############################################

suppressMessages(source("01_libraries.R"))

st_an <- Maxent_Sent_Token_Annotator()
wt_an <- Maxent_Word_Token_Annotator()
pt_an <- Maxent_POS_Tag_Annotator()

load("freq.tbl.uni.RData")
load("freq.tbl.bi.RData")
load("freq.tbl.tri.RData")
load("profanity_list.RData")

source("03_cleaner.R")

#Text Parser
parse_text <- function(text) {
  tmp <- unlist(str_split(text, " "))
  tmp <- tmp[tmp != ""]
  return(tmp)
}

#Check if a word in the profanity words list. If it is, just replace by ***

profanity_filter <- function(text) {
  tmp <- text
  if (length(tmp) > 0) {
    words <- parse_text(tmp)
    word.count <- length(words)
    if (word.count > 0) {
      for (i in 1:word.count) {
        if (words[i] %in% profanity_list) words[i] <- paste(substring(words[i], 1, 1), "***", sep = "")
      }
      tmp_w <- paste(words[1]) 
      if (word.count > 1) {
        for (i in 2:word.count) tmp_w <- paste(tmp_w, words[i])
      }
      return(tmp_w)
    }
  }
  return(tmp)
}

get_default <- function(text) {
  if (length(text) > 0) {
    a2 <- annotate(as.String(text), list(st_an, wt_an))
    a3 <- annotate(as.String(text), pt_an, a2)
    a3w <- subset(a3, type == "word")
    tags <- sapply(a3w$features, `[[`, "POS")
    if (tags %like% "NN") {
      return("in")
    } else if (tags %like% "VB") {
      return("a")
    } else if (tags %like% "JJ") {
      return("time")
    } else if (tags %like% "PRP") {
      return("first")
    } else if (tags %like% "CC") {
      return("i")
    } else if (text == "the") {
      return("first")
    }
  }
  return("the")
}

get_word <- function(text) {
  if (text != " ") { 
    words <- parse_text(tolower(text))
    word.count <- length(words)
    if (word.count > 0) {
      filter <- paste("^", words[word.count], sep = "")
      tmp_dt <- freq.tbl.uni[word0 %like% filter]
      pred_word <- dim(tmp_dt)[1]
      if (pred_word > 0) {
        tmp_dt <- tmp_dt[order(rank(-appear.percent))]
        pred <- tmp_dt[1]$word0
        if (word.count > 2) {
          tmp_w <- paste(words[1])
          for (i in 2:(word.count - 1)) tmp_w <- paste(tmp_w, words[i])
          return(paste(tmp_w, profanity_filter(pred)))
        } else if (word.count > 1) {
          tmp_w <- paste(words[1])
          return(paste(tmp_w, profanity_filter(pred)))
        }
      }
    }
  }
  return(text)
}

get_pred <- function(text) {
  if (text != " ") { 
    input_words <- parse_text(CleanR(text))
    len <- length(input_words)
    
    if (len > 1) {
      w1 <- input_words[len]
      w2 <- input_words[len - 1]
    } else if (len > 0) {
      w1 <- input_words[len]
      w2 <- "NA"
    } else return("the")
    
    l1 <- .95
    l2 <- .04
    l3 <- .01
    
    len3 <- length(freq.tbl.tri[freq.tbl.tri[word2 == w2 & word1 == w1]]$appear.percent)
    len2 <- length(freq.tbl.bi[freq.tbl.bi[word1 == w1]]$appear.percent)
    matches <- matrix(nrow = len3 + len2, ncol = 2)
    matches[,1] <- ""
    matches[,2] <- 0
    
    if (len3 > 0) {
      for (i in 1:len3) {
        matches[i, 1] <- freq.tbl.tri[freq.tbl.tri[word2 == w2 & word1 == w1]]$word0[i]
        cnt2 <- length(freq.tbl.bi[freq.tbl.bi[word1 == w1 & word0 == matches[i, 1]]]$appear.percent)
        cnt1 <- length(freq.tbl.uni[freq.tbl.uni[word0 == matches[i, 1]]]$appear.percent)
        if (cnt2 > 0) freq2 <- freq.tbl.bi[freq.tbl.bi[word1 == w1 & word0 == matches[i, 1]]]$appear.percent 
        else freq2 <- 0
        if (cnt1 > 0) freq1 <- freq.tbl.uni[freq.tbl.uni[word0 == matches[i, 1]]]$appear.percent
        else freq1 <- 0
        matches[i, 2] <- freq.tbl.tri[freq.tbl.tri[word2 == w2 & word1 == w1]]$appear.percent[i] * 
          l1 + freq2 * l2 + freq1 * l3     
      }
    }
    if (len2 > 0) {
      for (i in sum(len3, 1):sum(len3, len2)) {
        matches[i, 1] <- freq.tbl.bi[freq.tbl.bi[word1 == w1]]$word0[i - len3]
        cnt1 <- length(freq.tbl.uni[freq.tbl.uni[word0 == matches[i, 1]]]$appear.percent)
        if (cnt1 > 0) freq1 <- freq.tbl.uni[freq.tbl.uni[word0 == matches[i, 1]]]$appear.percent else freq1 <- 0
        matches[i, 2] <- freq.tbl.bi[freq.tbl.bi[word1 == w1]]$appear.percent[i - len3] * l2 + freq1 * l3   
      }
    }
    match_len <- length(matches[which.max(matches[,2])])
    if (match_len > 0) return(matches[which.max(matches[,2])])
    return(get_default(w1))
  }
  return(" ")
}