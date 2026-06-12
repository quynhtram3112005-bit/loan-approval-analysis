
# Loan Approval Analysis

## Project Overview

This project analyzes loan application data to identify the key factors influencing loan approval decisions and uncover meaningful borrower segments.

Using SQL for data exploration and Power BI for visualization, the project aims to support data-driven lending decisions by identifying approval patterns, risk indicators, and customer personas.

## Business Problem

Loan approval is a critical process for financial institutions because it directly impacts both profitability and credit risk.

Approving high-risk applicants may increase default rates, while rejecting qualified borrowers may result in lost business opportunities.

This project addresses the following business questions:

* What factors have the strongest impact on loan approval decisions?
* Which customer segments have the highest approval potential?
* How can lenders improve approval efficiency while managing risk?


## Dataset

Source: [Financial Risk for Loan Approval Dataset](https://www.kaggle.com/datasets/lorenzozoppelletto/financial-risk-for-loan-approval)

* 20,000 loan applications
* 36 borrower and loan-related variables
* Target variable: `LoanApproved`

### Key Features Used

* Annual Income
* Total Debt-to-Income Ratio (DTI)
* Credit Score
* Home Ownership Status
* Employment Status
* Loan Purpose
* Education Level

## Tools Used

* SQL
* Power BI
* Excel

## Project Workflow

1. Data Cleaning & Validation
2. Exploratory Data Analysis (SQL)
3. Approval Driver Analysis
4. Customer Segmentation
5. Dashboard Development (Power BI)
6. Business Recommendations

## Dashboard Pages

### 1. Executive Overview
<img width="982" height="560" alt="image" src="https://github.com/user-attachments/assets/e080a80b-8ede-41aa-82f8-c92692fddafc" />
<img width="988" height="557" alt="image" src="https://github.com/user-attachments/assets/31832f50-0b21-41d9-b790-5a21f120780b" />


Provides a high-level summary of:

* Total Applicants
* Approved Applicants
* Approval Rate
* Average Income
* Average Credit Score
* Average Debt-to-Income Ratio

### 2. Approval Drivers
<img width="985" height="556" alt="image" src="https://github.com/user-attachments/assets/1097e200-74a0-451a-be55-5ec6cd047d53" />

Analyzes how loan approval rates vary across:

* Income Bands
* Debt-to-Income Ratio Bands
* Credit Score Bands

### 3. Customer Personas
<img width="985" height="559" alt="image" src="https://github.com/user-attachments/assets/819d63e3-975e-4c2d-9365-fdb62e2cfb90" />

Applicants were segmented into:

* Prime Borrowers
* Emerging Borrowers
* High-Risk Borrowers
* Other Applicants

## Key Findings

### Debt-to-Income Ratio is the Strongest Approval Driver

Approval rates decline dramatically as debt burden increases:

| DTI Band | Approval Rate |
| -------- | ------------- |
| <20%     | 63.15%        |
| 20%-50%  | 11.48%        |
| 50%-100% | 0.68%         |
| >100%    | 0.09%         |

### Higher Income Significantly Improves Approval Probability

Applicants earning more than $70K annually achieve an approval rate of 61.41%, compared to only 0.85% among applicants earning below $30K.

### Prime Borrowers Represent the Most Valuable Segment

* Approval Rate: 73.71%
* Average Income: $116,543

Prime Borrowers are nearly 194 times more likely to be approved than High-Risk Borrowers.

## Business Recommendations

* Prioritize low-DTI applicants through automated screening.
* Fast-track approval for high-income borrowers.
* Develop targeted products for Emerging Borrowers.
* Strengthen risk controls for High-Risk Borrowers.

## Repository Structure

```text
loan-approval-analysis
│
├── sql/
│   └── loan_analysis.sql
│
├── dashboard/
│   └── loan_dashboard.pbix
│
├── report/
│   └── Loan_Approval_Analysis_Report.pdf
│
├── images/
│   ├── overview.png
│   ├── approval_drivers.png
│   ├── customer_personas.png
│   └── recommendations.png
│
└── README.md
```

## Author

**Nguyen Thi Quynh Tram**

Investment Economics Student | Aspiring Data Analyst / Business Analyst

University of Economics Ho Chi Minh City (UEH)


