--- Extract – Data Loading and Initial Exploration
--1. Create SQL tables for the following datasets:
-- Create Customer Table
CREATE TABLE customer (
    c_id INT PRIMARY KEY,
    m_id INT,
    c_name VARCHAR(100),
    c_email_id VARCHAR(150),
    c_type VARCHAR(50),
    c_addr TEXT,
    c_cont_no VARCHAR(15)
);

select * from customer


-- Create Employee Details Table
CREATE TABLE employee_details (
    e_id INT PRIMARY KEY,
    e_name VARCHAR(100),
    e_designation VARCHAR(100),
    e_addr TEXT,
    e_branch VARCHAR(50),
    e_cont_no VARCHAR(15)
);



-- Create Employee Manages Shipment Table
CREATE TABLE employee_manages_shipment (
    employee_e_id INT,
    shipment_sh_id INT,
    status_sh_id INT
);

-- Create Membership Table
CREATE TABLE membership (
    m_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE
);



-- Create Payment Details Table
CREATE TABLE payment_details (
    payment_id UUID PRIMARY KEY,
    c_id INT,
    sh_id INT,
    amount NUMERIC(10,2),
    payment_status VARCHAR(50),
    payment_mode VARCHAR(50),
    payment_date DATE
);



-- Create Shipment Details Table
CREATE TABLE shipment_details (
    sh_id INT PRIMARY KEY,
    c_id INT,
    sh_content VARCHAR(100),
    sh_domain VARCHAR(50),
    ser_type VARCHAR(50),
    sh_weight NUMERIC(10,2),
    sh_charges NUMERIC(10,2),
    sr_addr TEXT,
    ds_addr TEXT
);



-- Create Status Table
CREATE TABLE status (
    sh_id INT PRIMARY KEY,
    current_status VARCHAR(50),
    sent_date DATE,
    delivery_date DATE
);




--2. Load the datasets into the respective SQL tables.

-- Load Membership Dataset
copy membership
FROM 'C:/csv/Membership.csv'
DELIMITER ','
CSV HEADER;

-- Load Customer Dataset

COPY customer
FROM 'C:/csv/Customer.csv'
DELIMITER ','
CSV HEADER;

-- Load Employee Details Dataset
copy employee_details
FROM 'C:/csv/Employee_Details.csv'
DELIMITER ','
CSV HEADER;

-- Load Shipment Details Dataset
copy shipment_details
FROM 'C:/csv/Shipment_Details.csv'
DELIMITER ','
CSV HEADER;

-- Load Status Dataset
copy status
FROM 'C:/csv/Status.csv'
DELIMITER ','
CSV HEADER;

-- Load Payment Details Dataset
copy payment_details
FROM 'C:/csv/Payment_Details.csv'
DELIMITER ','
CSV HEADER;

-- Load Employee Shipment Dataset
copy employee_manages_shipment
FROM 'C:/csv/employee_manages_shipment.csv'
DELIMITER ','
CSV HEADER;




'''Explanation

The COPY command imports CSV files into PostgreSQL tables. 
CSV HEADER tells PostgreSQL that the first row contains column names.'''

--3.Display the first 10 records from each table to verify successful data import.

-- Display First 10 Records from Customer Table
SELECT *
FROM customer
LIMIT 10;

-- Display First 10 Records from Employee Details Table
SELECT *
FROM employee_details
LIMIT 10;

-- Display First 10 Records from Shipment Details Table
SELECT *
FROM shipment_details
LIMIT 10;

-- Display First 10 Records from Membership Table
SELECT *
FROM membership
LIMIT 10;

-- Display First 10 Records from Payment Details Table
SELECT *
FROM payment_details
LIMIT 10;

-- Display First 10 Records from Status Table
SELECT *
FROM status
LIMIT 10;

-- Display First 10 Records from Employee Shipment Table
SELECT *
FROM employee_manages_shipment
LIMIT 10;




---4.Identify the total number of unique customers in the Customer.csv dataset.

-- Count Total Unique Customers
SELECT COUNT(DISTINCT c_id) AS total_unique_customers
FROM customer;


--5.List all distinct payment methods in the Payment_Details.csv dataset.

-- Show Distinct Payment Methods
SELECT DISTINCT payment_mode
FROM payment_details;




--section B Transform

--1. Normalize customer names in the Customer.csv table
---to ensure that the first letter is capitalized and the rest are lowercase.

-- Normalize Customer Names into Proper Format
UPDATE customer
SET c_name = INITCAP(LOWER(c_name));
select c_name from customer
limit 10


