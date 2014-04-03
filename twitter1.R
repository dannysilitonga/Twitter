library("ROAuth")
library("twitteR")
library("wordcloud")
library("tm")

download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))


cred <- OAuthFactory$new(consumerKey='AiAR4fOkVq0ukcPjklLcQ',
                         consumerSecret='qHpgmNMrexUXisTrOmX8G8SVBknPPalte1kfuGdcB8',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

#necessary step for Windows
cred$handshake(cainfo="cacert.pem")
#save for later use for Windows
save(cred, file="twitter authentication.Rdata")
registerTwitterOAuth(cred)