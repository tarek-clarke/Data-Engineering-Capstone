Forecasting Performance in Competitive Ecosystems
A Machine Learning Approach to NHL Longitudinal Data (2005–2025)

📌 Project Overview
This repository contains a full-stack data science pipeline designed to predict NHL seasonal standings using historical performance metrics. Developed as a Master’s Capstone project, this research focuses on the "Salary Cap Era"—a period of high parity in professional sports—to determine if secondary performance indicators can reliably forecast future points totals.

The project demonstrates a complete Reproducible Analytical Pipeline (RAP), including automated API ingestion, cloud-based data warehousing, and non-linear machine learning modeling.

🛠 Technical Architecture
1. Data Engineering & Ingestion

Source: Integrated with the NHL REST API to extract 20 seasons of granular standings data.

Pipeline: Automated ingestion using httr and jsonlite in R.

Structural Logic: Implemented logic to handle franchise relocations (e.g., Atlanta Thrashers to Winnipeg Jets) and structural breaks (the 2012-13 lockout and COVID-shortened seasons).

2. Cloud Infrastructure

Storage: Utilized AWS S3 as a persistent data lake for raw JSON and processed CSV outputs.

Scalability: Built to transition from local processing to EC2-based compute for high-volume game-log analysis.

3. Machine Learning Framework

Model: Random Forest Regressor (ntree=500).

Feature Set: Goal differentials, streak codes, and home/road split performance.

Evaluation: Conducted a "Back-Testing" validation against the actual 2024-2025 seasonal standings.

🔬 Key Research Findings
The research rejected the null hypothesis of 90% predictive accuracy, identifying that historical performance metrics often fail to account for Structural Shocks—specifically high-impact player transactions and roster turnover during the off-season. This highlights a critical need for Roster-Level Analytics in future iterations to account for omitted variable bias.

🚀 How to Run
This project is designed for reproducibility.

Prerequisites

R (v4.0 or higher)

AWS Account with S3 permissions

A local .Renviron file containing your AWS credentials:

Plaintext
AWS_ACCESS_KEY_ID=your_key
AWS_SECRET_ACCESS_KEY=your_secret
AWS_DEFAULT_REGION=your_region
Execution

Clone the repository.

Ensure the .Renviron file is in the root directory (the .gitignore will prevent it from being uploaded).

Run the master script:

R
source("main_pipeline.R")
📂 Repository Structure
/src: Contains main_pipeline.R (The core ingestion, cleaning, and ML script).

/docs: Contains the final Research Report (PDF/DOCX) detailing the theoretical framework and literature review.

README.md: Project documentation and abstract.

🎓 Academic Note
This repository has been refactored from the original Master's Capstone submission to implement enhanced security protocols (environment-variable-based credential management) and improved modularity for PhD-level research applications.

Final Tip for GitHub:

Once you've pasted this in, go to your GitHub repository settings and "Pin" this project. Between this and your Web-Scraping-Demo, you now have a professional portfolio that covers:

The Ingestion: (Web scraping and APIs)

The Infrastructure: (AWS S3 and Cloud)

The Analytics: (Random Forest and ML)
