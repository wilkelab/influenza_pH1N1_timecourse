rm(list = ls())

library(ggplot2)
library(grid)
library(cowplot)

make.plot <- function(protein) {
  correlations <- data.frame(ID=numeric(), correlation=numeric())
  
  count <- 0
  for(file in list.files()) {
    count <- count + 1
    tmp.cor <- read.table(file, head=F)$V1
    correlations <- rbind(correlations, data.frame(ID=rep(count, length(tmp.cor)), correlation=tmp.cor))
  }
  
  p <- ggplot(correlations, aes(factor(ID), correlation)) + geom_violin(fill = 'gray') +
    xlab('Time (Months)') +
    ylab('Distribution of Correlations')
  
  ggsave(filename=paste('../correlations_violin_', protein, '.pdf', sep=''), height=5, width=15, useDingbats=F)
}

setwd('~/Google Drive/Data/influenza_pH1N1_timecourse/HA/dNdS/distances/correlations/')
make.plot('HA')

setwd('~/Google Drive/Data/influenza_pH1N1_timecourse/NA/dNdS/distances/correlations/')
make.plot('NA')