# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(skimr)       # For descriptive stats
library(broom)       # For tidy regression output
library(DT)          # For clean data tables

# Read the data
data <- read.csv("Cleaned_Chocolate_Sales.csv", stringsAsFactors = FALSE)

# Clean data
data$Amount <- as.numeric(gsub("[\\$,]", "", data$Amount))
data$Date <- as.Date(data$Date, format = "%Y-%m-%d")

# Add numeric version of Date for regression
data$NumericDate <- as.numeric(data$Date)

# Precompute top 5 products
sales_by_product <- data %>% 
  group_by(Product) %>% 
  summarise(Total_Sales = sum(Amount)) %>% 
  arrange(desc(Total_Sales))

top_5_sales <- head(sales_by_product, 5)

# Define UI
ui <- fluidPage(
  # Custom CSS for styling
  tags$head(
    tags$style(HTML("
      body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f9;
        color: #333;
      }
      .navbar {
        background-color: #5e412f;
        color: white;
      }
      .navbar a {
        color: white;
      }
      .navbar a:hover {
        background-color: #7d5a4d;
        color: white;
      }
      h3, h4 {
        color: #5e412f;
        font-weight: bold;
      }
      .container-fluid {
        padding: 30px;
      }
      .btn {
        background-color: #5e412f;
        color: white;
        border-radius: 5px;
      }
      .btn:hover {
        background-color: #7d5a4d;
      }
      .well {
        background-color: #f9f7f1;
        border: 1px solid #e0e0e0;
        padding: 20px;
      }
    "))
  ),
  
  navbarPage(
    title = "Chocolate Sales Dashboard",
    
    tabPanel("Group Details",
             fluidPage(
               h3("Group Members"),
               p("This project is developed by:"),
               tags$ul(
                 tags$li("Fatima 23F-0791"),
                 tags$li("Aiza Khurram 23F-0575"),
                 tags$li("Zainab Noor 23F-0545"),
                 tags$li("Ume Ammarah 23F-3034")
               ),
               hr(),
               h3("Project Overview"),
               p("This dashboard visualizes chocolate sales data, including descriptive statistics, bar charts, pie charts, and regression analysis.")
             )
    ),
    
    tabPanel("Description",
             fluidPage(
               h3("Data Description"),
               p("This dashboard is designed to visualize and analyze chocolate sales data through multiple statistical and graphical methods. It helps in understanding the sales trends, product performance, and provides insight into sales data patterns over time. The dashboard includes various sections like descriptive statistics, bar charts, pie charts, box plots, and regression analysis for a comprehensive analysis of the data."),
               br(),
               h4("Data Structure:"),
               tags$ul(
                 tags$li("Amount: The total sales amount in USD for each chocolate transaction."),
                 tags$li("Date: The date when the sale occurred."),
                 tags$li("Product: The name of the chocolate product sold."),
                 tags$li("Transaction ID: Unique identifier for each sale transaction (optional in the dataset).")
               ),
               br(),
               h4("Data Cleaning Process:"),
               tags$ul(
                 tags$li("Amount Formatting: The sales amount was cleaned by removing dollar signs ($) and commas (,), ensuring it's in numeric format for analysis."),
                 tags$li("Date Formatting: Dates were converted into the correct Date type format to facilitate time-based analysis."),
                 tags$li("Missing Values: Any missing or NA values in the data were either handled appropriately or removed to avoid any biases in the analysis.")
               ),
               br(),
               h4("Key Features of the Dashboard:"),
               tags$ul(
                 tags$li("Group Details: Provides an overview of the group members and their roles in the project."),
                 tags$li("Descriptive Statistics: Skimr package is used to provide summary statistics such as the mean, median, standard deviation, and quantiles of the Amount variable."),
                 tags$li("Sales Visualizations:"),
                 tags$ul(
                   tags$li("Bar Chart: Displays the top 5 best-selling products based on total sales."),
                   tags$li("Pie Chart: Visualizes the sales distribution of the top 5 products in a percentage format."),
                   tags$li("Box Plot: Shows the distribution and spread of the Amount values, helping identify outliers and data variability."),
                   tags$li("Distribution Plot: Plots the density of the sales amounts and overlays a normal distribution curve to assess the distribution pattern.")
                 ),
                 tags$li("Regression Analysis:"),
                 tags$ul(
                   tags$li("Linear Regression Model: A simple linear regression model is built to analyze the relationship between sales (Amount) and time (Date), with a regression plot to visualize the trend over time.")
                 )
               ),
               br(),
               h4("Data Analysis Insights:"),
               tags$ul(
                 tags$li("Top 5 Best-Selling Products: The bar chart section highlights which chocolate products have the highest sales, allowing users to quickly see which products dominate the market."),
                 tags$li("Sales Trends Over Time: The regression analysis section investigates whether sales amounts have a trend over time. By plotting this data, you can explore whether sales are increasing, decreasing, or stable over the period."),
                 tags$li("Sales Distribution: The distribution and box plot give an understanding of how sales amounts are distributed across all transactions, showing potential skewness or outliers in the data."),
                 tags$li("Confidence Interval for Sales Amount: A confidence interval is calculated to estimate the range within which the true mean of the sales amount lies, offering statistical reliability for decision-making.")
               ),
               br(),
               h4("User Interface Layout:"),
               tags$ul(
                 tags$li("Navbar: Located at the top of the page, the navbar has links for different sections of the dashboard, including group details, description, and various data visualizations."),
                 tags$li("Group Details Section: Provides information about the project team members and a brief introduction to the project."),
                 tags$li("Description Section: Explains the dataset, the data cleaning process, and the purpose of each analysis performed."),
                 tags$li("Sales Data & Charts: This section includes all charts, graphs, and tables, with a clear structure and well-defined sections separated by dividers (hr()), making it easy for users to navigate through the dashboard.")
               ),
               br(),
               h4("Potential Applications:"),
               tags$ul(
                 tags$li("Business Insights: By analyzing the sales trends and top-performing products, businesses can make informed decisions about which products to promote and which may need improvement."),
                 tags$li("Forecasting: With regression models and analysis of trends over time, companies can predict future sales and adjust their strategies accordingly."),
                 tags$li("Identifying Market Gaps: The sales distribution analysis helps identify any underperforming products, potential opportunities for product improvement, or marketing strategies.")
               ),
               hr()
             )
    ),
    
    tabPanel("Sales Data 1: Top 5 & Distribution",
             fluidPage(
               fluidRow(
                 column(12, h4("Top 5 Best-Selling Products")),
                 column(12, plotOutput("barChart"))
               ),
               hr(),
               fluidRow(
                 column(12, h4("Sales Distribution of Top 5 Products")),
                 column(12, plotOutput("pieChart"))
               ),
               hr(),
               fluidRow(
                 column(12, h4("Distribution of Sales Amount")),
                 column(12, plotOutput("distPlot"))
               ),
               hr()
             )
    ),
    
    tabPanel("Sales Data 2: Box Plot, Stats & Regression",
             fluidPage(
               fluidRow(
                 column(12, h4("Boxplot of Amount")),
                 column(12, plotOutput("boxPlot"))
               ),
               hr(),
               fluidRow(
                 column(12, h4("Descriptive Stats")),
                 column(12, DT::dataTableOutput("descStats"))
               ),
               hr(),
               fluidRow(
                 column(12, h4("Regression Summary: Sales vs Date")),
                 column(12, verbatimTextOutput("regressionSummary"))
               ),
               hr(),
               fluidRow(
                 column(12, h4("Regression Plot")),
                 column(12, plotOutput("regPlot"))
               )
             )
    )
  )
)

# Server logic
server <- function(input, output) {
  
  # Bar chart
  output$barChart <- renderPlot({
    ggplot(top_5_sales, aes(x = reorder(Product, Total_Sales), y = Total_Sales, fill = Product)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Top 5 Best-Selling Products", x = "Product", y = "Total Sales") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1), 
            plot.title = element_text(face = "bold", size = 16),
            axis.title = element_text(size = 14),
            axis.text = element_text(size = 12))
  })

  # Pie chart
  output$pieChart <- renderPlot({
    pie_data <- top_5_sales %>% 
      mutate(Percent = Total_Sales / sum(Total_Sales) * 100)
    
    ggplot(pie_data, aes(x = "", y = Percent, fill = Product)) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y") +
      theme_void() +
      labs(title = "Sales Distribution of Top 5 Products") +
      theme(plot.title = element_text(face = "bold", size = 16))
  })

  # Box plot
  output$boxPlot <- renderPlot({
    ggplot(data, aes(x = Product, y = Amount)) +
      geom_boxplot(fill = "#7d5a4d", color = "#5e412f") +
      theme_minimal() +
      labs(title = "Boxplot of Amount by Product", x = "Product", y = "Amount") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1), 
            plot.title = element_text(face = "bold", size = 16),
            axis.title = element_text(size = 14),
            axis.text = element_text(size = 12))
  })

  # Descriptive stats
  output$descStats <- DT::renderDataTable({
    skimr::skim(data) %>% 
      filter(skim_type == "numeric") %>% 
      select(skim_variable, numeric.mean, numeric.sd, numeric.p0, numeric.p50, numeric.p100)
  }, options = list(dom = 't'))

  # Regression summary (clean format using broom)
  output$regressionSummary <- renderPrint({
    model <- lm(Amount ~ NumericDate, data = data)
    broom::tidy(model)
  })

  # Regression plot with equation
  # Regression plot with refined equation and R-squared
