name.getter <- function(full.name)
{
  gsub(x=full.name, pattern="TOP500_", replacement="")
}



top500.rank <- function(flops, type="theoretical")
{
  # TODO swap to GFLOPS
  files <- .__TOP500_datafiles
  
  ret <- integer(length(files))
  
  type <- match.arg(tolower(type), c("theoretical", "linpack"))
  if (type == "theoretical")
    col <- "r.peak"
  else if (type == "linpack")
    col <- "r.max"
  
  for (i in 1L:length(files))
  {
    file <- files[i]
    
    top <- eval(parse(text=file))[, col]
    if (any(flops >= top))
      ret[i] <- which(flops >= top)[1L]
    else
      ret[i] <- NA_integer_
  }
  
  return( ret )
}



top500.summary <- function(type="theoretical")
{
  files <- .__TOP500_datafiles
  len <- length(files)
  ret <- data.frame(date=character(len), Min=numeric(len), Mean=numeric(len), Max=numeric(len), Sum=numeric(len), stringsAsFactors=FALSE)
  
  type <- match.arg(tolower(type), c("theoretical", "linpack", "ncores"))
  if (type == "theoretical")
    col <- "r.peak"
  else if (type == "linpack")
    col <- "r.max"
  else if (type == "ncores")
    col <- "number.of.processors"
  
  for (i in 1L:length(files))
  {
    file <- files[i]
    top <- eval(parse(text=file))[, col]
    
    ret[i, 1L] <- name.getter(file)
    ret[i, 2L] <- min(top)
    ret[i, 3L] <- mean(top)
    ret[i, 4L] <- max(top)
    ret[i, 5L] <- sum(top)
  }
  
  ret$date <- as.Date(paste0(ret$date, "01"), format="%Y%m%d")
  
  return( ret )
}



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
  
  gflops <- 10^(1:10-1)
  g <- g + scale_y_continuous(breaks=gflops)
  
  g <- g + coord_trans(ytrans="log10")
#  lab <- paste("Log10", lab)
  
  g <- g + ylab(lab)
  
  g <- g + ggtitle("Performance of the Top 500 Supercomputers")
  
  return( g )
}

