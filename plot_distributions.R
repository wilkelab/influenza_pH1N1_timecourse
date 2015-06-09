rm(list = ls())

library(ggplot2)
library(cowplot)
library(dplyr)
library(MASS)

get.bins <- function(vec) {
  bins <- rep(0, length(vec))
  site <- 1
  for(i in vec) {
    threshold = -0.02
    counter <- 1
    while(i > threshold) {
      threshold <- threshold + 0.04
      if(i < threshold) {
        bins[site] <- counter
      }
      counter <- counter + 1
    }
    site <- site + 1
  }
  return(bins)
}

plot.density <- function(data, title, column, protein) {
  if(column > 0) {
    data <- data[data$id == column, ]
  }
  
  means <- summarise(group_by(data, bins), count=length(counts), mean=mean(counts))
  
  p <- ggplot(means, aes(x = ((bins-1)*0.04), y=count)) + geom_bar(stat = "identity", width=0.04)
  p <- p + scale_x_continuous(limit = c(-0.02, 4))
  p <- p + scale_y_continuous(limit = c(0, 410))
  #p <- p + scale_fill_gradient(low='blue', high='red', name=c('Average\nUnique\nCodons'))
  p <- p + ylab("Count")
  p <- p + xlab('dN/dS')
  p <- p + ggtitle(title)
  
  ggsave(p, filename = paste('distribution_plots/', protein,'_dNdS_distribution_', data$id[1], '.pdf', sep=''), height = 4, width=5.5)
  return(p)
}

plot.density.h3 <- function(data, title, column, protein) {
  if(column > 0) {
    data <- data[data$id == column, ]
  }
  
  p <- ggplot(data, aes(x = x)) + geom_histogram(binwidth=0.04, origin = -0.02)
  p <- p + scale_x_continuous(limit = c(-0.02, 4))
  p <- p + scale_y_continuous(limit = c(0, 410))
  p <- p + ylab("Count")
  p <- p + xlab('dN/dS')
  p <- p + ggtitle(title)
  
  ggsave(p, filename = paste('distribution_plots/', protein,'_dNdS_distribution_', data$id[1], '.pdf', sep=''), height = 4, width=5.5)
  return(p)
}

h3.dat <- read.table('~/Google Drive/Documents/PostDoc/GeometricConstraints/influenza_HA_evolution/data_table/numbering_table_unix.csv', head=T, sep=',')

get.df <- function(location) {
  rates <- c()
  counts <- c()
  bins <- c()
  id <- c()
  for(i in 1:25){
    rates.temp <- read.table(paste(location, '/dNdS/distribution_plot/site_rates/rates_', i, '.dat', sep=''), sep=',', head=T)
    map <- read.table(paste(location, '/dNdS/distribution_plot/structure_maps/map_', i, '.txt', sep=''), head=F)
    counts.temp <- read.table(paste(location, '/dNdS/codon_distribution_plot/codon_counts/', i, '.dat', sep=''), head=T)
    rates <- append(rates, rates.temp$dN.dS[map$V1 != '-'])
    counts <- append(counts, counts.temp$num_codon[map$V1 != '-'])
    bins <- append(bins, get.bins(rates.temp$dN.dS[map$V1 != '-']))
    id <- append(id, rep(i, length(rates.temp$dN.dS[map$V1 != '-'])))
  }
  
  data.frame(x = rates, id = id, counts = counts, bins=bins)
}

