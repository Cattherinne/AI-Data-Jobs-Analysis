-- =========================================================
-- 1. BASIC DATA EXPLORATION
-- =========================================================

-- Query 1: Count total rows
SELECT COUNT (*) FROM ai_data_jobs;

-- Query 2: Preview first 10 rows
SELECT * FROM ai_data_jobs
LIMIT 10;

-- Query 3: Find unique experience levels
SELECT DISTINCT experience_level FROM ai_data_jobs;

-- Query 4: Top 10 most common job titles
SELECT job_title, COUNT(*) AS total_jobs 
FROM ai_data_jobs
GROUP BY job_title
ORDER BY total_jobs DESC
LIMIT 10;

-- Query 5: Number of jobs by experience level
SELECT experience_level, COUNT(*) AS total_jobs
FROM ai_data_jobs
GROUP BY experience_level
ORDER BY total_jobs DESC;

-- =========================================================
-- 2. FILTERING AND SORTING
-- =========================================================

-- Query 6: Find fully remote jobs (100% remote)
SELECT job_title, remote_ratio FROM ai_data_jobs
WHERE remote_ratio = 100
ORDER BY job_title DESC;

-- Query 7: Find entry level jobs
SELECT job_title, experience_level 
FROM ai_data_jobs
WHERE experience_level='Entry'
ORDER BY job_title ASC;

-- Query 8: Find full-time jobs
SELECT job_title, employment_type
FROM ai_data_jobs
WHERE employment_type='Full-time'
ORDER BY job_title ASC;

-- Query 9: Find jobs with 5 or more years of experience
SELECT job_title, years_experience
FROM ai_data_jobs
WHERE  years_experience>=5
ORDER BY years_experience DESC;

-- Query 10: Find jobs requiring a Bachelor's degree
SELECT job_title, education_level
FROM ai_data_jobs
WHERE education_level='Bachelors'
ORDER BY job_title ASC;

-- Query 11: Find jobs with remote ratio of 0 or 50
SELECT job_title, remote_ratio
FROM ai_data_jobs
WHERE remote_ratio IN (0, 50) 
ORDER BY job_title ASC;

-- Query 12: Find jobs with 2 to 5 years of experience
SELECT job_title, years_experience
FROM ai_data_jobs
WHERE years_experience BETWEEN 2 AND 5
ORDER BY years_experience ASC;

-- =========================================================
-- 3. STRING FILTERING
-- =========================================================

-- Query 13: Find jobs containing "Analyst" in the job title
SELECT job_title FROM ai_data_jobs
WHERE job_title LIKE '%Analyst%'
ORDER BY job_title ASC;

-- Query 14: Find jobs containing "Engineer" in the job title
SELECT job_title FROM ai_data_jobs
WHERE job_title ILIKE '%engineer%'
ORDER BY job_title ASC;

-- Query 15: Find jobs starting with "Senior"
SELECT job_title FROM ai_data_jobs
WHERE job_title ILIKE 'Senior%'
ORDER BY job_title ASC;

-- =========================================================
-- 4. AGGREGATION AND GROUPING
-- =========================================================

-- Query 16: Count jobs by industry
SELECT industry, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY industry
ORDER BY job_count DESC;

-- Query 17: Count jobs by company location
SELECT company_location, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY company_location
ORDER BY job_count DESC;

-- Query 18: Top 10 countries by number of jobs
SELECT company_location, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY company_location
ORDER BY job_count DESC
LIMIT 10;

-- Query 19: Average experience by industry
SELECT industry, 
    AVG(years_experience) AS average_experience
FROM ai_data_jobs
GROUP BY industry
ORDER BY average_experience DESC;

-- Query 20: Count fully remote jobs by industry
SELECT industry, COUNT(*) AS fully_remote_jobs
FROM ai_data_jobs
WHERE remote_ratio = 100
GROUP BY industry
ORDER BY fully_remote_jobs DESC;

-- Query 21: Count full-time jobs by experience level
SELECT experience_level, COUNT(*) AS full_time_jobs
FROM ai_data_jobs
WHERE employment_type = 'Full-time'
GROUP BY experience_level
ORDER BY full_time_jobs DESC;

-- Query 22: Industries with more than 100 jobs
SELECT industry, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY industry
HAVING COUNT(*) > 100
ORDER BY job_count DESC;

