rm(list = ls())

distances <- read.table('distances.dat', sep=',')
maxs <- c()
mins <- c()
means <- c()
sds <- c()


rates <- read.table('sites/sites.dat', sep=',', head=T)
map <- read.table('structural_map.txt', head=F)
rates <- rates[map$V1 != '-', ]
correlations <- as.vector(sapply(distances, function(x) cor(1/x[x!=0], rates$dN.dS[x!=0])))
p.values <- as.vector(sapply(distances, function(x) cor.test(1/x[x!=0], rates$dN.dS[x!=0])$p.value))
write.table(data.frame(correlations), file= 'pH1N1.correlations', row.names=F, col.names=F)
print(min(correlations))
print(max(correlations))

