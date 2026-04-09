# 📚 Amazon Bestsellers Analysis (2009-2019)

## 👤 Project Overview
This project presents an end-to-end data analysis of Amazon's top 50 bestselling books over an 11-year period. As a **Systems Engineer**, I developed this project to demonstrate the integration of relational databases with modern Business Intelligence tools.

## 🛠️ Technical Stack
* **Database:** MySQL Workbench (Data modeling, ETL, and cleaning).
* **Analytics:** SQL (Advanced aggregations, `CASE` statements, and `GROUP_CONCAT`).
* **Visualization:** Power BI (Interactive dashboards and DAX measures).
* **Source:** Kaggle (Amazon Bestselling Books dataset).

## 📸 Dashboard Preview
![Dashboard Screenshot](dashboard_image.png)
*(Note: Replace the text above with the exact name of your uploaded image file)*

## 🔍 Business Questions Addressed
I utilized SQL to extract specific insights before visualizing them in Power BI:
1. **Price vs. Satisfaction:** Does a higher price tag guarantee a better user rating?
2. **Genre Strategy:** How do pricing strategies and volatility differ between Fiction and Non-Fiction?
3. **Market Dominance:** Which authors have consistently dominated the list for over 5 years?

## 🚀 Key Findings
* **Market Share:** Non-Fiction titles represent the majority of the list (approx. 57%), showing a stable demand for educational and self-help content.
* **Pricing Volatility:** Using the `STDDEV` function in SQL, I identified that Non-Fiction prices vary significantly more than Fiction titles.
* **The "Gallup" Case:** Identified the Gallup Organization as the most consistent entity, maintaining presence in the Top 50 for nearly a decade with a single product.

## 📂 Project Structure
* `/sql-scripts`: Contains the database dump and the analysis queries.
* `/dashboard`: The `.pbix` file for local exploration.
* `/data`: The raw dataset in CSV format.

---
**Developed by:** Carlos Antonio Bernal Benítez - *Systems Engineer*
