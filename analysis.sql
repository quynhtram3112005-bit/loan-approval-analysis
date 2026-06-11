SELECT
CASE
    WHEN LoanApproved = 1 THEN 'Approved'
    ELSE 'Declined'
END AS approval_status,
count(*) as total_applicants,
round(AVG(Age), 2) as avg_age,
round(AVG(AnnualIncome), 2) as avg_income,
round(AVG(TotalAssets), 2) as avg_assets,
round(AVG(TotalLiabilities), 2) as avg_liabilities,
round(AVG(SavingsAccountBalance), 2) as avg_savings_balance,
round(AVG(JobTenure), 2) as avg_job_tenure,
round(AVG(TotalDebtToIncomeRatio), 2) as avg_debt_to_income_ratio

FROM loan_data
GROUP BY 1
ORDER BY 1;

/* ==========================================
SECTION 1: APPROVAL OVERVIEW
Business question: What is the overall approval rate?
========================================== */
SELECT
COUNT (*) AS total_applicants,
ROUND (AVG(LoanApproved) * 100, 2) AS approval_rate
FROM loan_data;

-- Ty le duoc phe duyet chi dat 23.9% cho thay co rat nhieu ung vien bi tu choi vay. 
-- Do do, can phai xem xet ky hon cac yeu to lien quan den ho so vay va tinh cach cua ung vien de nang cao ty le duoc phe duyet.



/* ==========================================
SECTION 2: WHICH GROUPS ARE MORE LIKELY TO BE APPROVED?
Business question 1: Education Level
========================================== */
SELECT
EducationLevel,
COUNT (*) AS applicants,
ROUND (AVG(LoanApproved) * 100, 2) as approved_rate
FROM loan_data
GROUP BY EducationLevel; 

-- Groups with high education level have a significantly higher approval rate (Master or PhD with 44.03% and 35.08%) compared to those with lower education levels (High School or less with 14.44%). This suggests that lenders may perceive higher education as an indicator of financial stability and creditworthiness, leading to a higher likelihood of loan approval for applicants with advanced degrees.
-- The number of applicants with Bachelor degrees is the highest, but their approval rate is relatively low at 23.9%. Maybe other factors such as income, job tenure, or debt-to-income ratio are infulencing the approval rates for this group. 


/* ==========================================
Business question 2: Employment Status
========================================== */
SELECT
EmploymentStatus,
COUNT (*) AS applicants,
ROUND (AVG(LoanApproved) * 100, 2) as approved_rate
FROM loan_data
GROUP BY EmploymentStatus;

-- Employed group takes the largest portion of applicants (17036 applicants) but the the highest approval rate is for the self-employed group (27.84%). 
-- This may be because self-employed individuals often have more flexible income sources and may be perceived as more financially stable by lenders.
-- On the other hand, unemployed applicants have the lowest approval rate (18.19%), which is expected as they may lack a steady income to repay the loan. 

/* ==========================================
Business question 3: Marital Status
========================================== */
SELECT
MaritalStatus,
COUNT (*) AS applicants,
ROUND (AVG(LoanApproved) * 100, 2) as approved_rate
FROM loan_data
GROUP BY MaritalStatus;

-- all the groups have similar approval rates (around 22-25%), indicating that marital status may not be a significant factor in loan approval dicisions

/* ==========================================
Business question 4: Home Ownership
========================================== */
SELECT
HomeOwnershipStatus,
COUNT (*) AS applicants,
ROUND (AVG(LoanApproved) * 100, 2) as approved_rate
FROM loan_data
GROUP BY HomeOwnershipStatus;

-- surprisingly that mortgage group has the highest approval rate (25,15%) compared to homeowners (24.89%). 
-- this may need futher analysis to understand the underlying reasons, such as the financial profiles of applicants in each group or the specific criteria lenders use for mortgage applicants.

SELECT
    HomeOwnershipStatus,
    COUNT (*) AS applicants,
    ROUND (AVG(LoanApproved) * 100,2) AS approved_rate,
    ROUND (AVG(AnnualIncome),2) AS avg_income,
    ROUND (AVG(CreditScore),2) AS avg_credit_score,
    ROUND (AVG(DebtToIncomeRatio) * 100,2) AS avg_debt_to_income_ratio
