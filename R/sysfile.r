#' Location to Shiny Dir
#' 
#' File path to shiny app for the RTop500 package.
#' 
#' @examples
#' \dontrun{
#' library(RTop500)
#' shiny::runApp(RTop500_shinydir())
#' }
#' 
#' @export
RTop500_shinydir <- function() tools::file_path_as_absolute(base::system.file("RTop500", package="RTop500"))
