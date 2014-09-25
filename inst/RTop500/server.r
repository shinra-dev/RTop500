library(shiny)
library(RTop500)


bad_input_plot <- function()
{
  label <- "Bad input!"
  df <- data.frame(x=0, y=0, label=label, stringsAsFactors=FALSE)
  g <- ggplot(df, aes(x=x, y=y, label=label)) + geom_text(size=35) + 
    theme(text = element_blank(), line = element_blank(), title = element_blank())
  
  return(g)
}

type_print <- c("Theoretical peak GFLOPs", "LINPACK GFLOPs", "Theoretical minus LINPACK", "Total number of cores")
type_actual <- c("theoretical", "linpack", "difference", "ncores")

shinyServer(function(input, output){
  output$plot <- renderPlot({
    val <- input$my.val
    if (val == "")
      val <- NULL
    else
      val <- as.numeric(val)
    
    if (!is.null(val) && is.na(val)) return(bad_input_plot())
    
    
    cols <- character(0)
    if (input$col_min) cols <- c(cols, "Min")
    if (input$col_mean) cols <- c(cols, "Mean")
    if (input$col_max) cols <- c(cols, "Max")
    if (input$col_sum) cols <- c(cols, "Sum")
    
    type <- input$type
    type <- type_actual[which(type_print == type)]
    
    if (length(cols) == 0)
      g <- bad_input_plot()
    else
    {
      g <- plot_top500(columns=cols, my.val=val, type=type)
      g <- g + ggtitle(g$labels$y) + ylab("")
    }
    g
  })
})


