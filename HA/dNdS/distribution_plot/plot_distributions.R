rm(list = ls())

library(ggplot2)
library(cowplot)

plot.density <- function(data, title) {
  p <- ggplot(data, aes(x = x)) + geom_density()
  p <- p + scale_x_continuous(limit = c(0, 4))
  p <- p + ylab("Density")
  p <- p + xlab('dN/dS')
  p <- p + ggtitle(title)
  
  ggsave(p, filename = paste('dNdS_distribution_', data$id[1], '.pdf', sep=''), height = 4.5, width=5)
  return(p)
}

h3.dat <- read.table('~/Google Drive/Data/influenza_HA_evolution/data_table/numbering_table_unix.csv', head=T, sep=',')

rates <- c()
id <- c()
for(i in 1:25){
  rates.temp <- read.table(paste('site_rates/rates_', i, '.dat', sep=''), sep=',', head=T)
  map <- read.table(paste('structure_maps/map_', i, '.txt', sep=''), head=F)
  rates <- append(rates, rates.temp$dN.dS[map$V1 != '-'])
  id <- append(id, rep(i, length(rates.temp$dN.dS[map$V1 != '-'])))
}

df <- data.frame(x = rates, id = id)

p1 <- plot.density(df[df$id == 1, ], paste('Month 1'))
p2 <- plot.density(df[df$id == 2, ], paste('Month 2'))
p3 <- plot.density(df[df$id == 3, ], paste('Month 3'))
p4 <- plot.density(df[df$id == 4, ], paste('Month 4'))
p5 <- plot.density(df[df$id == 5, ], paste('Month 5'))
p6 <- plot.density(df[df$id == 6, ], paste('Month 6'))
p7 <- plot.density(df[df$id == 7, ], paste('Month 7'))
p8 <- plot.density(df[df$id == 8, ], paste('Month 8'))
p9 <- plot.density(df[df$id == 9, ], paste('Month 9'))
p10 <- plot.density(df[df$id == 10, ], paste('Month 10'))
p11 <- plot.density(df[df$id == 11, ], paste('Month 11'))
p12 <- plot.density(df[df$id == 12, ], paste('Month 12'))
p13 <- plot.density(df[df$id == 13, ], paste('Month 13'))
p14 <- plot.density(df[df$id == 14, ], paste('Month 14'))
p15 <- plot.density(df[df$id == 15, ], paste('Month 15'))
p16 <- plot.density(df[df$id == 16, ], paste('Month 16'))
p17 <- plot.density(df[df$id == 17, ], paste('Month 17'))
p18 <- plot.density(df[df$id == 18, ], paste('Month 18'))
p19 <- plot.density(df[df$id == 19, ], paste('Month 19'))
p20 <- plot.density(df[df$id == 20, ], paste('Month 20'))
p21 <- plot.density(df[df$id == 21, ], paste('Month 21'))
p22 <- plot.density(df[df$id == 22, ], paste('Month 22'))
p23 <- plot.density(df[df$id == 23, ], paste('Month 23'))
p24 <- plot.density(df[df$id == 24, ], paste('Month 24'))
p25 <- plot.density(df[df$id == 25, ], paste('Month 25'))

p <- ggdraw() + 
  draw_plot(p1, 0.0, 0.8, 0.21, 0.2) +
  draw_plot(p2, 0.2, 0.8, 0.21, 0.2) +
  draw_plot(p3, 0.4, 0.8, 0.21, 0.2) +
  draw_plot(p4, 0.6, 0.8, 0.21, 0.2) +
  draw_plot(p5, 0.8, 0.8, 0.21, 0.2) +
  draw_plot(p6, 0.0, 0.6, 0.21, 0.2) +
  draw_plot(p7, 0.2, 0.6, 0.21, 0.2) +
  draw_plot(p8, 0.4, 0.6, 0.21, 0.2) +
  draw_plot(p9, 0.6, 0.6, 0.21, 0.2) +
  draw_plot(p10, 0.8, 0.6, 0.21, 0.2) +
  draw_plot(p11, 0.0, 0.4, 0.21, 0.2) +
  draw_plot(p12, 0.2, 0.4, 0.21, 0.2) +
  draw_plot(p13, 0.4, 0.4, 0.21, 0.2) +
  draw_plot(p14, 0.6, 0.4, 0.21, 0.2) +
  draw_plot(p15, 0.8, 0.4, 0.21, 0.2) +
  draw_plot(p16, 0.0, 0.2, 0.21, 0.2) +
  draw_plot(p17, 0.2, 0.2, 0.21, 0.2) +
  draw_plot(p18, 0.4, 0.2, 0.21, 0.2) +
  draw_plot(p19, 0.6, 0.2, 0.21, 0.2) +
  draw_plot(p20, 0.8, 0.2, 0.21, 0.2) +
  draw_plot(p21, 0.0, 0.0, 0.21, 0.2) +
  draw_plot(p22, 0.2, 0.0, 0.21, 0.2) +
  draw_plot(p23, 0.4, 0.0, 0.21, 0.2) +
  draw_plot(p24, 0.6, 0.0, 0.21, 0.2) +
  draw_plot(p25, 0.8, 0.0, 0.21, 0.2) 

p.manuscript <- ggdraw() + 
  draw_plot(p1, 0.0, 0, 1/3, 1) +
  draw_plot(p6, 1/3, 0, 1/3, 1) +
  draw_plot(p25, 2/3, 0, 1/3, 1) 

ggsave(p, filename = 'dNdS_distribution.pdf', height = 15, width=15)
ggsave(p.manuscript, filename = 'dNdS_distribution_manuscript.pdf', height = 5, width=15)

h3.p <- plot.density(data.frame(x = h3.dat$FEL.dN.dS, id = rep('H3', length(h3.dat$FEL.dN.dS))), "Hemagglutinin 3")