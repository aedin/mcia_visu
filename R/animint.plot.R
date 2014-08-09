library(animint)
x <- readRDS("Dat/mcoin.RDS")

axes=1:2



comb <- x$mcoa$Tco[, axes]
comb$feature <- sapply(strsplit(rownames(comb), split="\\."), "[", 1)
comb$col <- x$mcoa$TC$T

sep <- split(comb, x$mcoa$TC$T)

cb <- ggplot() +
  geom_point(data=comb, aes(x=SV1, y=SV2, colour=col, clickSelects=feature))



gp <- lapply(sep, function(x) {
  r <- ggplot() +
    geom_point(data=x, aes(x=SV1, y=SV2, colour=I(col), alpha=0.3)) +
    geom_point(data=x, aes(x=SV1, y=SV2, colour=I(col), clickSelects=feature, showSelected=feature))
  return(r)
})

lg <- list()
lg[2:5] <- gp
lg[[1]] <- cb
names(lg) <- paste("data", 1:5, sep="")
animint2dir(lg, out.dir="geoms")

