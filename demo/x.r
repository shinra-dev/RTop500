library(Rcpuid)
library(RTop500)


cpuinfo <- Rcpuid::cpu_clock()
ncores <- cpuinfo$ncores
theoretical.peak <- cpuinfo$peak

theoretical.peak <- theoretical.peak@size ### FIXME


### Plots
plot.top500(type="theoretical", my.val=theoretical.peak)


plot.top500(type="ncores", my.val=ncores)
