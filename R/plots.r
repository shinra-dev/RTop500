plot.top500 <- function(columns=c("Min", "Mean", "Max"), type="theoretical", my.val=NULL)
{
  top <- top500.summary(type=type)
  
  top <- top[, c("date", columns)]
  
#  if (!is.null(my.val))
#  {
#    if (!is.numeric(my.val))
#      stop("'my.val' must be whatever")
#    
#    top <- cbind(top, Me=top500.rank(flops=my.val, type=type))
#  }
  
  df <- tidyr::gather(top, Type, value, -date)
  df$Type <- factor(df$Type, levels=rev(levels(df$Type)))
  
  g <- ggplot(df, aes(date, value)) + 
       geom_line(aes(colour=Type)) + 
       geom_point(aes(colour=Type), size=1) +
       theme(legend.direction="horizontal", legend.position=c(.5, .972)) + 
       xlab("Date")
  
  type <- match.arg(tolower(type), c("theoretical", "linpack", "ncores"))
  if (type == "theoretical")
    lab <- "Theoretical Peak GFLOPs"
  else if (type == "linpack")
    lab <- "GFLOPs Performance on the Linpack Benchmark"
  else if (type == "ncores")
    lab <- "Number of Cores"
  
  if (!is.null(my.val))
  {
    labeldata <- data.frame(date=df[nrow(df), 1L], value=my.val)
    g <- g + geom_hline(yintercept=my.val, linetype="dashed") + 
             geom_text(aes(vjust=-.5, hjust=.8), label="My Computer", data=labeldata)
  }
  
  g <- g + scale_y_log10(breaks=trans_breaks("log10", function(x) 10^x),
                     labels=trans_format("log10", math_format(10^.x)))
  
  g <- g + ylab(lab)
  
  g <- g + ggtitle("Performance of the Top 500 Supercomputers")
  
  return( g )
}



plot.top500.diff <- function(my.val=NULL)
{
  top <- top500.diff()
  
  df <- tidyr::gather(top, Type, value, -date)
  df$Type <- factor(df$Type, levels=rev(levels(df$Type)))
  
  g <- ggplot(df, aes(date, value)) + 
       geom_line(aes(colour=Type)) + 
       geom_point(aes(colour=Type), size=1) +
       theme(legend.direction="horizontal", legend.position=c(.5, .972)) + 
       xlab("Date")
  
  lab <- "Difference Between Theoretical Peak and Performance on Linpack Benchmark"
  
  if (!is.null(my.val))
  {
    labeldata <- data.frame(date=df[nrow(df), 1L], value=my.val)
    g <- g + geom_hline(yintercept=my.val, linetype="dashed") + 
             geom_text(aes(vjust=-.5, hjust=.8), label="My Computer", data=labeldata)
  }
  
  g <- g + scale_y_log10(breaks=trans_breaks("log10", function(x) 10^x),
                     labels=trans_format("log10", math_format(10^.x)))
  
  g <- g + ylab(lab)
  
  g <- g + ggtitle("Performance of the Top 500 Supercomputers")
  
  return( g )
}

