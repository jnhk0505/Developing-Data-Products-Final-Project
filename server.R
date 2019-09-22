library(shiny)
library(ISLR)
library(ggplot2)
library(plotly)
library(caret)
library(MASS)
data(Wage)
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlotly({
        
        minAge <- input$sliderAge[1]
        maxAge <- input$sliderAge[2]
        filter <- filter(Wage,Wage$age >= minAge & Wage$age <= maxAge & 
                             Wage$maritl %in% input$MaritalStatus & Wage$race %in% input$Race &
                             Wage$jobclass %in% input$JobClass)
        a <- ggplot(filter,aes(wage,fill=education,color=education)) + 
            geom_density(alpha=.5,position = "stack")
        ggplotly(a)
        
    })
    
    data <- Wage[,-c(1,11)]
    data$maritl=ifelse(data$maritl=="2. Married","Married", "Other than Married")
    data$maritl <- as.factor(data$maritl)
    Mod <- glm(logwage~age + maritl + education + health + health_ins,
               data=data,family = gaussian(link="identity"))
    Modpred <- reactive({
        Age <- input$Age
        Marital <- input$YourMarital
        Edu <- input$YourEdu
        Health <- input$YourHealth
        HealthIns <- input$YourHealthIns
        predict(Mod, newdata = data.frame(age = Age, maritl = Marital, education = Edu,
                                              health = Health, health_ins = HealthIns))
    })
    
    output$pred <- renderText({
        exp(Modpred())*1000
    })
    
})
