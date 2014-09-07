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



top500.diff <- function()
{
  files <- .__TOP500_datafiles
  len <- length(files)
  ret <- data.frame(date=character(len), Min=numeric(len), Mean=numeric(len), Max=numeric(len), stringsAsFactors=FALSE)
  
  for (i in 1L:length(files))
  {
    file <- files[i]
    top.theoretical <- eval(parse(text=file))[, "r.peak"]
    top.linpack <- eval(parse(text=file))[, "r.max"]
    
    top <- top.theoretical - top.linpack
    top <- sapply(top, function(x) max(0.000001, x))
    
    ret[i, 1L] <- name.getter(file)
    ret[i, 2L] <- min(top)
    ret[i, 3L] <- mean(top)
    ret[i, 4L] <- max(top)
  }
  
  ret$date <- as.Date(paste0(ret$date, "01"), format="%Y%m%d")
  
  return( ret )
}

