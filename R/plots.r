top500_plotter <- function(df, my.val, lab, my.val.lab)
{
  ### Fooling R CMD check
  value <- Type <- .x <- NULL
  
  
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



check_columns <- function(columns)
{
  columns <- unique(columns)
  possible <- c("Min", "Mean", "Max", "Median", "Sum")
  printpossible <- paste0(possible, collapse=", ")
  
  if (typeof(possible) != "character")
    stop(paste("'columns' must be a character vector containing only", possible), call.=FALSE)
  
  if (length(columns) == 0)
    stop("You must ", call.=FALSE)
  else if (length(columns) > length(possible))
    stop(paste("'columns' must be a character vector with no more than", length(possible)), call.=FALSE)
  
  for (col in columns)
  {
    if (!(col %in% possible))
      stop(paste("'columns' must be a character vector with possible values", printpossible), call.=FALSE)
  }
  
  invisible()
}





#' Top500 Data Plotter
#' 
#' \code{plot_top500} is a simple interface for being able to quickly summarize
#' historical supercomputing data.  It also includes an option for comparing
#' your own data against the historical supercomputing data.
#' 
#' TODO what do the options mean
#' 
#' Whichever combination of columns is passed will be plotted, and more than
#' one can be used.  For example, passing \code{columns=c("Min", "Max")} will
#' show the min and max lines.
#' 
#' @param columns 
#' A vector of strings that determines which values will be
#' shown on the graph.  Options include "Min", "Mean, "Max", "Median", and "Sum".
#' @param type 
#' A string indicating the type of quantity to plot.  Options are
#' "theoretical", "linpack", "difference", and "ncores".
#' @param my.val 
#' An optional value (matching the type argument) to add to the
#' plot.  Want to see how your macine's performance compares with all
#' supercomputers since 1993?  Pass your own value and see.  Passing NULL does
#' nothing.
#' 
#' @export
plot_top500 <- function(type="theoretical", columns=c("Min", "Mean", "Max"), my.val=NULL)
{
  ### Fooling R CMD check
  Type <- value <- NULL
  rm(list=c("Type", "value"))
  
  check_columns(columns=columns)
  
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

