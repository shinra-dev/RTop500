library(XML)


read.xml <- function(x)
{
  XML::xmlToDataFrame(x, stringsAsFactors=FALSE)
}

name.getter <- function(filename)
{
  gsub(x=filename, pattern="TOP500_|[.]xml|_all", replacement="")
}

process <- function(file)
{
  tmp <- read.xml(file)
  
  name <- name.getter(file)
  rname <- paste("TOP500_", name, sep="")
  
  # There's probably a better way to do this...
  names(tmp) <- gsub(x=names(tmp), pattern="-", replacement=".")
  
  tmp$rank <- as.integer(tmp$rank)
  tmp$system.id <- as.integer(tmp$system.id)
  tmp$r.max <- as.numeric(tmp$r.max)
  tmp$year <- as.integer(tmp$year)
  tmp$number.of.processors <- as.integer(tmp$number.of.processors)
  tmp$r.peak <- as.numeric(tmp$r.peak)
  tmp$n.half <- as.integer(tmp$n.half)
  
  
  assign(rname, tmp)
  
  outname <- paste("../data/", name, ".rda", sep="")
  save(list=rname, file=outname, compress=TRUE)
  
  invisible()
}

write_R <- function(stuff, file)
{
  stuff <- paste0(".__TOP500_datafiles <- c(\n", paste0("  \"", stuff,  collapse="\",\n"), "\"\n)")
  writeLines(text=stuff, file)
  
  invisible()
}



files <- dir(pattern="*.xml")

for (file in files) process(file)

files <- dir(path="../data/", pattern="*.rda")
files <- files[!grepl(files, pattern="datafiles")]
files <- gsub(files, pattern="[.]rda", replacement="")
files <- paste("TOP500_", files, sep="")

#assign(".__TOP500_datafiles", files)
#save(list=".__TOP500_datafiles", file="../data/TOP500_datafiles.rda")
write_R(stuff=files, file="../R/top500_list.r")


