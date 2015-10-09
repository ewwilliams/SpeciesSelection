library(FD)
candSppTraits <- read.csv("q_candSppTraitMasterEW.csv", header=T) 

# Imputing missing data using MICE (per http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3997312/)
library(mice)
candTraits <- candSppTraits[,3:14]
candTraits.imp <- mice(candTraits)
head(complete(candTraits.imp))
candSppTraitsEW.imp <- data.frame(candSppTraits[,1:2], complete(candTraits.imp))

# Using all data (whether resolved to spp or genus), no imputation
rownames(candSppTraits) <- candSppTraits[,1]
candSppTraits <- candSppTraits[,3:14]
candSppTraits.gow <- gowdis(candSppTraits)
candSppTraits.pcoa <- pcoa(candSppTraits.gow)
plot(candSppTraits.pcoa$vectors[,1:2])
write.csv(as.matrix(candSppTraits.gow),"candSpp_FunDistMatrixEW.csv")
save(list=c("candSppTraits","candSppTraits.gow","candSppTraits.pcoa"), 
     file="candSppTraitsEW.RData")

#so there are a bunch of files that were made ahead of time