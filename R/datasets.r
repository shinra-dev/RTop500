#' Top 500 Datasets
#' 
#' All Top500 lists are available up to the release version of the package.
#' For example, package 14.06 contains all Top500 datasets up to June of 2014.
#' Top500 data is released twice a year, every June and November, at the ISC
#' and SC conferences, respectively.
#' 
#' The naming convention for all datasets goes \code{TOP500_<year><month>},
#' where the year is the 4-digit year and month is the 2-digit month that the
#' list was released (either 06 or 11).
#' 
#' \tabular{ll}{ 
#'    rank \tab Rank of the system based on performance of the Linpack benchmark. \cr 
#'    system.id \tab A unique (for Top500 lists) system identifier. \cr 
#'    system.name \tab Name of the machine. \cr 
#'    manufacturer \tab System vendor. \cr 
#'    computer \tab Short description of the nodes. \cr
#'    system.address \tab Machine website. \cr 
#'    r.max \tab Max Linpack benchmark performance in GFLOPs. \cr 
#'    power \tab Power in megawatts with machine at peak. \cr 
#'    r.peak \tab Theoretical peak performance in GFLOPs. \cr 
#'    n.max \tab Problem size for Linpack benchmark to achieve given r.max value. \cr 
#'    n.half \tab Problem size for Linpack benchmark to achieve half of the given r.max value. \cr 
#'    installation.site \tab Location of the machine. \cr 
#'    town \tab Town machine is located in. \cr 
#'    state \tab State machine is located in (if applicable). \cr 
#'    country \tab Country machine is located in. \cr 
#'    year \tab Year machine was created. \cr 
#'    area.of.installation \tab \cr
#'    number.of.processors \tab Number of processors/cores. \cr 
#' } 
#' 
#' Some older lists don't have all of these fields.
#' 
#' @name Top500
#' @aliases Top500 TOP500_199306 TOP500_199311 TOP500_199406 TOP500_199411
#' TOP500_199506 TOP500_199511 TOP500_199606 TOP500_199611 TOP500_199706
#' TOP500_199711 TOP500_199806 TOP500_199811 TOP500_199906 TOP500_199911
#' TOP500_200006 TOP500_200011 TOP500_200106 TOP500_200111 TOP500_200206
#' TOP500_200211 TOP500_200306 TOP500_200311 TOP500_200406 TOP500_200411
#' TOP500_200506 TOP500_200511 TOP500_200606 TOP500_200611 TOP500_200706
#' TOP500_200711 TOP500_200806 TOP500_200811 TOP500_200906 TOP500_200911
#' TOP500_201006 TOP500_201011 TOP500_201106 TOP500_201111 TOP500_201206 
#' TOP500_201211 TOP500_201306 TOP500_201311 TOP500_201406 TOP500_201411
#' 
#' @docType data
#' 
#' @format All Top500 datasets are stored as dataframes, essentially being then
#' output of \code{XML::xmlToDataFrame}.  The raw datasets are available at the
#' official Top500 website, and are mirrored in the GitHub repository of the
#' RTop500 project (along with the parser used by the package).
#' 
#' @references Official Top500 website: \url{http://www.top500.org/}
#' 
#' Raw Top500 data mirror:
#' \url{https://github.com/wrathematics/RTop500/tree/master/raw}
NULL


