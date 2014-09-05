read.xml <- function(x)
{
  XML::xmlToDataFrame(x)
}

name.getter <- function(filename)
{
  name <- gsub(x=filename, pattern="TOP500_|[.]xml|_all", replacement="")
  
  return( name )
}

files <- dir(pattern="*.xml")