--2.Standardize email addresses in the Customer.csv table to ensure they are all in lowercase.

-- Convert Email Addresses into Lowercase
UPDATE customer
SET c_email_id = LOWER(c_email_id);
select c_email_id from customer
limit 10


--3.Create a new column CustomerAge in the Customer.csv table by calculating
---the difference between the current date and the Start_date from the Membership.csv table.


-- Add CustomerAge Column
ALTER TABLE customer
ADD COLUMN customerage INT;

-- Calculate CustomerAge using Membership Start Date
UPDATE customer c
SET customerage = DATE_PART(
    'year',
    AGE(CURRENT_DATE, m.start_date)
)
FROM membership m
WHERE c.m_id = m.m_id;

select * from customer
limit 10



--4. Merge the Customer.csv and Membership.csv datasets on M_ID to 
---get membership start and end dates for each customer.

-- Merge Customer and Membership Tables
SELECT
    c.c_id,
    c.c_name,
    c.c_email_id,
    c.c_type,
    m.start_date,
    m.end_date
FROM customer c
JOIN membership m
ON c.m_id = m.m_id;


---5. **Add a `PaymentCategory` column** in the `Payment_Details.csv` table:
 ---   - 'High' if `AMOUNT` > 5000
---    - 'Medium' if `AMOUNT` between 1000 and 5000
 --   - 'Low' if `AMOUNT` < 1000

-- Add Payment Category Column
ALTER TABLE payment_details
ADD COLUMN payment_category VARCHAR(20);

-- Update Payment Categories
UPDATE payment_details
SET payment_category =
CASE
    WHEN amount > 5000 THEN 'High'
    WHEN amount BETWEEN 1000 AND 5000 THEN 'Medium'
    WHEN amount < 1000 THEN 'Low'
END;





---C. Load – Preparing Data for Excel Export


--1.Create a new table ShipmentStatus by joining the Shipment_Details.csv and Status.csv datasets on SH_ID. 
---This table should contain the shipment details along with the current status.

-- Create ShipmentStatus Table
CREATE TABLE shipmentstatus AS
SELECT
    sd.sh_id,
    sd.c_id,
    sd.sh_content,
    sd.sh_domain,
    sd.ser_type,
    sd.sh_weight,
    sd.sh_charges,
    s.current_status,
    s.sent_date,
    s.delivery_date
FROM shipment_details sd
JOIN status s
ON sd.sh_id = s.sh_id;


--2.Calculate the total payment received by each customer by 
--joining the Payment_Details.csv and Customer.csv datasets on C_ID.


-- Calculate Total Payment Received by Each Customer
SELECT
    c.c_id,
    c.c_name,
    SUM(p.amount) AS total_payment_received
FROM customer c
JOIN payment_details p
ON c.c_id = p.c_id
GROUP BY c.c_id, c.c_name
ORDER BY total_payment_received DESC;



--3.Create a ShipmentEfficiency column in the Shipment_Details.csv table
--to calculate the ratio of SH_WEIGHT to SH_CHARGES for each shipment.

-- Add Shipment Efficiency Column
ALTER TABLE shipment_details
ADD COLUMN shipment_efficiency NUMERIC(10,2);

-- Calculate Shipment Efficiency
UPDATE shipment_details
SET shipment_efficiency =
ROUND(sh_weight / NULLIF(sh_charges, 0), 2);


--4.Calculate the average payment amount by
---payment mode (e.g., COD, CARD PAYMENT) in the Payment_Details.csv dataset.

-- Calculate Average Payment Amount by Payment Mode
SELECT
    payment_mode,
    ROUND(AVG(amount), 2) AS average_payment_amount
FROM payment_details
GROUP BY payment_mode
ORDER BY average_payment_amount DESC;


--5.Export the final cleaned and transformed dataset (CustomerPayments table) into 
---a CSV file that can be used in Excel for further analysis.


-- Create Final CustomerPayments Table
CREATE TABLE customerpayments AS
SELECT
    c.c_id,
    c.c_name,
    c.c_email_id,
    c.c_type,
    p.payment_id,
    p.amount,
    p.payment_mode,
    p.payment_status,
    p.payment_date,
    p.payment_category
FROM customer c
JOIN payment_details p
ON c.c_id = p.c_id;

select * from customerpayments

-- Export Final CustomerPayments Table into CSV File
COPY customerpayments
TO 'C:/csv/customerpayments.csv'
DELIMITER ','
CSV HEADER;



