#shiny사용하기
install.packages("shiny")

#######################################
#######################################
#기본구조 딱 4줄
library(shiny)
ui<-fluidPage()
server<-function(input, output) {}
shinyApp(ui=ui, server=server)

#######################################
#######################################
#기본구조 뜯어보기 
library(shiny)
ui<-fluidPage(  # 보여주는 것들 지정
  #input
  #output
)
server<-function(input, output) {  #데이터가 실제로 처리되기 지정
  #output <- input
}
shinyApp(ui=ui, server=server)    #ui 와 server 연동해서 불러오기 


#######################################
#######################################
#한번 해보자 

library(shiny)
ui<-fluidPage(
  sliderInput(inputId="num_1",
              label="숫자를 고르세요",
              value=25, min=1, max=80, step=1),
  plotOutput("hist")
)
server<-function(input, output) {
  output$hist <- renderPlot({
    title <- "80 random normal values "
    hist( rnorm(input$num_1), main=title)
  })
}
shinyApp(ui=ui, server=server)



#######################################
#######################################
#BMI 계산기 만들기

library(shiny)
ui <- fluidPage( 
  titlePanel("BMI "),              
  sidebarPanel(
    numericInput('wt', 'Weight in Kg', 70, min = 30, max = 200),
    numericInput('ht', 'Height in cm', 165, min = 50, max = 250),
    submitButton('Submit')
  ),
  mainPanel(
    h3('Results'),
    h4('Your weight'),
    verbatimTextOutput("inputValue1"),
    h4('Your height'),
    verbatimTextOutput("inputValue2"),
    h4('Your BMI is '),
    verbatimTextOutput("results")                
  )
)
server <- function(input, output) { 
  bmi_calc <- function(weight, height) (weight/(height/100)^2)
  output$inputValue1 <- renderPrint({input$wt})
  output$inputValue2 <- renderPrint({input$ht})
  output$results <- renderPrint({bmi_calc(input$wt, input$ht)})
}
shinyApp(ui = ui, server = server)


#######################################
#######################################
#


