-- =========================================================
-- CREATE TABLE: AI DATA JOBS
-- =========================================================

create table ai_data_jobs(
job_id serial primary key,
job_title varchar(150),
experience_level varchar(50),
employment_type varchar(50),
company_size varchar(50),
company_location varchar(50),
employee_residence varchar(50),
industry varchar(100),
remote_ratio integer,
years_experience numeric(4,1),
education_level varchar(50)
);