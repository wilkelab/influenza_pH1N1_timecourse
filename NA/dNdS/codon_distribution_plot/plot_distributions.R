rm(list = ls())

library(ggplot2)
library(cowplot)

plot.density <- function(data, title) {
  #data <- data[data$x != 1, ]
  p <- ggplot(data, aes(x = x)) + geom_density(adjust=2)
  p <- p + scale_x_continuous(limit = c(0, 15), breaks=seq(0, 15, by=3))
  p <- p + ylab("Density")
  p <- p + xlab('Number of Distinct Codons')
  p <- p + ggtitle(title)
  
  #ggsave(p, filename = paste('dNdS_distribution_', data$id[1], '.pdf', sep=''), height = 4.5, width=5)
  return(p)
}

counts <- c()
id <- c()
fractions.1 <- c()
fractions.2 <- c()
fractions.3 <- c()
fractions.4 <- c()
fractions.5 <- c()
fractions.6 <- c()
fractions.7 <- c()
fractions.8 <- c()

for(i in 1:25){
  counts.temp <- read.table(paste('codon_counts/', i, '.dat', sep=''), sep=',', head=T)
  map <- read.table(paste('structure_maps/map_', i, '.txt', sep=''), head=F)
  counts <- append(counts, counts.temp$num_codon[map$V1 != '-'])
  id <- append(id, rep(i, length(counts.temp$num_codon[map$V1 != '-'])))
  fractions.1 <- append(fractions.1, sum(counts == 1)/length(counts))
  fractions.2 <- append(fractions.2, sum(counts == 2)/length(counts))
  fractions.3 <- append(fractions.3, sum(counts == 3)/length(counts))
  fractions.4 <- append(fractions.4, sum(counts == 4)/length(counts))
  fractions.5 <- append(fractions.5, sum(counts == 5)/length(counts))
  fractions.6 <- append(fractions.6, sum(counts > 5)/length(counts))
}

df <- data.frame(x = counts, id = id)

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
  draw_plot(p1, 0.0, 0.8, 0.2, 0.2) +
  draw_plot(p2, 0.2, 0.8, 0.2, 0.2) +
  draw_plot(p3, 0.4, 0.8, 0.2, 0.2) +
  draw_plot(p4, 0.6, 0.8, 0.2, 0.2) +
  draw_plot(p5, 0.8, 0.8, 0.2, 0.2) +
  draw_plot(p6, 0.0, 0.6, 0.2, 0.2) +
  draw_plot(p7, 0.2, 0.6, 0.2, 0.2) +
  draw_plot(p8, 0.4, 0.6, 0.2, 0.2) +
  draw_plot(p9, 0.6, 0.6, 0.2, 0.2) +
  draw_plot(p10, 0.8, 0.6, 0.2, 0.2) +
  draw_plot(p11, 0.0, 0.4, 0.2, 0.2) +
  draw_plot(p12, 0.2, 0.4, 0.2, 0.2) +
  draw_plot(p13, 0.4, 0.4, 0.2, 0.2) +
  draw_plot(p14, 0.6, 0.4, 0.2, 0.2) +
  draw_plot(p15, 0.8, 0.4, 0.2, 0.2) +
  draw_plot(p16, 0.0, 0.2, 0.2, 0.2) +
  draw_plot(p17, 0.2, 0.2, 0.2, 0.2) +
  draw_plot(p18, 0.4, 0.2, 0.2, 0.2) +
  draw_plot(p19, 0.6, 0.2, 0.2, 0.2) +
  draw_plot(p20, 0.8, 0.2, 0.2, 0.2) +
  draw_plot(p21, 0.0, 0.0, 0.2, 0.2) +
  draw_plot(p22, 0.2, 0.0, 0.2, 0.2) +
  draw_plot(p23, 0.4, 0.0, 0.2, 0.2) +
  draw_plot(p24, 0.6, 0.0, 0.2, 0.2) +
  draw_plot(p25, 0.8, 0.0, 0.2, 0.2) 

p.manuscript <- ggdraw() + 
  draw_plot(p1, 0.0, 0, 1/3, 1) +
  draw_plot(p6, 1/3, 0, 1/3, 1) +
  draw_plot(p25, 2/3, 0, 1/3, 1) 

ggsave(p, filename = 'codon_distribution.pdf', height = 15, width=15)
ggsave(p.manuscript, filename = 'codon_distribution_manuscript.pdf', height = 5, width=15)

#h3.p <- plot.density(data.frame(x = h3.dat$FEL.dN.dS, id = rep('H3', length(h3.dat$FEL.dN.dS))), "Hemagglutinin 3")

plot.data <- data.frame(id = as.vector(sapply(rep(1:6), function(x) rep(x, 25))), x=rep(1:25, 6), y=c(fractions.1, fractions.2, fractions.3, fractions.4, fractions.5, fractions.6) )
p <- ggplot(plot.data, aes(x=x, y=y, group=id, color=factor(id))) + 
  geom_path(size=1.5, lineend = "round", linejoin="mitre") + 
  guides(colour = guide_legend(order = 1)) +
  #scale_color_gradientn(name='Distinct\nCodons') +
  scale_colour_hue(name='Distinct\nCodons', l=60) + 
  scale_y_continuous(limits=c(0,1)) + 
  scale_x_continuous(limits=c(1,25)) + 
  ylab('Fraction of Total Codons') + 
  xlab('Time (Months)') +
  theme(legend.position = c(1, 1), legend.justification = c(1, 1))
ggsave(p, filename='fraction_mutations_na.pdf', height=5, width=5.5)
