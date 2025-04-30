
# Chocolate Sales Data Analysis and Shiny Dashboard

This project is focused on analyzing chocolate sales data and developing a Shiny dashboard for visualizing key insights. The dashboard allows users to interactively explore patterns in chocolate sales, visualize the data, and understand statistical findings like regression models, confidence intervals, and more.

---

### Group Partners
- Fatima 23F-0791
- Zainab 23F-0545
- Ume Ammarah 23F-3034

---

## Project Features

- **Data Analysis**:
  - Descriptive statistics summarizing key sales metrics (e.g., average sales, maximum, minimum)
  - Confidence intervals and probability distributions to better understand sales patterns
  - Regression modeling to predict future trends

- **Shiny Dashboard**:
  - Interactive visualizations:
    - **Bar Charts**: Showing sales performance by category or time period
    - **Pie Charts**: Visualizing sales distribution across different segments
    - **Box Plots**: Exploring the spread and outliers in the sales data
    - **Regression Plots**: Visualizing predicted sales trends over time
  - User-friendly interface to interact with and filter data
  - Dynamic displays of key statistics and visualizations

## Technologies Used

- **R**: For statistical analysis and building the Shiny app
- **Shiny**: Framework for creating interactive web applications
- **ggplot2**: For creating advanced and visually appealing data visualizations
- **dplyr**: For data manipulation and cleaning
- **tidyr**: For tidying and structuring the dataset for analysis
- **readr**: For reading CSV files into R

## Getting Started

### Prerequisites

Make sure you have the following installed:

- **R**: You can download R from [here](https://cran.r-project.org/)
- **VSCode**: Download from [here](https://code.visualstudio.com/)

### Steps to Run the Project Locally

1. **Clone this repository** to your local machine:

   ```bash
   git clone https://github.com/your-username/chocolate-sales-dashboard.git
   ```

2. **Install required R packages**. Open R or VsCode terminal and install the necessary packages by running:

   ```R
   install.packages(c('shiny', 'ggplot2', 'dplyr', 'tidyr', 'readr'))
   ```

3. **Open the project** in VSCode and navigate to the main app file `app.R`.

4. **Run the Shiny app** using this command:

   ```R
      Rscript index.r
   ```

5. **Interact with the dashboard**: The app should open in your web browser. You can now explore the chocolate sales data through interactive charts and statistical insights.

## Project Structure

- `app.R`: The main file containing the UI and server logic for the Shiny app.
- `Cleaned_Choclate_Sales.csv/`: A file, which includes the sales data used for analysis.
- `Rplots.pdf`: A pdf file containing the statistical analysis, data manipulation, and modeling.
- `README.md`: This file.


## Acknowledgements

- This project utilizes the Shiny framework, created by RStudio, for building interactive applications.
- Thanks to the R community and the developers of the libraries used in this project (`ggplot2`, `dplyr`, `tidyr`, `readr`).
- The data used for analysis is a sample of chocolate sales, and all visualizations and insights are based on this dataset.

## Contact

For questions or feedback, feel free to open an issue in the GitHub repository or contact me directly.


