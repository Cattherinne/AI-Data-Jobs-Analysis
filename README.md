# AI & Data Science Jobs Analysis

## Project Overview

This project analyzes an AI and Data Science job postings dataset using PostgreSQL. The analysis explores job titles, industries, company locations, experience levels, employment types, education requirements, and remote work arrangements.

## Objectives

The main objectives of this project are to:

- Analyze the distribution of job postings across industries and countries.
- Identify the most common job titles.
- Examine experience-level and education requirements.
- Analyze remote work arrangements.
- Compare job postings across regions.
- Use SQL techniques to extract meaningful insights from the dataset.

## Dataset

The dataset contains 5,000 AI and Data Science job postings and includes information about job titles, experience levels, employment types, company sizes, company locations, employee residences, industries, remote work ratios, years of experience, and education levels.

## Tools & Technologies

- PostgreSQL
- pgAdmin
- SQL
- VS Code
- GitHub

## SQL Analysis

The project includes 50 SQL queries covering different levels of data analysis and SQL techniques.

The analysis includes:

- Basic data exploration
- Filtering and sorting
- String filtering
- Aggregation and grouping
- CASE statements
- Subqueries
- NULL handling
- Data type conversion
- Common Table Expressions (CTEs)
- String functions
- NULLIF
- JOINs
- Window functions
- Percentage calculations

## Power BI Dashboard

The Power BI dashboard provides an interactive analysis of AI and Data Science job postings.

The dashboard includes:

- KPI overview
- Jobs by industry
- Top 10 job titles
- Jobs by experience level
- Top 10 countries by job postings
- Jobs by region
- Remote work analysis
- Interactive filters

## Key Findings

- **Data Scientist** is the most common job title, with 709 job postings.
- **Technology** is the largest industry, with 1,528 job postings, representing approximately 30.6% of the dataset.
- The **United States** has the highest number of job postings, with 1,786.
- The **United States and India** together account for approximately 51.4% of all job postings.
- **Government** has the highest average required experience, at 8.98 years.
- **Technology** has the highest number of fully remote job postings, with 462 positions.
- **Mid-level** positions are the most common, with 1,613 job postings.
- **North America** has the highest number of job postings among the analyzed regions, with 2,136.
- **28.40%** of all job postings are fully remote.
- **Mid-level and Senior positions** together account for **62.66%** of all job postings.

For the complete list of findings and detailed results, see [Key Findings](key_findings.md).

## Project Structure

```text
AI-Data-Jobs-Analysis/
│
├── README.md
├── key_findings.md
│
├── sql/
│   ├── create_table.sql
│   └── queries.sql
│
└── powerbi/
    └── AI_Data_Jobs_Analysis.pbix