FROM loan_data
GROUP BY HomeOwnershipStatus;

-- In conclusion, home ownership status exhibits only a modest relationship with loan approval rates.
-- Other groups, key financial indicators such as income, credit score, and debt-to-income ratio remain remarkably similar across all categories




/* ==========================================
SECTION 3: CREDIT RISK SEGMENTATION
Business question: How does credit score affect loan approval rates?
========================================== */

SELECT
    MIN(CAST(CreditScore AS REAL)) AS min_score,
    MAX(CAST(CreditScore AS REAL)) AS max_score,
    AVG(CAST(CreditScore AS REAL)) AS avg_score
FROM loan_data;

SELECT
CASE 
    WHEN CreditScore < 500 THEN '<500'
    WHEN CreditScore < 600 THEN '500-599'
    WHEN CreditScore < 700 THEN '600-699'
    WHEN CreditScore < 800 THEN '700-799'
    ELSE '800+'
END AS score_band,
COUNT(*) AS applicants,

    SUM(CAST(LoanApproved AS INTEGER)) AS approved,

    ROUND(
        SUM(CAST(LoanApproved AS REAL))*100.0
        / COUNT(*),
        2
    ) AS approval_rate

FROM loan_data
GROUP by score_band
ORDER BY score_band;

-- the majority of applicants have credit socre below 700
-- loan approval rates increase siginificantly with credit score, with applicants with score above 700 demonstrate much higher approval rates (66.67%), but only a small portion of applicants (0.03%) have this range of credit score. 
-- this suggests that lenders heavily rely on credit scores as a key factor in loan approval decisions, and applicants with higher credit scores are more likely to be approved for loans.



/* ==========================================
SECTION 4: FINANCIAL STRENGTH ANALYSIS
Business question: How do financial indicators differ between approved and declined applicants?
========================================== */

SELECT
CASE
    WHEN LoanApproved = 1 THEN 'Approved'
    ELSE 'Declined'
END AS approval_status,
round(AVG(AnnualIncome), 2) as avg_income,
round(AVG(TotalAssets), 2) as avg_assets,
round(AVG(TotalLiabilities), 2) as avg_liabilities,
round(AVG(SavingsAccountBalance), 2) as avg_savings_balance,
round(AVG(TotalDebtToIncomeRatio), 2) as avg_debt_to_income_ratio
FROM loan_data
GROUP BY 1
ORDER BY 1; 

-- Approved applicants have significantly higher financial indicators compared to declined applicants, demonstrating that financial strengh is a crucial factor in loan approval decisions. 
-- More importantly, income and debt-to-income ratio show the largest differences between the two groups, suggesting that lenders may place a strong emphasis on these indicators when evaluating loan applications. 

/* Total debt-to-income Analysis */

SELECT
    round(MIN(CAST(TotalDebtToIncomeRatio AS REAL))*100,3) AS min_ratio,
    round(MAX(CAST(TotalDebtToIncomeRatio AS REAL))*100,3) AS max_ratio,
    round(AVG(CAST(TotalDebtToIncomeRatio AS REAL))*100,3) AS avg_ratio
FROM loan_data;


SELECT
CASE
    when TotalDebtToIncomeRatio < 0.2 then '0%-20%'
    when TotalDebtToIncomeRatio < 0.5 then '20%-50%'
    when TotalDebtToIncomeRatio < 1 then '50%-100%'
    else '>100%'
END AS dti_band,
COUNT(*) AS applicants,

    SUM(CAST(LoanApproved AS INTEGER)) AS approved,

    ROUND(
        SUM(CAST(LoanApproved AS REAL))*100.0
        / COUNT(*),
        2
    ) AS approval_rate

FROM loan_data
GROUP by dti_band
ORDER BY dti_band;

-- debt-to-income ratio appears to be a strong predictor of loan approval outcomes.
-- approval rates decline dramatically as debt burdens increase, falling from 63.15% among applicants with DTI below 20% to only 0.09% among people with DTI above 100%


