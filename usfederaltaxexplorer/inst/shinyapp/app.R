# Tax bracket function
get_marginal_tax_rate <- function(income, filing_status) {
  brackets <- list(
    "single" = c(11000, 44725, 95375, 182100, 231250, 578125),
    "married_jointly" = c(22000, 89450, 190750, 364200, 462500, 693750)
  )

  rates <- c(0.10, 0.12, 0.22, 0.24, 0.32, 0.35, 0.37)
  tax_bracket <- brackets[[filing_status]]

  if (income <= tax_bracket[1]) {
    return(rates[1])
  } else if (income <= tax_bracket[2]) {
    return(rates[2])
  } else if (income <= tax_bracket[3]) {
    return(rates[3])
  } else if (income <= tax_bracket[4]) {
    return(rates[4])
  } else if (income <= tax_bracket[5]) {
    return(rates[5])
  } else if (income <= tax_bracket[6]) {
    return(rates[6])
  } else {
    return(rates[7])
  }
}

# Tax breakdown function
tax_breakdown <- function(user_income, marginal_tax_rate) {
  tax <- user_income * marginal_tax_rate
  breakdown_table <- data.frame(
    Program = c("Healthcare", "Defense", "Interest on Debt", "Social Security",
                "Economic Security", "General Government", "Veterans Benefits",
                "Infrastructure", "Education", "Natural Resources",
                "International Affairs"),
    `Dollars` = dollar(c(
      tax * 0.27, tax * 0.13, tax * 0.10, tax * 0.21,
      tax * 0.08, tax * 0.05, tax * 0.05, tax * 0.05,
      tax * 0.04, tax * 0.02, tax * 0.01
    ))
  )
  return(breakdown_table)
}

# Define UI
ui <- fluidPage(
  # CSS for background color, font, and title styling
  tags$head(
    tags$style(HTML("
      body {
        background-color: #EAEAEA;
        font-family: 'Trebuchet MS', 'Arial', sans-serif;
      }
      h1 {
        color: #BA9F80;
        text-align: center;
        margin-bottom: 10px;
      }
    "))
  ),
  # Custom title with hex color
  tags$h1(
    "U.S. Federal Tax Breakdown",
    style = "color: #BA9F80; text-align: center; margin-bottom: 10px;"
  ),

  tags$p(
    "Every year Americans file their federal taxes to fun different programs
    such as healthcare, defense, social programs, infrastructure, and more.
    Understanding where your tax dollars go is helpful in public discourse and civics,
    especially during elections. This app allows you to input your yearly
    income and marital status to learn where your tax dollars
    are being used.
    The output table has two fields. The first field
    is Program, which breaks down the major spending program under the US
    federal government. The second field is Dollars, which is the dollar
    amount of your taxes that are being aportioned for each program.
    For example, if you see 'Defense $1000`, that means $1000 of your taxes
    are being used for defense for the yaer.",
    style = "font-size: 16px; margin-bottom: 20px;"
  ),

  # Sidebar layout with inline style for background color
  sidebarLayout(
    sidebarPanel(
      div(
        style = "display: flex; align-items: center;",
        tags$label("Enter your yearly income:"),
        tags$span("$", style = "font-size: 16px; margin-right: 5px;"),
        numericInput("income", label = NULL, value = 60000, min = 0)
      ),
      selectInput("filing_status", "Select your filing status:",
                  choices = c("Single" = "single", "Married Jointly" = "married_jointly")),
      actionButton("calculate", "Calculate"),
      style = "background-color: #BA9F80; color: white; padding: 15px; border-radius: 10px;"
    ),

    mainPanel(
      uiOutput("results_ui")
    )
  )
)


# Define server logic
server <- function(input, output) {
  library(scales)
  # Reactive event triggered by the Calculate button
  breakdown_data <- eventReactive(input$calculate, {
    marginal_tax_rate <- get_marginal_tax_rate(input$income, input$filing_status)
    tax_breakdown(input$income, marginal_tax_rate)
  })

  # Render the results heading and table conditionally
  output$results_ui <- renderUI({
    req(breakdown_data())  # Ensure this only runs after Calculate is pressed
    tagList(
      h4("Tax Breakdown:"),
      tableOutput("breakdown_table")
    )
  })

  # Render the breakdown table
  output$breakdown_table <- renderTable({
    breakdown_data()
  }, striped = TRUE, hover = TRUE, align = "c")
}

# Run the application
shinyApp(ui = ui, server = server)
