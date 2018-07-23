#library(XML)
#library(RCurl)
#library(rlist)
#theurl <- getURL("https://etherscan.io/txs",.opts = list(ssl.verifypeer = FALSE) )
#tables <- readHTMLTable(theurl)
#tables <- list.clean(tables, fun = is.null, recursive = FALSE)
#n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

#x<-tables[[which.max(n.rows)]]

#for(i in 1:87) {
 # url <- getURL("https://etherscan.io/txs?p=", i, .opts = list(ssl.verifypeer = FALSE))
#}

library(XML)
library(RCurl)
library(rlist)
library(plyr)
transactionslist<-list()
ttable<-list()
for(i in 1:5000)
{
  transactionslist[i] <- paste0("https://etherscan.io/txs?ps=100&p=", i)
 theurl<-getURL(transactionslist[i],.opts=list(ssl.verifypeer=FALSE))
  ttable[i]<- readHTMLTable(theurl)
}
Transactions<-do.call("rbind", ttable)
Transactions<-subset(Transactions,select=-5)

theurl2<-getURL("https://etherscan.io/blocks_forked?ps=100&p=k1",.opts=list(ssl.verifypeer=FALSE))
ftable<-readHTMLTable(theurl2)
df <- data.frame(ftable)

names(df) <- substring(names(df), 6)
df <- subset(df, select =-10)


write.csv(Transactions, file = "Transactions.csv")
write.csv(df, file = "ForkedBlocks.csv")

