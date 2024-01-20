# Utils

loadPackages <- function(pckgs){
  # Load packages, installing the ones needed 
  #
  # Arguments: 
  #   pckgs: vector with packages names.
  new.packages     <- pckgs[!(pckgs %in% installed.packages()[, "Package"])]
  if(length(new.packages)) { install.packages(new.packages) }
  for (pckg in pckgs) {
    suppressMessages(library(pckg, character.only = TRUE) )  
  }
}


generate_soccer_field <- function(){
  # Generate a soccer field
  
  require(ggplot2)
  
  ggplot() +
    geom_rect(aes(xmin = 0,  xmax = 100, ymin = 0,  ymax = 100), fill = NA, colour = "ghostwhite", linewidth = 1)  +
    geom_rect(aes(xmin = 0,  xmax = 50,  ymin = 0,  ymax = 100), fill = NA, colour = "ghostwhite", linewidth = 1,) +
    geom_rect(aes(xmin = 0,  xmax = 100, ymin = 25, ymax = 75),  fill = NA, colour = "ghostwhite", linewidth = 0.5, linetype = 8) +
    geom_rect(aes(xmin = 0,  xmax = 100, ymin = 0,  ymax = 50),  fill = NA, colour = "ghostwhite", linewidth = 0.5, linetype = 8) +
    geom_rect(aes(xmin = 25, xmax = 75,  ymin = 0,  ymax = 100), fill = NA, colour = "ghostwhite", linewidth = 0.5, linetype = 8) +
    geom_rect(aes(xmin = 0,  xmax = 5,   ymin = 40, ymax = 60),  fill = NA, colour = "ghostwhite", linewidth = 1) + 
    geom_rect(aes(xmin = 95, xmax = 100, ymin = 40, ymax = 60),  fill = NA, colour = "ghostwhite", linewidth = 1) +
    theme(panel.background = element_rect(fill = 'palegreen1', colour = 'lawngreen')) + # background color
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +    
    annotate("text", x = Inf, y = -Inf, label = "@leokova",
             hjust=1.7, vjust=-1, col="grey80", cex=10,
             fontface = "bold", alpha = 0.5)+
    geom_point(data = data.frame(x = 50, y = 50), aes(x, y),colour = "ghostwhite", size = 4)
}
