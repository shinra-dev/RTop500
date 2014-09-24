top500_plotter <- function(df, my.val, lab, my.val.lab)
{
  g <- ggplot(df, aes(date, value)) + 
         geom_line(aes(colour=Type)) + 
         geom_point(aes(colour=Type), size=1) +
         theme(legend.direction="horizontal", legend.position=c(.5, .972)) + 
         xlab("Date")
  
  if (!is.null(my.val))
  {
    labeldata <- data.frame(date=df[nrow(df), 1L], value=my.val)
    
    g <- g + geom_hline(yintercept=my.val, linetype="dashed") + 
             geom_text(aes(vjust=-.5, hjust=.8), label="My Computer", data=labeldata) + 
             geom_text(aes(vjust=1.5, hjust=.8), label=paste(round(my.val, 2), my.val.lab), data=labeldata)
  }
  
  g <- g + scale_y_log10(breaks=trans_breaks("log10", function(x) 10^x),
             labels=trans_format("log10", math_format(10^.x)))
  
  g <- g + ylab(lab)
  
  g <- g + ggtitle("Performance of the Top 500 Supercomputers")
  
  return( g )
}



plot_top500 <- function(columns=c("Min", "Mean", "Max"), type="theoretical", my.val=NULL)
{
  type <- match.arg(tolower(type), c("theoretical", "linpack", "difference", "ncores"))
  
  if (type == "difference")
  {
    top <- top500.diff()
    lab <- "Difference Between Theoretical Peak and Performance on Linpack Benchmark"
    my.val.lab <- ""
  }
  else
  {
    top <- top500.summary(type=type)
    
    if (type == "theoretical")
    {
      lab <- "Theoretical Peak GFLOPs"
      my.val.lab <- "Peak GFLOPs   "
    }
    else if (type == "linpack")
    {
      lab <- "GFLOPs Performance on the Linpack Benchmark"
      my.val.lab <- "Linpack GFLOPs    "
    }
    else if (type == "ncores")
    {
      lab <- "Number of Cores"
      my.val.lab <- "Cores"
    }
  }
  
  top <- top[, c("date", columns)]
  
  df <- tidyr::gather(top, Type, value, -date)
  df$Type <- factor(df$Type, levels=rev(levels(df$Type)))
  
  if (is.null(my.val))
    my.val.lab <- ""
  
  g <- top500_plotter(df=df, my.val=my.val, lab=lab, my.val.lab=my.val.lab)
  
  return( g )
}