-- Query 23: Countries with more than 50 jobs
SELECT company_location, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY company_location
HAVING COUNT(*) > 50
ORDER BY job_count DESC;

-- Query 24: Job titles appearing at least 20 times
SELECT job_title, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY job_title
HAVING COUNT(*) >= 20
ORDER BY job_count DESC;

-- =========================================================
-- 5. DATA TRANSFORMATION WITH CASE
-- =========================================================

-- Query 25: Categorize jobs by work arrangement
SELECT job_title, remote_ratio,
CASE
WHEN remote_ratio = 0 THEN 'On-site'
WHEN remote_ratio = 50 THEN 'Hybrid'
WHEN remote_ratio = 100 THEN 'Fully Remote'
END AS work_type
FROM ai_data_jobs;

-- Query 26: Categorize jobs by years of experience
SELECT job_title, years_experience,
CASE
WHEN years_experience <= 2 THEN 'Junior'
WHEN years_experience <= 5 THEN 'Mid'
ELSE 'Senior'
END AS experience_category
FROM ai_data_jobs;

-- Query 27: Categorize companies by size
SELECT job_title, company_size,
CASE
WHEN company_size = 'S' THEN 'Small'
WHEN company_size = 'M' THEN 'Medium'
WHEN company_size = 'L' THEN 'Large'
END AS company_size_category
FROM ai_data_jobs;

-- =========================================================
-- 6. SUBQUERIES
-- =========================================================

-- Query 28:  Find jobs requiring above-average experience
SELECT job_title, years_experience
FROM ai_data_jobs
WHERE years_experience > (
    SELECT AVG(years_experience)
    FROM ai_data_jobs
);

-- Query 29: Find the industry with the highest average experience
SELECT industry,
AVG(years_experience) AS average_experience
FROM ai_data_jobs
GROUP BY industry
ORDER BY average_experience DESC
LIMIT 1;

-- Query 30: Find the most common job title
SELECT job_title, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY job_title
ORDER BY job_count DESC
LIMIT 1;

-- =========================================================
-- 7. NULL HANDLING AND DATA TYPES
-- =========================================================

-- Query 31: Check for NULL values
SELECT
COUNT(*) FILTER (WHERE job_title IS NULL) AS null_job_title,
COUNT(*) FILTER (WHERE experience_level IS NULL) AS null_experience_level,
COUNT(*) FILTER (WHERE employment_type IS NULL) AS null_employment_type,
COUNT(*) FILTER (WHERE company_size IS NULL) AS null_company_size,
COUNT(*) FILTER (WHERE company_location IS NULL) AS null_company_location,
COUNT(*) FILTER (WHERE employee_residence IS NULL) AS null_employee_residence,
COUNT(*) FILTER (WHERE industry IS NULL) AS null_industry,
COUNT(*) FILTER (WHERE remote_ratio IS NULL) AS null_remote_ratio,
COUNT(*) FILTER (WHERE years_experience IS NULL) AS null_years_experience,
COUNT(*) FILTER (WHERE education_level IS NULL) AS null_education_level
FROM ai_data_jobs;

-- Query 32: Convert years of experience to integer
SELECT job_title, years_experience,
CAST(years_experience AS integer) AS years_experience_int
FROM ai_data_jobs;

-- =========================================================
-- 8. COMMON TABLE EXPRESSIONS (CTE)
-- =========================================================

-- Query 33: Find the top 10 countries by number of jobs
WITH country_jobs AS (
SELECT company_location, COUNT(*) AS job_count
FROM ai_data_jobs
GROUP BY company_location
)
SELECT * FROM country_jobs
ORDER BY job_count DESC
LIMIT 10;

-- Query 34: Calculate average experience by industry
WITH average_experience AS (
SELECT industry, AVG(years_experience) AS avg_experience
FROM ai_data_jobs
GROUP BY industry
)
SELECT * FROM average_experience
ORDER BY avg_experience DESC;

-- =========================================================
-- 9. AGGREGATION AND ROUNDING
-- =========================================================

-- Query 35: Average experience by industry rounded to two decimals
SELECT industry, ROUND(AVG(years_experience), 2) AS avg_experience
FROM ai_data_jobs
GROUP BY industry;

-- =========================================================
-- 10. NULLIF AND STRING FUNCTIONS
-- =========================================================

