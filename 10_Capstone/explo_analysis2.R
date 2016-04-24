# *********************************************
#     Script 8
#     Author: Dheeraj Agarwal
#     Purpose: exploratory analysis 2
#     Dependency: Script 5
#*********************************************

source("01_libraries.R")

load("samples.RData")

blogs_word_freq <- dfm(blogs_sample, verbose = FALSE)
news_word_freq <- dfm(news_sample, verbose = FALSE)
twitter_word_freq <- dfm(tweets_sample, verbose = FALSE)

docfreq(blogs_word_freq)[1:11]
docfreq(news_word_freq)[1:11]
docfreq(twitter_word_freq)[1:11]

# The above shows the word 'the', 'that', 'we' etc figure frequently. However, since I have shown the first first 11 frequencies, they may not necessariliy be the max frequencies. 

# How about looking which 2 words come together most frequently. I will use blogs as a test.

bi.gram.blogs <- textcnt(blogs_sample, n = 2, method = "string") 
bi.gram.blogs <- bi.gram.blogs[order(bi.gram.blogs, decreasing = TRUE)]
bi.gram.blogs[1:2]

# once again we see that stop words are definitely going to impact prediction. However, one last test before making a decision to remove those.

rm(list = ls())

load("corpora.RData")

wordcloud(blogs_corpus, max.words = 100, random.order = FALSE)
wordcloud(news_corpus, max.words = 100, random.order = FALSE)
wordcloud(twitter_corpus, max.words = 100, random.order = FALSE)

rm(list = ls())