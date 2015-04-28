#!/bin/sh

Rscript -e "library(methods);shiny::runApp('./inst/RTop500', launch.browser=TRUE)"
