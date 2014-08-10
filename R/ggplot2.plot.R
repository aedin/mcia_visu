# setwd("multiOmicMethod_Visualizaition/")
setwd("~/mnt/msdata5/Projects/multiOmicMethod_Visualizaition/")
library(omicade4)
library(ggplot2)
data(NCI60_4arrays)

x <- readRDS("Dat/mcoin.RDS")

axes=1:2
col=sapply(strsplit(colnames(NCI60_4arrays$agilent), split="\\."), "[", 1)
nD <- length(x$coa)
nObs <- nrow(x$mcoa$SynVar)
pch <- rep(names(x$coa), rep(nObs, nD))

# for the sample space
obsSyn <- x$mcoa$SynVar[, axes]
obsSep <- x$mcoa$Tl1[, axes]
names <- rownames(obsSep)
rownames(obsSep) <- NULL
rownames(obsSyn) <- NULL
obsSep$col <- rep(col, nD)
obsSep$pch <- pch

r <- cbind(obsSyn, obsSep)
r$samples <- names
r$col <- rep(col, nD)

colnames(r)

ggplot(data=r, aes(x=SynVar1, y=SynVar2)) + 
  geom_hline(aes(yintercept=0)) + 
  geom_vline(aes(xintercept=0)) + 
  geom_segment(aes(xend=Axis1, yend=Axis2, color=col)) +
  geom_point(data=obsSep, aes(x=Axis1, y=Axis2, color=col, pch=as.factor(pch))) +
  scale_shape_manual(values=c(15, 20, 16, 1))
  


# plot gene space

feat <- x$mcoa$Tco[, axes]
feat$data <- x$mcoa$TC$T
feat$pch <- rep(names(x$coa), table(feat$data))
ggplot(feat, aes(x=SV1, y=SV2, colour=data, pch=pch)) +
  geom_point()

  
# barplot for eigen values

d <- dim(x$mcoa$cov2)
nam <- names(x$coa)
seq <- formatC(c(1:length(x$mcoa$pseudoeig), rep(1:d[2], rep(d[1], d[2]))), width=2, flag="0")
df <- data.frame(val = c(x$mcoa$pseudoeig, x$mcoa$cov2),
                 eig = paste("eig", seq, sep=""),
                 col = c(rep("total", length(x$mcoa$pseudoeig)), rep(nam, d[2])))
df$val[1:d[2]] <- 0
ggplot(data=df, aes(x=eig, y=val, fill=col)) + geom_bar(stat="identity")







