library(shiny) 
library(somebm)
library(tidyverse)
library(ggplot2)

gbm_loop <- function(nsim = 100, t = 25, mu = 0, sigma = 0.1, S0 = 100, dt = 1./365) {
  gbm <- matrix(ncol = nsim, nrow = t)
  for (simu in 1:nsim) {
    gbm[1, simu] <- S0
    for (day in 2:t) {
      epsilon <- rnorm(1)
      dt = 1 / 365
      gbm[day, simu] <- gbm[(day-1), simu] * exp((mu - sigma * sigma / 2) * dt + sigma * epsilon * sqrt(dt))
    }
  }
  return(gbm)
}

shinyServer(
  
  
  function(input, output) {
output$indice1=renderUI({
  sliderInput("nsim","Nombre de simulation",min=1,max=200,value=100)
  
})
output$indice2=renderUI({
  sliderInput("mu","Moyenne",min=-20,max=20,value=0)
  
})
output$indice3=renderUI({
  sliderInput("sigma","Variance",min=0,max=10,value=1)
  
})

  
  

t = 100
S0=100
gbm1=reactive({
   gbm=gbm_loop(input$nsim,t,input$mu,input$sigma,S0)
  
   gbm_df <- as.data.frame(gbm) %>%
     mutate(temps = 1:nrow(gbm)) %>%
     pivot_longer(-temps, names_to = 'sim', values_to = 'prix')
})


output$graphe=renderPlot({

  gbm1() %>%
    ggplot(aes(x=temps, y=prix, color=sim)) +
    geom_line() +
    theme(legend.position = 'none')
       
       } )    
  }
)







