library(shiny)
library(plotly)

shinyUI(fluidPage(
    
    
    titlePanel("Mid Atlantic Wage Explained"),
    
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderAge","This graph on the right shows what the data has. Pick A Min and A Max Age",
                        18,80,value = c(20,60)),
            selectInput("MaritalStatus","Pick Marital Status",
                        c("1. Never Married","2. Married","3. Widowed","4. Divorced","5. Separated"),
                        selected = "1. Never Married", multiple = TRUE),
            selectInput("Race","Race",c("1. White","2. Black","3. Asian","4. Other"),
                        selected = "3. Asian", multiple = TRUE),
            selectInput("JobClass","Job Class",c("1. Industrial","2. Information"),
                        selected = "2. Information", multiple = TRUE),
            numericInput("Age","Now pretend you were in Mid Atlantic Region, let us see how much
                        income you would have.  How old are you?",value=20),
            selectInput("YourMarital","Pick Your Marital Status",
                        c("Married","Other than Married"),selected = "Married",
                        multiple = FALSE),
            selectInput("YourEdu","Pick Your Education Level",
                        c("1. < HS Grad","2. HS Grad","3. Some College","4. College Grad",
                          "5. Advanced Degree"),selected = "5. Advanced Degree", multiple = FALSE),
            selectInput("YourHealth","Pick Your Health Condition",
                        c("1. <=Good","2. >=Very Good"),selected = "2. >=Very Good", multiple = FALSE),
            selectInput("YourHealthIns","You have Health Insurance?",c("1. Yes","2. No"), selected = "1. Yes",
                        multiple = FALSE)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("distPlot"),
            h4("Your Predicted Wage:"),
            textOutput("pred")
        )
    )
))