# ha.df <- get.df('HA')
# na.df <- get.df('NA')
# 
# ha.p1 <- plot.density(ha.df, paste('Month 1'), 1, 'ha')
# ha.p2 <- plot.density(ha.df, paste('Month 2'), 2, 'ha')
# ha.p3 <- plot.density(ha.df, paste('Month 3'), 3, 'ha')
# ha.p4 <- plot.density(ha.df, paste('Month 4'), 4, 'ha')
# ha.p5 <- plot.density(ha.df, paste('Month 5'), 5, 'ha')
# ha.p6 <- plot.density(ha.df, paste('Month 6'), 6, 'ha')
# ha.p7 <- plot.density(ha.df, paste('Month 7'), 7, 'ha')
# ha.p8 <- plot.density(ha.df, paste('Month 8'), 8, 'ha')
# ha.p9 <- plot.density(ha.df, paste('Month 9'), 9, 'ha')
# ha.p10 <- plot.density(ha.df, paste('Month 10'), 10, 'ha')
# ha.p11 <- plot.density(ha.df, paste('Month 11'), 11, 'ha')
# ha.p12 <- plot.density(ha.df, paste('Month 12'), 12, 'ha')
# ha.p13 <- plot.density(ha.df, paste('Month 13'), 13, 'ha')
# ha.p14 <- plot.density(ha.df, paste('Month 14'), 14, 'ha')
# ha.p15 <- plot.density(ha.df, paste('Month 15'), 15, 'ha')
# ha.p16 <- plot.density(ha.df, paste('Month 16'), 16, 'ha')
# ha.p17 <- plot.density(ha.df, paste('Month 17'), 17, 'ha')
# ha.p18 <- plot.density(ha.df, paste('Month 18'), 18, 'ha')
# ha.p19 <- plot.density(ha.df, paste('Month 19'), 19, 'ha')
# ha.p20 <- plot.density(ha.df, paste('Month 20'), 20, 'ha')
# ha.p21 <- plot.density(ha.df, paste('Month 21'), 21, 'ha')
# ha.p22 <- plot.density(ha.df, paste('Month 22'), 22, 'ha')
# ha.p23 <- plot.density(ha.df, paste('Month 23'), 23, 'ha')
# ha.p24 <- plot.density(ha.df, paste('Month 24'), 24, 'ha')
# ha.p25 <- plot.density(ha.df, paste('Month 25'), 25, 'ha')
# 
# p.ha <- ggdraw() + 
#   draw_plot(ha.p1, 0.0, 0.8, 0.21, 0.2) +
#   draw_plot(ha.p2, 0.2, 0.8, 0.21, 0.2) +
#   draw_plot(ha.p3, 0.4, 0.8, 0.21, 0.2) +
#   draw_plot(ha.p4, 0.6, 0.8, 0.21, 0.2) +
#   draw_plot(ha.p5, 0.8, 0.8, 0.21, 0.2) +
#   draw_plot(ha.p6, 0.0, 0.6, 0.21, 0.2) +
#   draw_plot(ha.p7, 0.2, 0.6, 0.21, 0.2) +
#   draw_plot(ha.p8, 0.4, 0.6, 0.21, 0.2) +
#   draw_plot(ha.p9, 0.6, 0.6, 0.21, 0.2) +
#   draw_plot(ha.p10, 0.8, 0.6, 0.21, 0.2) +
#   draw_plot(ha.p11, 0.0, 0.4, 0.21, 0.2) +
#   draw_plot(ha.p12, 0.2, 0.4, 0.21, 0.2) +
#   draw_plot(ha.p13, 0.4, 0.4, 0.21, 0.2) +
#   draw_plot(ha.p14, 0.6, 0.4, 0.21, 0.2) +
#   draw_plot(ha.p15, 0.8, 0.4, 0.21, 0.2) +
#   draw_plot(ha.p16, 0.0, 0.2, 0.21, 0.2) +
#   draw_plot(ha.p17, 0.2, 0.2, 0.21, 0.2) +
#   draw_plot(ha.p18, 0.4, 0.2, 0.21, 0.2) +
#   draw_plot(ha.p19, 0.6, 0.2, 0.21, 0.2) +
#   draw_plot(ha.p20, 0.8, 0.2, 0.21, 0.2) +
#   draw_plot(ha.p21, 0.0, 0.0, 0.21, 0.2) +
#   draw_plot(ha.p22, 0.2, 0.0, 0.21, 0.2) +
#   draw_plot(ha.p23, 0.4, 0.0, 0.21, 0.2) +
#   draw_plot(ha.p24, 0.6, 0.0, 0.21, 0.2) +
#   draw_plot(ha.p25, 0.8, 0.0, 0.21, 0.2) 
# 
# na.p1 <- plot.density(na.df, paste('Month 1'), 1, 'na')
# na.p2 <- plot.density(na.df, paste('Month 2'), 2, 'na')
# na.p3 <- plot.density(na.df, paste('Month 3'), 3, 'na')
# na.p4 <- plot.density(na.df, paste('Month 4'), 4, 'na')
# na.p5 <- plot.density(na.df, paste('Month 5'), 5, 'na')
# na.p6 <- plot.density(na.df, paste('Month 6'), 6, 'na')
# na.p7 <- plot.density(na.df, paste('Month 7'), 7, 'na')
# na.p8 <- plot.density(na.df, paste('Month 8'), 8, 'na')
# na.p9 <- plot.density(na.df, paste('Month 9'), 9, 'na')
# na.p10 <- plot.density(na.df, paste('Month 10'), 10, 'na')
# na.p11 <- plot.density(na.df, paste('Month 11'), 11, 'na')
# na.p12 <- plot.density(na.df, paste('Month 12'), 12, 'na')
# na.p13 <- plot.density(na.df, paste('Month 13'), 13, 'na')
# na.p14 <- plot.density(na.df, paste('Month 14'), 14, 'na')
# na.p15 <- plot.density(na.df, paste('Month 15'), 15, 'na')
# na.p16 <- plot.density(na.df, paste('Month 16'), 16, 'na')
# na.p17 <- plot.density(na.df, paste('Month 17'), 17, 'na')
# na.p18 <- plot.density(na.df, paste('Month 18'), 18, 'na')
# na.p19 <- plot.density(na.df, paste('Month 19'), 19, 'na')
# na.p20 <- plot.density(na.df, paste('Month 20'), 20, 'na')
# na.p21 <- plot.density(na.df, paste('Month 21'), 21, 'na')
# na.p22 <- plot.density(na.df, paste('Month 22'), 22, 'na')
# na.p23 <- plot.density(na.df, paste('Month 23'), 23, 'na')
# na.p24 <- plot.density(na.df, paste('Month 24'), 24, 'na')
# na.p25 <- plot.density(na.df, paste('Month 25'), 25, 'na')
# 
# p.na <- ggdraw() + 
#   draw_plot(na.p1, 0.0, 0.8, 0.21, 0.2) +
#   draw_plot(na.p2, 0.2, 0.8, 0.21, 0.2) +
#   draw_plot(na.p3, 0.4, 0.8, 0.21, 0.2) +
#   draw_plot(na.p4, 0.6, 0.8, 0.21, 0.2) +
#   draw_plot(na.p5, 0.8, 0.8, 0.21, 0.2) +
#   draw_plot(na.p6, 0.0, 0.6, 0.21, 0.2) +
#   draw_plot(na.p7, 0.2, 0.6, 0.21, 0.2) +
#   draw_plot(na.p8, 0.4, 0.6, 0.21, 0.2) +
#   draw_plot(na.p9, 0.6, 0.6, 0.21, 0.2) +
#   draw_plot(na.p10, 0.8, 0.6, 0.21, 0.2) +
#   draw_plot(na.p11, 0.0, 0.4, 0.21, 0.2) +
#   draw_plot(na.p12, 0.2, 0.4, 0.21, 0.2) +
#   draw_plot(na.p13, 0.4, 0.4, 0.21, 0.2) +
#   draw_plot(na.p14, 0.6, 0.4, 0.21, 0.2) +
#   draw_plot(na.p15, 0.8, 0.4, 0.21, 0.2) +
#   draw_plot(na.p16, 0.0, 0.2, 0.21, 0.2) +
#   draw_plot(na.p17, 0.2, 0.2, 0.21, 0.2) +
#   draw_plot(na.p18, 0.4, 0.2, 0.21, 0.2) +
#   draw_plot(na.p19, 0.6, 0.2, 0.21, 0.2) +
#   draw_plot(na.p20, 0.8, 0.2, 0.21, 0.2) +
#   draw_plot(na.p21, 0.0, 0.0, 0.21, 0.2) +
#   draw_plot(na.p22, 0.2, 0.0, 0.21, 0.2) +
#   draw_plot(na.p23, 0.4, 0.0, 0.21, 0.2) +
#   draw_plot(na.p24, 0.6, 0.0, 0.21, 0.2) +
#   draw_plot(na.p25, 0.8, 0.0, 0.21, 0.2) 
# 
# p.manuscript <- ggdraw() + 
#   draw_plot(ha.p1, 0.0, 0, 1/3, 0.5) +
#   draw_plot(ha.p6, 1/3, 0, 1/3, 0.5) +
#   draw_plot(ha.p25, 2/3, 0, 1/3, 0.5) +
#   draw_plot(na.p1, 0.0, 0.5, 1/3, 0.5) +
#   draw_plot(na.p6, 1/3, 0.5, 1/3, 0.5) +
#   draw_plot(na.p25, 2/3, 0.5, 1/3, 0.5) +
#   draw_plot_label(c("A", "B"), c(0, 0), c(1, 0.5), size = 18)
# 
# 
# ggsave(p.ha, filename = 'distribution_plots/ha_dNdS_distribution.pdf', height = 15, width=15)
# ggsave(p.na, filename = 'distribution_plots/na_dNdS_distribution.pdf', height = 15, width=15)
# ggsave(p.manuscript, filename = 'distribution_plots/dNdS_distribution_manuscript.pdf', height = 10, width=15)

