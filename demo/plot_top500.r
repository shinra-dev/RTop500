library(okcpuid)
library(RTop500)


cpuinfo <- okcpuid::cpu_clock()
ncores <- cpuinfo$ncores
theoretical.peak <- cpuinfo$peak

theoretical.peak <- unclass(theoretical.peak) / 1e9 ## FIXME

### Plots
plot_top500(type="theoretical", my.val=theoretical.peak)


plot_top500(type="ncores", my.val=ncores)
