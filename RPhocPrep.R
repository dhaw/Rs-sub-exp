#Import csv's first (manually)
inc <- Xdaily_incidence_total
gen <- Xgeneration_total

library(reshape2)
library(ggplot2)
library(plyr)

#incDay <- reshape(inc, idvar=c("Network", "Run"), timevar="Day", direction="wide")
incDay <- dcast(inc, Network + Run ~ Day, value.var="Incidence")
#genSize <- reshape(gen[,c("Network", "Run", "Generation", "Size")], idvar=c("Network", "Run"), timevar="Generation", direction="wide")
genSize <- dcast(gen[,c("Network", "Run", "Generation", "Size")], Network + Run ~ Generation, value.var="Size")
#genRatio <- reshape(gen[,c("Network", "Run", "Generation", "Ratio")], idvar=c("Network", "Run"), timevar="Generation", direction="wide")
genRatio <- dcast(gen[,c("Network", "Run", "Generation", "Ratio")], Network + Run ~ Generation, value.var="Ratio")

write.csv(incDay,"XincDay.csv")
write.csv(genSize,"XgenSize.csv")
write.csv(genRatio,"XgenRatio.csv")