-- Query 36: Use NULLIF to handle zero values
SELECT remote_ratio,
NULLIF(remote_ratio,0) AS remote_ratio_null
FROM ai_data_jobs;

-- Query 37: Combine job title and experience level
SELECT job_title, experience_level,
CONCAT(job_title, ' - ', experience_level) AS job_description
FROM ai_data_jobs;

-- Query 38: Convert job titles to lowercase
SELECT LOWER(job_title) AS job_title_lower
FROM ai_data_jobs;

-- Query 39: Find the longest job titles
SELECT DISTINCT job_title, LENGTH(job_title) AS job_title_length
FROM ai_data_jobs
ORDER BY job_title_length DESC;

-- =========================================================
-- 11. SECOND TABLE — COUNTRIES
-- =========================================================

-- Query 40: Create countries reference table
CREATE TABLE countries (
country_code VARCHAR(10) PRIMARY KEY,
country_name VARCHAR(100),
region VARCHAR(50)
);

-- Query 41: Insert country reference data
INSERT INTO countries (country_code, country_name, region)
VALUES
('AU', 'Australia', 'Oceania'),
('BR', 'Brazil', 'South America'),
('CA', 'Canada', 'North America'),
('DE', 'Germany', 'Europe'),
('ES', 'Spain', 'Europe'),
('FR', 'France', 'Europe'),
('GB', 'United Kingdom', 'Europe'),
('IN', 'India', 'Asia'),
('NL', 'Netherlands', 'Europe'),
('PL', 'Poland', 'Europe'),
('SG', 'Singapore', 'Asia'),
('US', 'United States', 'North America');

-- =========================================================
-- 12. JOINS
-- =========================================================

-- Query 42: Join jobs with country information
SELECT 
j.job_title, 
j.company_location,
c.country_name,
c.region
FROM ai_data_jobs AS j
INNER JOIN countries AS c
ON j.company_location = c.country_code;

-- Query 43: Use LEFT JOIN to combine job and country data
SELECT
j.job_title,
j.company_location,
c.country_name,
c.region
FROM ai_data_jobs AS j
LEFT JOIN countries AS c
ON j.company_location = c.country_code;

-- Query 44: Count jobs by region
SELECT c.region, COUNT(*) AS job_count
FROM countries AS c
INNER JOIN ai_data_jobs AS j
ON j.company_location = c.country_code
GROUP BY c.region
ORDER BY job_count DESC;

-- Query 45: Find regions with more than 100 jobs
SELECT c.region, COUNT(*) AS job_count
FROM countries AS c
INNER JOIN ai_data_jobs AS j
ON j.company_location = c.country_code
GROUP BY c.region
HAVING COUNT(*) > 100
ORDER BY job_count DESC;

-- =========================================================
-- 13. WINDOW FUNCTIONS
-- =========================================================

-- Query 46: Rank jobs by years of experience using ROW_NUMBER
SELECT job_title, years_experience,
ROW_NUMBER() OVER(ORDER BY years_experience DESC) AS job_number
FROM ai_data_jobs;

-- Query 47: Rank industries by number of jobs
SELECT industry, COUNT(*) AS job_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS industry_rank
FROM ai_data_jobs
GROUP BY industry;

-- Query 48: Find the most common job title in each industry
WITH ranked_jobs AS (
SELECT industry, job_title,
COUNT(*) AS job_count, RANK() OVER (
PARTITION BY industry
ORDER BY COUNT(*) DESC
) AS job_rank
FROM ai_data_jobs
GROUP BY industry, job_title
)
SELECT industry, job_title, job_count
FROM ranked_jobs
WHERE job_rank = 1
ORDER BY industry;

-- =========================================================
-- 14. FINAL BUSINESS ANALYSIS
-- =========================================================

-- Query 49: Calculate the percentage of fully remote jobs
SELECT 
ROUND(CAST(COUNT(*) FILTER (WHERE remote_ratio = 100) AS numeric)
        / COUNT(*) * 100, 2) 
		AS fully_remote_percentage
FROM ai_data_jobs;

-- Query 50: Analyze job distribution by experience level
SELECT experience_level, COUNT(*) AS job_count,
ROUND(CAST(COUNT(*) AS numeric)
        / SUM(COUNT(*)) OVER () * 100,
        2
) AS percentage
FROM ai_data_jobs
GROUP BY experience_level
ORDER BY job_count DESC;