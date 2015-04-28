library(shiny)


about.thisapp <- HTML("
  <p>
  This 
  <a href='http://www.rstudio.com/products/shiny/'>shiny</a> 
  app uses 
  <a href='https://github.com/wrathematics/RTop500'>the RTop500 package</a>.
  The 
  <a href='https://github.com/wrathematics/RTop500/tree/master/inst/ShinyApps/RTop500'>source</a>
  for this shiny app is available in the RTop500 package.
  <br><br>
  
  Hosting is generously provided by 
  <a href='https://www.shinyapps.io/'>RStudio</a>.
  </p>"
)

info <- HTML("
<p>
The plot below contains a visual summary of all Top 500 supercomputers
from June 1993 to present.
</p>

<p>
The text box \"My Computer\" allows you to visually see how your 
computer stacks up.  Theoretical peak performance is calculate as:
  <br>
  <center>
  GFLOPs = (# Cores) * (Speed per core in Ghz) * (# SSE units per core) * (# SSE ops per second)
  </center>
  
  <br>
A good guess for reasonably modern hardware is:
  <br><br>
  <center>
  My Computer = (# Cores) * (Speed per core in Ghz) * 2 * 2
  </center>
</p>

<p>
If you are interested in having a more accurate estimate of 
theoretical peak performance, LINPACK benchmark performance, 
or finding more information about your processor in general, 
check out the
<a href=\"https://github.com/wrathematics/okcpuid\">okcpuid package</a>.
</p>
<hr>
"
)


type_print <- c("Theoretical peak GFLOPs", "LINPACK GFLOPs", "Theoretical minus LINPACK", "Total number of cores")



shinyUI(
  fluidPage(
    titlePanel("Performance of the Top 500 Supercomputers"),
    fluidRow(
      helpText(info)
    ),
    fluidRow(
    sidebarPanel(
      textInput("my.val", "My Computer", ""),
      selectizeInput('type', 'Type of Plot', type_print, "theoretical"),
      checkboxInput("col_min", "Min", TRUE),
      checkboxInput("col_mean", "Mean", TRUE),
      checkboxInput("col_med", "Median", FALSE),
      checkboxInput("col_max", "Max", TRUE),
      checkboxInput("col_sum", "Sum", FALSE)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Top500", plotOutput("plot")),
        tabPanel("About", helpText(about.thisapp))
      )
    )
  ))
)

