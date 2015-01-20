library(ggplot2)
library(grid)
library(cowplot)
library(zoo)
library(scales)

setwd('~/Google Drive/Data/influenza_pH1N1_timecourse/HA/dNdS/gene_rates/')
d1 <- read.table('gene_rates.dat', sep='=', head=F)[,2]
setwd('~/Google Drive/Data/influenza_pH1N1_timecourse/NA/dNdS/gene_rates/')
d2 <- read.table('gene_rates.dat', sep='=', head=F)[,2]

d <- data.frame(Date=as.Date(c('04/30/2009', 
                        '05/31/2009', 
                        '06/30/2009',
                        '07/31/2009',
                        '08/31/2009',
                        '09/30/2009',
                        '10/31/2009',
                        '11/30/2009',
                        '12/31/2009',
                        '01/31/2010',
                        '02/28/2010', 
                        '03/31/2010', 
                        '04/30/2010', 
                        '05/31/2010', 
                        '06/30/2010', 
                        '07/31/2010', 
                        '08/31/2010', 
                        '09/30/2010', 
                        '10/31/2010', 
                        '11/30/2010', 
                        '12/31/2010',
                        '01/31/2011',
                        '02/28/2011',
                        '03/31/2011',
                        '04/30/2011'),
                        format='%m/%d/%Y'),
                w=c(d1, d2),
                Protein=c(rep('HA', length(d1)), rep('NA', length(d2)))
                )

p <- ggplot(data=d, aes(x=Date, y=w, color=Protein)) + geom_point() +
  xlab("Time") +
  ylab("dN/dS") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.6)) +
  scale_x_date(breaks = date_breaks("2 months"), labels = date_format('%m/%Y')) +
  theme(legend.position = c(0.9,0.9))

ggsave("dNdSvTime.pdf", p, width=5, h=4.5, useDingbats = F)