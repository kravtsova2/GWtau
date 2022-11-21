library(pracma)
library(ggplot2)
library(plot3D)
library(factoextra)
library(ggpubr)
library(cluster)
library(MASS)
library(magrittr)
library(dplyr)
library(tidyverse)
library(ggforce)
library(dendextend)
library(rgl)
library(plot3D)


data=read.table("LVGW.dat",header=FALSE)
dmat=as.matrix(data)

Y=read.table("LVYY.dat",header=FALSE)


C1=read.table("Lotka1.dat",header=FALSE)
C2=read.table("Lotka2.dat",header=FALSE)
C3=read.table("Lotka3.dat",header=FALSE)





# fit <- cmdscale(dmat, k=2) ### metric MDS
# x <- fit[,1]
# y <- fit[,2]
fit <- isoMDS(dmat, k=2) ### non-metric MDS
x <- fit$points[,1]
y <- fit$points[,2]

group=Y$V1

xy=cbind(x,y,group)
xy=as.data.frame(xy)
xy$group=as.factor(xy$group)

Xc=cbind(x,y)
Xc=as.data.frame(Xc)

# ### k-means
my_clust=kmeans(Xc,3)
m_clust=as.factor(my_clust$cluster)
xy$cluster=m_clust



######################### perform k-medoid clustering with k=3 clusters
# kmed <- pam(dmat, k = 3,diss=TRUE)
# m_clust=as.factor(kmed$cluster)
# xy$cluster=m_clust
#################### plot embeddings

### plot (GW case)
ggplot(xy, aes(x, y)) +
  geom_mark_ellipse(aes(color=m_clust)) +
  scale_fill_manual(values=c("white","white","white")) +
  geom_point(aes(color=group),size=5) + scale_color_manual(values=c("blue","magenta","green")) + 
  xlab("")+ylab("")+ theme(legend.position="none") + 
  xlim(-85,75) + ylim(-17,6)+
  theme(axis.text.x = element_text(size=14),axis.text.y = element_text(size=14)) 



# ### plot without clusters (for DTW and Eucl. cases)
ggplot(xy, aes(x, y, color=group)) + geom_point(size=6) + 
  scale_color_manual(values=c("blue","magenta","green"))+ 
  xlab("")+ylab("") + theme(legend.position="none")+
  theme(axis.text.x = element_text(size=28),axis.text.y = element_text(size=28))


############################################### plot cluster tree
colnames(data) <- c(rep('uf',20),rep('sf',20),rep('un',20))
dmat=as.matrix(data)
d=as.dist(dmat)
hc1 <- hclust(d, method="single")
dend=as.dendrogram(hc1)

labels(dend)=rep(" ",60)

dend %>% set("leaves_pch", 19) %>%  set("leaves_cex", 1.5) %>% set("leaves_col", c(rep('blue',20),rep('magenta',20),rep('green',20))) %>% plot


############### plot 3d trajectories
plot3d(C1$V1, C1$V2, C1$V3,"","","",type="l",col="blue",lwd=4)
plot3d(C2$V1, C2$V2, C2$V3,"","","",type="l",col="magenta",lwd=4)
plot3d(C3$V1, C3$V2, C3$V3,"","","",type="l",col="green",lwd=7)

