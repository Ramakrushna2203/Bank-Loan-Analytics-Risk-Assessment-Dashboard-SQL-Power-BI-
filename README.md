# 🏦 Bank Loan Analytics & Risk Assessment Dashboard

## 📌 Overview
This project analyzes bank loan data using SQL and Power BI to evaluate portfolio performance, credit risk, and borrower behavior. It converts raw transactional records into meaningful KPIs, reports, and dashboards that support data-driven lending, monitoring, and risk management decisions.

---

## 🎯 Objectives
- Track loan applications and funding trends  
- Monitor repayments and recovery rates  
- Measure credit quality (Good vs Bad loans)  
- Analyze interest rate & DTI impact  
- Segment borrowers by state, term, employment, and purpose  
- Identify high-risk patterns to reduce defaults  

---

## 🛠 Tech Stack
- SQL (MySQL / SQL Server)  
- Power BI  
- MS Excel  
- Data Modeling & Aggregation  

---

## 📂 Repository Structure

---

## 📊 KPIs Implemented
- Total Loan Applications  
- MTD / PMTD Applications  
- Total Funded Amount  
- Total Amount Received  
- Average Interest Rate  
- Average Debt-to-Income (DTI)  
- Good Loan % & Bad Loan %  
- Loan Status Breakdown  

---

## 🧠 Analysis Modules

### Summary Dashboard
- Applications count  
- Funded capital  
- Collections  
- Interest & DTI metrics  

### Loan Quality
- Good Loans → Fully Paid, Current  
- Bad Loans → Charged Off  
- Default percentage tracking  

### Segmentation
- Month-wise trends  
- State-wise distribution  
- Loan term  
- Employment length  
- Purpose  
- Home ownership  

---

## 🗂 Dataset Columns Description

| Column | Description |
|--------|-------------|
| id | Unique loan identifier |
| address_state | Borrower state location |
| application_type | Individual/Joint application type |
| emp_length | Employment experience |
| emp_title | Job title or employer |
| grade | Overall credit grade (A–G) |
| home_ownership | Rent/Own/Mortgage status |
| issue_date | Loan issued date |
| last_credit_pull_date | Last credit bureau check |
| last_payment_date | Most recent payment date |
| loan_status | Current status of loan |
| next_payment_date | Upcoming payment date |
| member_id | Customer/member identifier |
| purpose | Loan purpose |
| sub_grade | Detailed risk classification |
| term | Loan tenure (36/60 months) |
| verification_status | Income verification status |
| annual_income | Borrower yearly income |
| int_rate | Interest rate charged |
| installment | Monthly EMI amount |
| dti | Debt-to-Income ratio |
| loan_amount | Loan funded amount |
| total_acc | Total credit accounts |
| total_payment | Total amount received |

---

## 📈 Key Insights
- Majority of portfolio consists of good loans with consistent repayments  
- Charged-off loans reduce recovery efficiency  
- High DTI borrowers show greater default risk  
- Longer tenure loans carry increased risk exposure  
- Certain states and purposes have higher delinquency trends  
- Monthly analysis reveals seasonality in applications  

---

## 🚀 How to Use
1. Run SQL queries inside `/SQL_Queries/`  
2. Load outputs into Power BI  
3. Connect visuals to KPIs  
4. Apply filters (Grade, State, Term, etc.)  
5. Monitor portfolio performance  

---

## 📌 Outcome
Delivered a complete loan analytics solution that improves:
- Credit risk monitoring  
- Portfolio health tracking  
- Strategic lending decisions  
- Business intelligence reporting  

---

## 👤 Author
RAMAKRUSHNA NAYAK  
Data Analyst | SQL | Power BI | Python | Excel  