/* Annual Income Analysis */
SELECT
    MIN(CAST(AnnualIncome AS REAL)) AS min_income,
    MAX(CAST(AnnualIncome AS REAL)) AS max_income,
    AVG(CAST(AnnualIncome AS REAL)) AS avg_income
FROM loan_data;

SELECT
    CASE
        WHEN CAST(AnnualIncome AS REAL) < 30000 THEN '0K-30K'
        WHEN CAST(AnnualIncome AS REAL) < 50000 THEN '30K-50K'
        WHEN CAST(AnnualIncome AS REAL) < 70000 THEN '50K-70K'
        ELSE '>70K'
    END AS income_band,

    COUNT(*) AS applicants,

    SUM(CAST(LoanApproved AS INTEGER)) AS approved,

    ROUND(
        SUM(CAST(LoanApproved AS REAL))*100.0
        / COUNT(*),
        2
    ) AS approval_rate

FROM loan_data

GROUP BY income_band;

-- higher income levels are associated with significantly higher approval rates for loans (46.29%)
-- applicants with income above 70K have a 72 times higher approval rate compared to those with low income (0-30K)
-- this highlights the importance of income as a key factor in loan approval decisions, and suggests that lenders may prioritize applicants with higher earning potential when evaluating loan applications.


/* ==========================================
SECTION 5: LOAN PURPOSE ANALYSIS
Business question: How does loan purpose affect approval rates?
========================================== */   

SELECT
LoanPurpose,
COUNT(*) AS applicants,
SUM(CAST(LoanApproved AS INTEGER)) AS approved,
ROUND(
    SUM(CAST(LoanApproved AS REAL))*100.0
    / COUNT(*),
    2
) AS approval_rate
FROM loan_data
GROUP BY LoanPurpose;

-- the most common loan purpose is home improvement, followed by debt consolidation and auto purchase.
-- there is hardly any difference in approval rates across different loan purposes, suggesting that loan purpose may not be a significant factor in loan approval decisions.



/* ==========================================
SECTION 6: BUILD CUSTOMER PERSONAS
Business question: What are the characteristics of different customer segments based on loan approval status?
========================================== */   

/* PERSONA 1: PRIME BORROWERS
- Debt-to-income ratio: <20%
- Annual income: >70K

PERSONA 2: EMERGING BORROWERS
- Debt-to-income ratio: <50%
- Annual income: >=50K

PERSONA 3: HIGH-RISK BORROWERS
- Debt-to-income ratio: >50%
- Annual income: <50K

*/

SELECT
    CASE
        WHEN CAST(AnnualIncome AS REAL) > 70000
             AND CAST(TotalDebtToIncomeRatio AS REAL) < 0.2
        THEN 'Prime Borrowers'

        WHEN CAST(AnnualIncome AS REAL) >= 50000
             AND CAST(TotalDebtToIncomeRatio AS REAL) < 0.5
        THEN 'Emerging Borrowers'

        WHEN CAST(AnnualIncome AS REAL) < 50000
             AND CAST(TotalDebtToIncomeRatio AS REAL) >= 0.5
        THEN 'High-Risk Borrowers'

        ELSE 'Other Applicants'
    END AS persona,

COUNT(*) AS applicants,
SUM(CAST(LoanApproved AS INTEGER)) AS approved,
ROUND(
    SUM(CAST(LoanApproved AS REAL))*100.0
    / COUNT(*),
    2
) AS approval_rate

FROM loan_data

GROUP BY persona
ORDER BY approval_rate DESC;


SELECT
    CASE
        WHEN AnnualIncome < 50000 THEN '<50K'
        WHEN AnnualIncome < 70000 THEN '50K-70K'
        ELSE '>70K'
    END AS income_band,

    CASE
        WHEN TotalDebtToIncomeRatio < 0.2 THEN '<20%'
        WHEN TotalDebtToIncomeRatio < 0.5 THEN '20%-50%'
        ELSE '>50%'
    END AS dti_band,

    COUNT(*) AS applicants,

    ROUND(
        AVG(LoanApproved)*100,
        2
    ) AS approval_rate

FROM loan_data

GROUP BY 1,2;


