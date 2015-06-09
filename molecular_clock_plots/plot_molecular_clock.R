rm(list = ls())

library(ggplot2)
library(grid)
library(cowplot)
library(zoo)
library(scales)

setwd('~/Google Drive/Documents/PostDoc/DataLimitations/influenza_pH1N1_timecourse/molecular_clock_plots/')

plot.mc <- function(d, limits, dates.for.plot) {
  p <- ggplot(data=d, aes(x=as.numeric(Date), y=y)) + geom_point() + 
    geom_errorbar(limits, width=10) + 
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
    scale_y_continuous(breaks = seq(0, 0.04, 0.005), limits = c(0, 0.028))
}

ds <- as.Date(c('04/30/2009', 
                '05/31/2009', 
                '06/30/2009',
                '07/31/2009',
                '08/31/2009',
                '09/30/2009',
                '10/31/2009',
                '11/30/2009',
                '12/31/2009',
                '01/31/2010',
                '06/30/2010',
                '11/30/2010',
                '04/30/2011'), format='%m/%d/%Y')

## Evolutionary rate
na.d <- data.frame(Date=ds,
                   y=c(1.926e-2, 1.133e-2, 4.292e-3, 4.6e-3, 4.386e-3, 4.113e-3, 4.298e-3, 4.611e-3, 4.747e-3, 4.858e-3, 5.065e-3, 4.893e-3, 4.597e-3))

na.se <- c(3.95E-3, 1.410E-3, 1.168E-4, 1.466E-5, 1.308E-5, 1.283E-5, 1.134E-5, 1.375E-5, 1.187E-5, 1.196E-5, 1.062E-5, 1.047E-5, 1.023E-5)

na.ci <- aes(ymax = na.d$y+1.96*na.se, 
             ymin = na.d$y-1.96*na.se)

p1 <- plot.mc(na.d, na.ci, ds)

ha.d <- data.frame(Date=ds,
                   y=c(1.598e-2, 1.1675e-2, 6.646e-3, 5.709e-3, 5.554e-3, 4.343e-3, 4.444e-3, 4.579e-3, 4.59e-3, 4.512e-3, 4.837e-3, 5.242e-3, 5.1862e-3))

ha.se <- c(1.775E-4, 9.975E-5, 1.133E-4, 2.161E-5, 1.927E-5, 1.302E-5, 1.006E-5, 9.095E-6, 7.928E-6, 7.454E-6, 9.097E-6, 9.385E-6, 7.438E-6)

ha.ci <- aes(ymax = ha.d$y+1.96*ha.se, 
             ymin = ha.d$y-1.96*ha.se)

p2 <- plot.mc(ha.d, ha.ci, ds)

p <- ggdraw() +
  draw_plot(p2, 0, 0, 0.5, 1) +
  draw_plot(p1, 0.5, 0, .5, 1) +
  draw_plot_label(c("A", "B"), c(0, 0.5), c(1, 1), size = 16)

ggsave(p, file='clock_rate.pdf', height = 6, width = 12)

## Theta

plot.theta <- function(d, limits, dates.for.plot) {
  p <- ggplot(data=d, aes(x=as.numeric(Date), y=y)) + geom_point() + 
    geom_errorbar(limits, width=10) + 
    xlab("Time") +
    ylab("Theta") +
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
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(0.1,1E18))
}


ha.d <- data.frame(Date=ds,
                   y=c(3.035E8, 5.423E13, 6.414E7, 1.311E8, 1.962E8, 1.559E8, 6.073E8, 1.373E8, 1.185E10, 3.011E9, 5.618E12, 16.634, 9.82)*2)

ha.ci <- aes(ymax = c(1.935E13, 2.232E14, 5.138E13, 7.397E13, 8.953E13, 2.453E14, 6.130E14, 7.732E14, 1.060E16, 2.266E16, 1.945E17, 25.430, 12.008)*2, 
             ymin= c(1.270, 4.536E11, 0.652, 1.986, 3.741, 7.156, 16.913, 20.126, 47.591, 20.047, 26.521, 9.981, 7.700)*2)

na.d <- data.frame(Date=ds,
                   y=c(2.379E5, 1.319E13, 4.347E6, 3.242E7, 1.435E7, 1.317E8, 3.660E8, 2.050E8, 6.068E8, 2.017E9, 5.533E13, 15.095, 8.872)*2)

na.ci <- aes(ymax = c(3.94E12, 1.52E14, 3.06E13, 3.49E13, 4.38E13, 1.75E14, 3.30E14, 4.13E14, 1.29E15, 4.24E15, 4.17E16, 27.91, 11.62)*2, 
             ymin= c(0.335, 0.746, 0.228, 0.773, 1.349, 3.828, 6.218, 6.738, 10.394, 15.222, 15.903, 6.547, 6.606)*2)

p1 <- plot.theta(ha.d, ha.ci, ds)
p2 <- plot.theta(na.d, na.ci, ds)

p <- plot_grid(p1, p2, labels = c('A', 'B'))
ggsave(p, file='theta.pdf', height = 6, width = 12, useDingbats = F)

## Root Height

plot.rh <- function(d, limits, dates.for.plot) {
  p <- ggplot(data=d, aes(x=as.numeric(Date), y=y)) + geom_point() + 
    geom_errorbar(limits, width=10) + 
    xlab("Time") +
    ylab("Theta") +
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
    scale_y_continuous(breaks = seq(0, 10, 0.5), limits = c(0, 10))
}

na.d <- data.frame(Date=ds,
                   y=c(0.14, 0.32, 5.79, 0.69, 0.82, 1.01, 1.09, 1.14, 1.234, 1.31, 1.66, 2.14, 2.55))

na.se <- c(7.19E-4, 1.63E-3, 2.03, 2.07E-3, 2.27E-3, 3.30E-3, 2.85E-3, 2.85E-3, 2.36E-3, 2.41E-3, 2.00E-3, 2.08E-3, 1.94E-3)

na.ci <- aes(ymax = na.d$y+1.96*na.se, 
             ymin = na.d$y-1.96*na.se)

ha.d <- data.frame(Date=ds,
                   y=c(0.19, 0.36, 5.38, 1.17, 1.28, 1.48, 1.52, 1.58, 1.68, 1.79, 2.05, 2.37, 2.75))

ha.se <- c(1.53E-3, 2.11E-3, 1.60, 5.07E-3, 4.83E-3, 5.26E-3, 4.28E-3, 4.39E-3, 3.87E-3, 3.84E-3, 3.88E-3, 2.96E-3, 2.85E-3)

ha.ci <- aes(ymax = ha.d$y+1.96*ha.se, 
             ymin = ha.d$y-1.96*ha.se)


p1 <- plot.rh(ha.d, ha.ci, ds)
p2 <- plot.rh(na.d, na.ci, ds)

p <- plot_grid(p1, p2, labels = c('A', 'B'))
ggsave(p, file='rootheight.pdf', height = 6, width = 12, useDingbats = F)
