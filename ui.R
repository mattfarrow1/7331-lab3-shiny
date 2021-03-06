library(shiny)
library(shinythemes)
library(shinydashboard)

# Load data
load("lab3.Rdata")

header <- dashboardHeader(title = "Lab 3",
                          disable = TRUE)

sidebar <- dashboardSidebar(disable = TRUE)

body <- dashboardBody(fluidRow(column(
  width = 3,
  box(
    width = NULL,
    title = 'Configuration',
    status = "warning",
    solidHeader = TRUE,
    collapsible = TRUE,
    numericInput("nrule", 'Number of Rules', 15),
    radioButtons(
      'samp',
      label = 'Sample',
      choices = c('Sample', 'All Rules'),
      inline = T
    ),
    br(),
    sliderInput(
      "supp",
      "Support:",
      min = 0,
      max = 1,
      value = 0.01 ,
      step = 1 / 10000
    ),
    br(),
    sliderInput(
      "conf",
      "Confidence:",
      min = 0,
      max = 1,
      value = 0.8 ,
      step = 1 / 10000
    ),
    br(),
    selectInput(
      'sort',
      label = 'Sorting Criteria:',
      choices = c('chiSquare', 'lift', 'confidence', 'support')
    ),
    br(),
    br(),
    numericInput("minL", "Min. items per set:", 2),
    br(),
    numericInput("maxL", "Max. items per set:", 3),
    br(),
    checkboxGroupInput("chosen",
                       "Features to Use:",
                       choices = unique(df_names$variable),
                       selected = unique(df_names$variable)),
    selectizeInput(
      'lhs',
      'LHS',
      choices = unique(df_names$variable),
      multiple = TRUE,
      options = list()
    ),
    selectizeInput(
      'rhs',
      'RHS',
      choices = unique(df_names$variable),
      multiple = TRUE,
      options = list()
    ),
    br(),
    downloadButton('downloadData', 'Download Rules as CSV')
  )
),
column(
  width = 9,
  box(
    width = NULL,
    title = 'Association Rules',
    status = 'primary',
    solidHeader = TRUE,
    collapsible = TRUE,
    tabsetPanel(
      tabPanel(
        title = 'Graph',
        value = 'graph',
        plotOutput("graphPlot", width = '100%', height = '100%'),
        radioButtons(
          'graphType',
          label = 'Graph Type',
          choices = c('items', 'itemsets'),
          inline = T
        )
      ),
      tabPanel(
        title = 'Grouped',
        plotOutput("groupedPlot", width = '100%', height = '100%'),
        sliderInput(
          'k',
          label = 'Choose # of Rule Clusters',
          min = 1,
          max = 150,
          step = 1,
          value = 15
        )
      ),
      tabPanel(
        title = 'Scatter',
        value = 'scatter',
        plotOutput("scatterPlot", width = '100%', height = '100%')
      ),
      tabPanel(
        title = 'Data Table',
        value = 'datatable',
        dataTableOutput("rulesDataTable")
      )
    )
  )
)))

dashboardPage(header,
              sidebar,
              body)