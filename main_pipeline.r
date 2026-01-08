# ==============================================================================
# NHL Performance Forecasting: Master Research Pipeline
# ==============================================================================

library(httr)
library(jsonlite)
library(aws.s3)
library(dplyr)
library(randomForest)

# --- 1. CONFIGURATION ---
# Security: Pulling keys from local .Renviron instead of hardcoding
# Sys.setenv("AWS_ACCESS_KEY_ID" = "REDACTED", "AWS_SECRET_ACCESS_KEY" = "REDACTED")

# --- 2. INGESTION (API to AWS S3) ---
# Fetching standings data for the 'Salary Cap Era'
seasons <- list("20052006" = "2006-04-18", "20232024" = "2024-04-18")

for (season_code in names(seasons)) {
  url <- sprintf("https://api-web.nhle.com/v1/standings/%s", seasons[[season_code]])
  res <- GET(url)
  if (status_code(res) == 200) {
    # Send raw JSON to S3 for archival
    put_object(file = content(res, as = "text"), 
               object = paste0("standings_", season_code, ".json"), 
               bucket = "nhld610")
  }
}

# --- 3. DATA CLEANING & TRANSFORMATION ---
# Flattening JSON and handling franchise relocations (e.g., Arizona -> Utah)
# Excluding structural breaks (2012 Lockout, 2020 COVID)
process_data <- function(df) {
  df %>%
    filter(!seasonId %in% c('20122013', '20192020', '20202021')) %>%
    mutate(teamName = ifelse(teamName == "Arizona Coyotes", "Utah Mammoth", teamName)) %>%
    select(points, goalDifferential, wins, losses, otLosses)
}

# --- 4. PREDICTIVE MODELING ---
# Using Random Forest to analyze parity-era data
# ntree = 500 as specified in the Capstone Report
rf_model <- randomForest(points ~ ., data = processed_train_data, ntree = 500)

# --- 5. RESULTS ---
# Comparing predictions vs. actuals (e.g., Boston/Winnipeg analysis)
print(importance(rf_model))
