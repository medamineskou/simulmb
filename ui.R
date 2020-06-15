

library(shiny) 


shinyUI(fluidPage(

   
titlePanel(h4('Simulateur de mouvement brownien géométrique', align = "center")),
  
sidebarLayout(
  sidebarPanel(
    ("Information"),
    br(),
    uiOutput("indice1"),
    br(),
    uiOutput("indice2"),
    br(),
    uiOutput("indice3")

    
),

  mainPanel(
    tabsetPanel(type="tab",
                
                tabPanel("Visualisation graphique",plotOutput("graphe"))
                
    )
    
)
  


  

    
  )
  
)
)
