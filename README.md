# 🚗 Tata Motors Integrated Operations Analysis

## 📌 Overview

This project presents an end-to-end Manufacturing Operations Analytics solution for Tata Motors, focusing on logistics management, shipment tracking, payment monitoring, customer insights, and AI-powered operational automation.

The solution combines SQL ETL pipelines, Excel-based exploratory data analysis, Power BI dashboards, and GenAI-powered n8n workflows to generate actionable business insights and automate operational reporting.

---

## 🎯 Business Problem

Tata Motors manages large-scale manufacturing and logistics operations involving:

* Shipment Tracking
* Dealer Distribution
* Customer Management
* Payment Processing
* Employee Operations
* Supply Chain Monitoring

As operational data grows, manual reporting and fragmented systems reduce visibility into business performance and logistics efficiency.

This project builds a centralized analytics ecosystem to improve operational intelligence and automate reporting workflows.

---

## 🏗️ Project Objectives

### SQL ETL Pipeline

* Design relational database schema
* Load operational datasets into PostgreSQL
* Clean and transform logistics data
* Create analytical datasets

### Excel Exploratory Data Analysis

* Customer Analytics
* Shipment Analysis
* Payment Analysis
* Logistics Efficiency Evaluation

### Power BI Dashboard

* Customer Insights
* Shipment Operations Monitoring
* Financial Health Dashboard

### GenAI Automation

* Daily Logistics Summary Generation
* Shipment & Payment Issue Explanation System

---

## 🛠️ Technology Stack

| Technology         | Purpose                   |
| ------------------ | ------------------------- |
| PostgreSQL         | Database Management       |
| SQL                | ETL & Data Analysis       |
| Microsoft Excel    | Exploratory Data Analysis |
| Power BI           | Interactive Dashboards    |
| n8n                | Workflow Automation       |
| Groq Llama 3.3 70B | Generative AI             |
| Postman            | API Testing               |

---

## 🗄️ Database Architecture

The solution utilizes seven operational datasets:

1. Customer
2. Membership
3. Employee Details
4. Shipment Details
5. Payment Details
6. Shipment Status
7. Employee Shipment Mapping

The relational database model supports shipment operations, customer management, payment tracking, employee assignment, and logistics analytics.

---

## 📊 Key Business Insights

### Logistics Performance

* Domestic shipments average **117.98 days** delivery time.
* International shipments average **96.26 days** delivery time.
* Regional logistics bottlenecks were identified within domestic distribution networks.

### Payment Analytics

* Cash on Delivery (COD) transactions average **₹49,578.86**.
* Card payments average **₹45,039.89**.
* Operations show significant dependency on COD-based payment workflows.

### Cargo Operations

* More than **60%** of shipments are classified as Heavy Cargo.
* Increased transportation and warehousing complexity impacts operational efficiency.

### Customer Analytics

* Retail customers account for approximately **39%** of the customer base.
* Expired memberships indicate customer retention opportunities.

---

## 📈 Power BI Dashboard Modules

### Customer Insights Dashboard

* Customer Segmentation
* Membership Analysis
* Revenue Contribution Analysis

### Shipment Operations Dashboard

* Domestic vs International Logistics
* Delivery Performance Monitoring
* Service Type Analysis

### Financial Health Dashboard

* Revenue Trends
* Payment Recovery Analysis
* Customer Revenue Contribution

---

## 🤖 GenAI + n8n Automation

### Automation 1: Daily Logistics Operations Summary

#### Business Problem

Operations managers cannot continuously monitor dashboards throughout the day.

#### Solution

An automated workflow retrieves operational metrics and generates AI-powered daily logistics summaries.

#### Workflow

Cron Trigger ⬇️ SQL Metrics Extraction ⬇️ GenAI Analysis ⬇️ Email Report Generation

---

### Automation 2: Shipment & Payment Issue Explanation System

#### Business Problem

Operations teams require immediate explanations for shipment delays, payment issues, and operational exceptions.

#### Solution

An AI-powered workflow retrieves shipment, payment, and employee information and generates business-friendly operational explanations.

#### Workflow

Webhook Input ⬇️ Shipment Lookup ⬇️ SQL Data Retrieval ⬇️ GenAI Reasoning ⬇️ Operational Explanation

---

## 📈 Estimated Business Impact

| Initiative                | Expected Improvement |
| ------------------------- | -------------------- |
| Predictive Maintenance    | 8%                   |
| Defect Reduction          | 5%                   |
| Inventory Optimization    | 4%                   |
| EV Expansion              | 6%                   |
| Supply Chain Optimization | 3%                   |

### Overall Estimated Profitability Improvement: **26%**

---

## 👨‍💻 Author

**Ruchi Nailwal**

---

## 🎯 Project Outcome

This project demonstrates how SQL ETL, Excel Analytics, Power BI Reporting, and GenAI Automation can be integrated into a unified manufacturing analytics ecosystem capable of improving logistics visibility, operational efficiency, and data-driven decision-making across Tata Motors' manufacturing and supply chain network.
