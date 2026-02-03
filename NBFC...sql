create database Rama;
use rama;
   
DESC FINANCIAL_LOAN;
SELECT count(*) FROM FINANCIAL_LOAN;
## renaming table
rename table FINANCIAL_LOAN TO bank_loan_data;
SELECT * FROM bank_loan_data;
  
## Backup
CREATE TABLE bank_loan_data_backup LIKE bank_loan_data;
INSERT INTO bank_loan_data_backup
SELECT * FROM bank_loan_data;

## Backup table
select * from bank_loan_data_backup;

# *******************************************************************************************************************************
select * from bank_loan_data;
desc bank_loan_data;

#changing Datatype of Date columns
SET SQL_SAFE_UPDATES = 0;

UPDATE bank_loan_data
SET issue_date = STR_TO_DATE(issue_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data MODIFY issue_date DATE;

UPDATE bank_loan_data
SET last_credit_pull_date = STR_TO_DATE(last_credit_pull_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data
MODIFY last_credit_pull_date DATE;

UPDATE bank_loan_data
SET last_payment_date = STR_TO_DATE(last_payment_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data
MODIFY last_payment_date DATE;

UPDATE bank_loan_data
SET next_payment_date = STR_TO_DATE(next_payment_date,'%d-%m-%Y');
ALTER TABLE bank_loan_data
MODIFY next_payment_date DATE;

#######################################################################################################################################
# KPI TRACKING
# 1  total loan application;
SELECT count(*) as total_loan_application from bank_loan_data;

# 2  MTD  total application
SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM bank_loan_data
WHERE  MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 ;
/*we have only 2021 data and upto dec  ..so ....otherwise we can use max here to get uptodate*/
/*MTD stands for Month-To-Date.
It means:
👉 from the 1st day of the current month up to today*/

# 3  MOM TOTAL APPLICATION
SELECT
COUNT(CASE WHEN MONTH(issue_date)=12 AND YEAR(issue_date)=2021 THEN 1 END) AS MTD_Total_Loan_Applications,
COUNT(CASE WHEN MONTH(issue_date)=11 AND YEAR(issue_date)=2021 THEN 1 END) AS PMTD_Total_Loan_Applications
FROM bank_loan_data;

SELECT
COUNT(CASE WHEN issue_date >= '2021-12-01' AND issue_date < '2022-01-01' THEN 1 END) AS MTD_Total,
COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END) AS PMTD_Total,
ROUND((
COUNT(CASE WHEN issue_date >= '2021-12-01' AND issue_date < '2022-01-01' THEN 1 END) -
COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END))
/NULLIF(COUNT(CASE WHEN issue_date >= '2021-11-01' AND issue_date < '2021-12-01' THEN 1 END),0)* 100, 2) AS MoM_Growth_Percent
FROM bank_loan_data;


## TOTAL FUNDED AMOUNT 
SELECT SUM(loan_amount) AS Total_Funded_Amount  FROM bank_loan_data;

-- Query 1: MTD Total Funded Amount (December 2021)
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Query 2: PMTD Total Funded Amount (November 2021)
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

# TOTAL AMOUNT RECEIVED
SELECT 
    SUM(total_payment) AS MTD_Total_Amount_received 
FROM bank_loan_data;
-- Query 1: Month-To-Date (MTD) Total Amount Received for December 2021
SELECT SUM(total_payment) AS MTD_Total_Amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Query 2: Previous Month-To-Date (PMTD) Total Amount Received for November 2021
SELECT SUM(total_payment) AS PMTD_Total_Amount_received 
FROM bank_loan_data WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

#  AVG INTRST RATE
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate FROM bank_loan_data;

SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


# DTI 
SELECT 
    ROUND(AVG(dti), 4) * 100 AS MTD_Avg_DTI ;
SELECT 
    ROUND(AVG(dti), 4) * 100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT 
    ROUND(AVG(dti), 4) * 100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

# GOOD LOAN COUNT AND % OUT OF TOTAL
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
    /
    COUNT(id) AS Good_loan_percentage
FROM bank_loan_data;

# GOOD LOAN FUNDED AMOUNT
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

# Good_Loan_Recieved_amount 
SELECT SUM(total_payment) AS Good_Loan_Recieved_amount 
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

# BAD LOAN APPLICATION COUNT &   % OF PEOPLE
SELECT count(ID) AS Bad_Loan_APPLICATIONS
FROM bank_loan_data
WHERE loan_status = 'Charged Off';
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

 # Bad_Loan_Funded_amount 
 SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

# Bad_Loan_RECEIVED_amount
 SELECT SUM(total_payment) AS Bad_Loan_RECEIVED_amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

# lOAN STSTUS DETAILS
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status;
    
# LOAN STATUS MTD VS TOTAL FUND GIVEN AND RECEIVED
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

# MONTH WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
SELECT 
    MONTH(issue_date) AS Month_Number,
    MONTHNAME(issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

# STATE WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
 SELECT 
    address_state, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(loan_amount) AS Total_Funded_Amount, 
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

# TERM WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
SELECT 
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;
# ANOTHER WAY OF ABOVE QUERY
SELECT 
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY CAST(SUBSTRING_INDEX(TRIM(term), ' ', 1) AS UNSIGNED);

# emp_length WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
SELECT 
    emp_length, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(loan_amount) AS Total_Funded_Amount, 
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

# purpose WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
SELECT 
    purpose, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(loan_amount) AS Total_Funded_Amount, 
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

# home_ownership WISE TOTAL APPL FUNDED AMOUNT AND RECEIVED AMOUNT
SELECT 
    home_ownership, 
    COUNT(id) AS Total_Loan_Applications, 
    SUM(loan_amount) AS Total_Funded_Amount, 
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;

SELECT @@hostname;
