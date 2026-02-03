# 🏦 Bank Loan Analytics & Risk Assessment Project

## 📌 Overview
End-to-end Loan Portfolio Analytics project using **SQL + Power BI + Excel** to monitor loan performance, funding, repayments, and credit risk.

The project transforms raw banking data into **KPIs, SQL reports, and interactive dashboards** to help stakeholders track:
- Applications
- Funded Amount
- Collections
- Interest trends
- Good vs Bad loans
- Risk segmentation

---

# 🛠 Tech Stack
SQL (MySQL)  
Power BI (Power Query + DAX)  
Excel  
Data Cleaning  
Dashboarding  

---

# 🔄 Steps Involved

1. Data Cleaning  
   - Removed nulls & inconsistencies  
   - Standardized categories  
   - Fixed formats  

2. Datatype Conversion  
   - Converted string → DATE  
   - Validated numeric fields  

3. SQL Analysis  
   - KPIs  
   - Aggregations  
   - MoM growth  
   - Risk segmentation  

4. Power BI  
   - Power Query transformations  
   - DAX measures  
   - Data modeling  
   - Interactive dashboards  

5. Insights & Reporting  

---

# 📂 Dataset Column Description

| Column | Description |
|-------|-------------|
| id | Unique loan ID |
| address_state | Borrower state |
| application_type | Individual/Joint |
| emp_length | Employment tenure |
| emp_title | Employer name |
| grade | Loan credit grade |
| home_ownership | Rent/Own/Mortgage |
| issue_date | Loan issue date |
| last_credit_pull_date | Last bureau check |
| last_payment_date | Last paid date |
| next_payment_date | Upcoming payment |
| loan_status | Fully Paid / Current / Charged Off |
| member_id | Borrower ID |
| purpose | Loan purpose |
| sub_grade | Risk sub category |
| term | Loan tenure |
| verification_status | Income verified or not |
| annual_income | Income of borrower |
| int_rate | Interest rate |
| installment | EMI amount |
| dti | Debt-to-Income ratio |
| loan_amount | Loan funded |
| total_acc | Total accounts |
| total_payment | Amount collected |

---

# 🧠 Complete SQL Code (All Queries)

```sql
SELECT * FROM bank_loan_data;
DESC bank_loan_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE bank_loan_data SET issue_date = STR_TO_DATE(issue_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data MODIFY issue_date DATE;

UPDATE bank_loan_data SET last_credit_pull_date = STR_TO_DATE(last_credit_pull_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data MODIFY last_credit_pull_date DATE;

UPDATE bank_loan_data SET last_payment_date = STR_TO_DATE(last_payment_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data MODIFY last_payment_date DATE;

UPDATE bank_loan_data SET next_payment_date = STR_TO_DATE(next_payment_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data MODIFY next_payment_date DATE;

-- TOTAL APPLICATIONS
SELECT COUNT(*) AS total_loan_application FROM bank_loan_data;

-- MTD APPLICATIONS
SELECT COUNT(id)
FROM bank_loan_data
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

-- MOM GROWTH
SELECT
COUNT(CASE WHEN issue_date >= '2021-12-01' AND issue_date < '2022-01-01' THEN 1 END) AS MTD_Total,
COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END) AS PMTD_Total,
ROUND((
COUNT(CASE WHEN issue_date >= '2021-12-01' AND issue_date < '2022-01-01' THEN 1 END) -
COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END))
/ NULLIF(COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END),0)*100,2) AS MoM_Growth_Percent
FROM bank_loan_data;

-- TOTAL FUNDED
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

SELECT SUM(loan_amount)
FROM bank_loan_data
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

SELECT SUM(loan_amount)
FROM bank_loan_data
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

-- TOTAL RECEIVED
SELECT SUM(total_payment) FROM bank_loan_data;

SELECT SUM(total_payment)
FROM bank_loan_data
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

SELECT SUM(total_payment)
FROM bank_loan_data
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

-- AVG INTEREST
SELECT AVG(int_rate)*100 FROM bank_loan_data;

-- AVG DTI
SELECT AVG(dti)*100 FROM bank_loan_data;

-- GOOD LOANS
SELECT COUNT(id)
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');

SELECT SUM(loan_amount)
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');

SELECT SUM(total_payment)
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');

-- BAD LOANS
SELECT COUNT(id)
FROM bank_loan_data
WHERE loan_status='Charged Off';

SELECT SUM(loan_amount)
FROM bank_loan_data
WHERE loan_status='Charged Off';

SELECT SUM(total_payment)
FROM bank_loan_data
WHERE loan_status='Charged Off';

-- LOAN STATUS SUMMARY
SELECT
loan_status,
COUNT(id),
SUM(total_payment),
SUM(loan_amount),
AVG(int_rate*100),
AVG(dti*100)
FROM bank_loan_data
GROUP BY loan_status;

-- MONTHWISE
SELECT
MONTH(issue_date),
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY MONTH(issue_date);

-- STATEWISE
SELECT address_state,
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY address_state;

-- TERM
SELECT term,
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY term;

-- EMP LENGTH
SELECT emp_length,
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY emp_length;

-- PURPOSE
SELECT purpose,
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY purpose;

-- HOME OWNERSHIP
SELECT home_ownership,
COUNT(id),
SUM(loan_amount),
SUM(total_payment)
FROM bank_loan_data
GROUP BY home_ownership;
```

---

# 📈 Insights
- Majority loans are fully paid
- Charged-off loans impact recovery rate
- Higher DTI increases default probability
- Longer tenure loans show higher risk
- State & purpose affect loan behavior

---

# 🚀 Business Impact
✔ Portfolio monitoring  
✔ Risk reduction  
✔ Better lending decisions  
✔ Automated reporting  

---

# 👤 RAMAKRUSHNA NAYAK
Data Analyst | SQL | Power BI | Python | Excel
 
