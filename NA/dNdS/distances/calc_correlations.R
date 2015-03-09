rm(list = ls())

distances <- read.table('distances.dat', sep=',')
maxs <- c()
mins <- c()
means <- c()
sds <- c()

for(i in 1:25){
  rates <- read.table(paste('site_rates/rates_', i, '.dat', sep=''), sep=',', head=T)
  map <- read.table(paste('structure_maps/map_', i, '.txt', sep=''), head=F)
  rates <- rates[map$V1 != '-', ]
  correlations <- sapply(distances, function(x) cor(1/x[x!=0], rates$dN.dS[x!=0]))
  correlations <- data.frame(correlations = correlations)
  write.table(correlations, file=paste('correlations/n1_', i, '.correlations', sep=''), row.names=F, col.names=F)
  maxs <- append(maxs, max(correlations$correlations))
  mins <- append(mins, min(correlations$correlations))
  means <- append(means, mean(correlations$correlations))
  sds <- append(sds, sd(correlations$correlations))
  #print(max(correlations$correlations))
}

