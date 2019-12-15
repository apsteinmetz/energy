library(plotly)
library(readr)
# --------------------------------------------------------
p <- plot_ly(
   type = "sankey",
   orientation = "h",
   
   node = list(
      label = c("A1", "A2", "B1", "B2", "C1", "C2"),
      color = c("blue", "blue", "blue", "blue", "blue", "blue"),
      pad = 15,
      thickness = 20,
      line = list(
         color = "black",
         width = 0.5
      )
   ),
   
   link = list(
      source = c(0,1,0,2,3,3),
      target = c(2,3,3,4,4,5),
      value =  c(8,4,2,8,4,2)
   )
) %>% 
   layout(
      title = "Basic Sankey Diagram",
      font = list(
         size = 10
      )
   )
# --------------------------------------------------------
library(rjson)

json_file <- "https://raw.githubusercontent.com/plotly/plotly.js/master/test/image/mocks/sankey_energy.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

p <- plot_ly(
   type = "sankey",
   domain = list(
      x =  c(0,1),
      y =  c(0,1)
   ),
   orientation = "h",
   valueformat = ".0f",
   valuesuffix = "TWh",
   
   node = list(
      label = json_data$data[[1]]$node$label,
      color = json_data$data[[1]]$node$color,
      pad = 15,
      thickness = 15,
      line = list(
         color = "black",
         width = 0.5
      )
   ),
   
   link = list(
      source = json_data$data[[1]]$link$source,
      target = json_data$data[[1]]$link$target,
      value =  json_data$data[[1]]$link$value
     # label =  json_data$data[[1]]$link$label
   )
) %>% 
   layout(
      title = "Energy forecast for 2050<br>Source: Department of Energy & Climate Change, Tom Counsell via <a href='https://bost.ocks.org/mike/sankey/'>Mike Bostock</a>",
      font = list(
         size = 10
      ),
      xaxis = list(showgrid = F, zeroline = F),
      yaxis = list(showgrid = F, zeroline = F)
   )


# --------------------------------------------------------
sankey_nodes <- read_csv("data/sankey_nodes.csv") %>% head(-1) #last row is junk
sankey_links <- read_csv("data/sankey_links.csv")

nrg_nodes <- list(
   label = sankey_nodes$name,
   color = rep("blue",length(sankey_nodes$name)),
   pad = 1,
   thickness = 1,
   line = list(
      color = "black",
      width = 0.5
   )
)

nrg_links <- list(
   source = sankey_links$source_id,
   target = sankey_links$target_id,
   value = sankey_links$value
)

p <- plot_ly(
   type = "sankey",
   orientation = "h",
   node = nrg_nodes,
   link = nrg_links
) %>% 
   layout(
      title = "US Energy Flow",
      font = list(
         size = 10
      )
   )