output$regPlot <- renderPlot({
  model <- lm(Amount ~ NumericDate, data = data)
  intercept <- coef(model)[1]
  slope <- coef(model)[2]
  r_squared <- summary(model)$r.squared
  
  eq <- bquote(italic(y) == .(round(slope, 2)) %.% italic(x) + .(round(intercept, 2)) ~ "," ~ R^2 == .(round(r_squared, 3)))
  
  ggplot(data, aes(x = Date, y = Amount)) +
    geom_point(alpha = 0.6, color = "#5e412f") +
    geom_smooth(method = "lm", color = "#7d5a4d", fill = "#c57f6a", se = TRUE) +
    annotate("text", x = min(data$Date, na.rm = TRUE), 
             y = max(data$Amount, na.rm = TRUE), 
             label = as.expression(eq), 
             hjust = 0, vjust = 1.2, size = 5, color = "darkred") +
    labs(
      title = "Linear Regression: Sales Amount Over Time",
      x = "Date",
      y = "Sales Amount (USD)"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 16),
      axis.title = element_text(size = 14),
      axis.text = element_text(size = 12)
    )
})


  # Distribution plot
  output$distPlot <- renderPlot({
    ggplot(data, aes(x = Amount)) +
      geom_histogram(aes(y = ..density..), bins = 30, fill = "#7d5a4d", color = "#5e412f") +
      stat_function(fun = dnorm,
                    args = list(mean = mean(data$Amount, na.rm = TRUE),
                                sd = sd(data$Amount, na.rm = TRUE)),
                    col = "red", size = 1.2) +
      theme_minimal() +
      labs(title = "Normal Distribution Fit to Sales Amount", x = "Amount", y = "Density")
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)