# 🎬 Advanced Data Management Project – DVD Rental Database  

This project was completed as part of my **Advanced Data Management (D191/D326)** course, where I built a SQL-based reporting system on top of the PostgreSQL DVD Rental dataset. The goal was to answer a real-world business question using detailed and summarized reporting, supported by functions, triggers, and stored procedures.  

---

## 📊 Project Overview  
The project emulates a professional data analysis workflow by designing a database reporting system that transforms raw DVD rental data into **actionable insights for stakeholders**.  

I created:  
- A **detailed report table** containing granular rental and customer activity data  
- A **summary report table** aggregating spending totals to directly answer the business question:  
  > **“Who are the top customers based on total rental spending?”**  

The system automates transformations, data refreshes, and report updates, ensuring it stays current and usable for nontechnical users.  

---

## ⚙️ What I Built  

### 1. **SQL Tables & Reports**  
- **Detailed Report Table** with rental-level data (customer, film, rental/return date, amount paid)  
- **Summary Report Table** with aggregated totals for each customer  

### 2. **Data Transformation with Functions**  
- Wrote a **User-Defined Function (UDF)** to transform coded fields into human-readable values  
  - Example: `active_status` → `"Y/N"` becomes `"Yes/No"`  

### 3. **Data Extraction Queries**  
- Built SQL queries to pull raw rental data from the DVD Rental database into the detailed table  

### 4. **Triggers for Automation**  
- Implemented a **Trigger** that automatically updates the summary table when new rows are inserted into the detailed table  

### 5. **Stored Procedures**  
- Developed a **Stored Procedure** that:  
  1. Clears existing data in both tables  
  2. Re-extracts detailed rental records  
  3. Recalculates summary aggregates  
- Designed for use with **pgAgent** or similar job scheduling tools for automated refresh  

### 6. **Video Demonstration**  
- Recorded a Panopto demo walking through the SQL code and showing the working solution  

---

## 🛠️ Technologies Used  
- **PostgreSQL** (DVD Rental sample database)  
- **SQL** (DDL, DML, Functions, Triggers, Stored Procedures)  
- **pgAdmin / Labs on Demand**  

---

## 🚀 Key Outcomes  
✅ Built a **two-level reporting system** (detailed + summary) to support business decision-making  
✅ Automated reporting pipeline using **SQL functions, triggers, and stored procedures**  
✅ Delivered a **professional-grade database solution** for analytics and stakeholder reporting  

---

## 📌 Competencies Demonstrated  

- **4037.5.1 – Writes Structured Query Language (SQL) Statements**  
  - Wrote complex queries for data extraction, analysis, and manipulation  

- **4037.5.2 – Configures Automated Tasks**  
  - Configured triggers, functions, and stored procedures to automate reporting and data integration  

---

## 🖼️ Project Workflow  

```mermaid
flowchart TD
    A[Source DVD Database] --> B[Detailed Report Table]
    B -->|Trigger| C[Summary Report Table]
    B -->|Stored Procedure| B
    C -->|Stored Procedure| C
