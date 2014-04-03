library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

library(RCurl)


mach_tweets = searchTwitter("gay marriage", n=499, lang="en")

mach_text = sapply(mach_tweets, function(x) x$getText())

# create a corpus
mach_corpus = Corpus(VectorSource(mach_text))

# create document term matrix applying some transformations
tdm = TermDocumentMatrix(mach_corpus,
                         control = list(removePunctuation = TRUE,
                                        stopwords = c("machine", "learning", stopwords("english")),
                                        removeNumbers = TRUE, tolower = TRUE))
# define tdm as matrix
m = as.matrix(tdm)
# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE)
# create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

# plot wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

# save the image in png format

png("gayMarriage.png", width=12, height=8, units="in", res=720)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()
