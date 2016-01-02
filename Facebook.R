#installing packeges
install.packages("Rfacebook")
install.packages("httpuv")
install.packages("RColorBrewer")
install.packages("rjson")
install.packages("httr")
install.packages("RCurl")
install.packages("igraph")

#Loading required packages
require(Rfacebook)
require(httpuv)
require(RColorBrewer)
require(rjson)
require(httr)
require(RCurl)
require(igraph)

#developers.facebook.com/tools-and-support   Graph API Explorer
my_access_token <- "CCEdEose0c//YOUR API\\3YHA24OoFBB6li9sL//YOUR API\\bnMg43g8nURC1iefmI82HqA//YOUR API\\0s9dtpTzzpPhs8Eiw0OVdtfp3nc3Dx2mAtPEAr//YOUR API\\2COlS7ZBPvteVqZAlGrsIazNF44TCiglyftftGvRD4bmOOfptfTQ84n7NUZD"

options(RCurlOptions=list(verbose = FALSE,capath=system.file("CurlSSL","cacers.pem",package = "RCurl"),ssl.verifypeer=FALSE))

#User
me <-getUsers("me",token=my_access_token)

#Users friends
friends <- getFriends(token = my_acces_tokan,simplify = F)
str(friends)
table(friends)

#Pie charts  brewer.pal(n=palette max 9,"Reds"))
pie(table(friends$name),col =brewer.pal(20,"Reds"))
pie(table(friends$relationship_status),col=brewer.pal(5,"Greens"))
pie(table(friends$location),col=brewer.pal(2,"Greens"))
pie(table(friends$locale),col=brewer.pal(4,"Blues"))
pie(table(friends$gender),col=brewer.pal(3,"Oranges"))

#Writes on facebook wall
text="Something for your facebook wall"
link =""
updateStatus(text,token = my_acces_tokan,link = link)

tmp <- getNetwork(my_access_token, format ='adj.matrix')
network <- graph.adjacency(tmp,mode="undirected")


set.seed(1)
layout <- layout.fruchterman.reingold(network)
layout[,1] = (L[,1] -min(L[,1])) / (max(L[,1]) - min(L[,1]))*2-1
layout[,2] = (L[,2] -min(L[,2])) / (max(L[,2]) - min(L[,2]))*2-1

#Creating PDF
pdf("file_name.pdf",width=50,height=50)

#Draw plot
plot(network,layout=layout,vertex.size=0,vertex.frame.color="#000000",
     edge.curved= FALSE,edge.color=rainbow(500),
     vertex.label.cex=3,edge.width=6)
      