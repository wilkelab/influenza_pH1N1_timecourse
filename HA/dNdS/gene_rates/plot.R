rm(list = ls())

library(ggplot2)
library(grid)
library(cowplot)
library(zoo)
library(scales)

setwd('~/Google Drive/Documents/PostDoc/DataLimitations/influenza_pH1N1_timecourse/HA/dNdS/gene_rates/')
d1 <- read.table('gene_rates.dat', sep='=', head=F)[,2]
setwd('~/Google Drive/Documents/PostDoc/DataLimitations/influenza_pH1N1_timecourse/NA/dNdS/gene_rates/')
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

p <- ggplot(data=d, aes(x=as.numeric(Date), y=w, colour=Protein)) + geom_point() + 
  xlab("Time") +
  ylab("Clock Rate") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.6)) +
  scale_x_continuous(breaks = as.numeric(as.Date(c('04/01/2009',
                                                   '05/01/2009', 
                                                   '06/01/2009', 
                                                   '07/01/2009',
                                                   '08/01/2009',
                                                   '09/01/2009',
                                                   '10/01/2009',
                                                   '11/01/2009',
                                                   '12/01/2009',
                                                   '01/01/2009',
                                                   '02/01/2010',
                                                   '03/01/2010',
                                                   '04/01/2010',
                                                   '05/01/2010',
                                                   '06/01/2010',
                                                   '07/01/2010',
                                                   '08/01/2010',
                                                   '09/01/2010',
                                                   '10/01/2010',
                                                   '11/01/2010',
                                                   '12/01/2010',
                                                   '01/01/2010',
                                                   '02/01/2011',
                                                   '03/01/2011',
                                                   '04/01/2011',
                                                   '05/01/2011'), format='%m/%d/%Y')), 
                     labels = c('04/2009',
                                '', 
                                '', 
                                '',
                                '',
                                '09/2009',
                                '',
                                '',
                                '',
                                '',
                                '02/2010',
                                '',
                                '',
                                '',
                                '',
                                '07/2010',
                                '',
                                '',
                                '',
                                '',
                                '12/2010',
                                '',
                                '',
                                '',
                                '',
                                '05/2011')) +
  scale_y_continuous(breaks = seq(0, .5, 0.05), limits = c(0.12, .32))

ggsave("dNdSvTime.pdf", p, width=6, h=5.5, useDingbats = F)