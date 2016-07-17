library(shiny)
source("timeClean.R")
source("getData.R")

require(lubridate)

pageDataPath <- "data/fb_test_datapage.csv"
postDataPath <- "data/fb_post_data.csv"

ui <- fluidPage(
  titlePanel("Facebook Dashboard"),
  sidebarPanel(
    selectInput(inputId = "select1", "Type:",
                c("Type" = "typ",
                  "Weekday" = "wkdy",
                  "AM/PM" = "ampm")),
    selectizeInput(inputId = "select2", "Choose:",
                   c("Reach" = "rch", 
                     "Total Posts" = "ttlpst",
                     "Month" = "mnth"))
  ),
  mainPanel(
    plotOutput("barplot1"),
    plotOutput("barplot2")
    )
  )
# r code

post <- getPostData(postDataPath)
page <- getPageData(pageDataPath)

postTimeParts <- timeClean(post$Posted)
page$Date <- as.Date(page$Date)

post2 <- post[1:46]

post2$Posted <- as.Date(postTimeParts$V1, format = "%m/%d/%Y")
post2$Time <- postTimeParts$V2
post2$AMPM <- postTimeParts$V3
post2$Month <- postTimeParts$V4
post2$Weekday <- postTimeParts$V5

server <- function(input, output) {
  output$barplot1 <- renderPlot({
    b <- input$select1
    if (b == "typ"){
      barplot(tapply(df2$Lifetime.Engaged.Users, df2$Type, FUN = sum)/1000, main = "Lifetime Engaged Users", ylab = "Engaged Users x 1000", col = "red")
    } else if (b == "wkdy") {
      barplot(tapply(df2$Lifetime.Engaged.Users, df2$Weekday, FUN = sum)/1000, main = "Lifetime Engaged Users", ylab = "Engaged Users x 1000", col = "orange")
    } else if (b == "ampm") {
      barplot(tapply(df2$Lifetime.Engaged.Users, df2$AMPM, FUN = sum)/1000, main = "Lifetime Engaged Users", ylab = "Engaged Users x 1000", col = "yellow")
    }
  })
  output$barplot2 <- renderPlot({
    c <- input$select2
    if (c == "rch"){
      barplot(tapply(df2$Lifetime.Post.Total.Reach, df2$AMPM, FUN=sum)/1000, ylab = "Post Reach x 1,000", main = "Reach by Time of Day", col = "green")
    } else if (c == "ttlpst") {
      barplot(table(df2$AMPM),ylab = "Number of Posts", main = "Number of Posts by Time of Day", col = "skyblue")
    } else if (c == "mnth") {
      barplot(tapply(df2$Lifetime.Post.Total.Reach, df2$Month, FUN = sum),ylab = "Number of Posts", main = "Number of Posts by Month", col = "green")
    } 
  })
}

shinyApp(ui = ui, server = server)