df <- data.frame(x = h3.dat$FEL.dN.dS, id = rep('H3', length(h3.dat$FEL.dN.dS)))
h3.p <- plot.density.h3(df, "Hemagglutinin 3", -1, 'h3')
ggsave(h3.p, filename = 'distribution_plots/h3_dNdS_distribution_H3.pdf', height = 5.5, width = 6)

fr <- function(par) {
  means <- diff(pgamma(seq(0, max(df$x), by=0.01), shape = par[1], rate = par[2]))*length(df$x)
  empirical <- as.numeric(table(cut(df$x, breaks = seq(0, max(df$x), by=0.01))))
  return(sum(abs(means - empirical)))
}

fit <- optim(par = c(0.5, 1.5), fr, method="Nelder-Mead", control = list(maxit = 10000, trace=T))

#fit <- fitdistr(df$x, 'gamma', list(shape = 1, scale = 1.5), lower = 0.4, method='L-BFGS-B')

#df <- rbind(df, data.frame(x=rgamma(566, shape = fit$par[1], rate = fit$par[2]), id = rep('Fit', 566)))
fit.p <- ggplot(df, aes(x=x)) +
  geom_histogram(aes(y=..density..), color='gray', fill='gray', binwidth=0.04) + 
  #stat_function(fun=dgamma, args=list(shape = fit$estimate["shape"], scale = fit$estimate["scale"]), size=1.5) +
  stat_function(fun=dgamma, args=list(shape = fit$par[1], rate = fit$par[2]), size=1) +
  ylab('Count') +
  xlab('dN/dS') +
  scale_fill_discrete(name='Data') +
  scale_x_continuous(limit = c(-0.02, max(df$x)))

show(fit.p)

ggsave(fit.p, filename = 'distribution_plots/fit_distribution.pdf', height = 5.5, width = 6)
