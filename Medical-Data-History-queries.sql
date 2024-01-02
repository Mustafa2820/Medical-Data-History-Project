

-- Q-1  Show first name, last name, and gender of patients who's gender is 'M' .

select first_name,last_name,gender
FROM project_medical_data_history.patients
where gender='M';

-- Q-2  Show first name and last name of patients who does not have allergies.

select first_name,last_name
from project_medical_data_history.patients
where allergies is null;

-- Q-3  Show first name of patients that start with the letter 'C'

select first_name
from project_medical_data_history.patients
where first_name like 'c%';

-- Q-4  Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

select first_name,last_name
from project_medical_data_history.patients
where weight between 100 and  120;

-- Q-5  Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

update patients
set allergies = "NKA"
where allergies = null;

-- Q-6  Show first name and last name concatenated into one column to show their full name.

SELECT concat( first_name ,'    ',last_name) AS full_name
from project_medical_data_history.patients;

-- Q-7  Show first name, last name, and the full province name of each patient.

select patients.first_name,patients.last_name,province_names.province_name
from  project_medical_data_history.patients
inner join province_names
using(province_id);

-- Q-8  Show first name, last name, and the full province name of each patient.

select count(patient_id) as count_of_patients_born_in_2010
from project_medical_data_history.patients
WHERE YEAR(birth_date) = 2010; 

-- Q-9  Show the first_name, last_name, and height of the patient with the greatest height.

select first_name,last_name,height
FROM project_medical_data_history.patients
where height= (select max(height)
               from project_medical_data_history.patients); 
               
-- Q-10  Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

select * from project_medical_data_history.patients
where patient_id in (1,45,534,879,1000);

-- Q-11  Show the total number of admissions

select count(*) from project_medical_data_history.admissions;

-- Q-12  Show all the columns from admissions where the patient was admitted and discharged on the same day.

select * from project_medical_data_history.admissions
where discharge_date = admission_date;

-- Q-13  Show the total number of admissions for patient_id 579.

 SELECT COUNT(*) AS total_admissions_579
FROM project_medical_data_history.patients
WHERE patient_id = 579;

-- Q-14  Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

select distinct city from project_medical_data_history.patients
where province_id= 'NS';

-- Q-15  Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70 

select first_name,last_name,birth_date
from project_medical_data_history.patients
where height>160 and weight>70;

-- Q-16   Show unique birth years from patients and order them by ascending.

select distinct year(birth_date) as  birth_year from project_medical_data_history.patients
order by birth_year asc;

-- Q-17  Show unique first names from the patients table which only occurs once in the list.

SELECT first_name
FROM project_medical_data_history.patients
GROUP BY first_name
HAVING COUNT(*) = 1;

-- Q-18  Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.


SELECT patient_id,first_name
FROM project_medical_data_history.patients
where first_name like 's%s' and length(first_name)>=6;

-- Q-19  Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.

SELECT patient_id,first_name,last_name
FROM project_medical_data_history.patients
inner join admissions
using (patient_id);

-- Q-20  Display every patient's first_name. Order the list by the length of each name and then by alphbetically.

SELECT first_name
FROM project_medical_data_history.patients
order by length(first_name),first_name;

-- Q-21   Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

select
 SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_male_patients,
 SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_female_patients
FROM patients;
           
-- Q-23  Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis, COUNT(*) AS admissions_count
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- Q-24   Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

select city,count(patient_id) as total_number_of_patients_in_the_city
from project_medical_data_history.patients
group by city
order by  city asc ,total_number_of_patients_in_the_city desc ;

-- Q-25  Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor".

SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- Q-26  Show all allergies ordered by popularity. Remove NULL values from query.

select allergies from  project_medical_data_history.patients
where  allergies is not null
group by allergies
order by allergies desc;

-- Q-27  Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

select first_name,last_name,birth_date from  project_medical_data_history.patients
where year(birth_date) between 1970 and 1979
order by year(birth_date) desc ;

-- Q-28  8. We want to display each patient's full name in a single column. Their last_name in all upper
-- letters must appear first, then first_name in all lower case letters. Separate the last_name and
-- first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane 

select concat( upper(last_name ) , ' , ', lower(last_name) ) as full_name from  project_medical_data_history.patients
ORDER BY first_name DESC;

-- Q-29   Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- Q-30  Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

select max(weight) - min(weight) 
from project_medical_data_history.patients
where last_name='Maroni';

-- Q-31  Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions  

select day(admission_date) , count(*) as admission_occur from  project_medical_data_history.admissions
group by  day(admission_date)
order by day(admission_date)  desc;

-- Q-32  Show all of the patients grouped into weight groups. Show the total amount of patients in
-- each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109
-- they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

select  FLOOR(weight / 10) * 10 AS weight_group,
 COUNT(*) AS total_patients_in_group
from project_medical_data_history.patients
group by weight_group
order by weight_group desc;

-- Q-33   Show patient_id, weight, height, isObese from the patients table. Display isObese as a
--  boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm

select patient_id, weight, height, weight/height  ,
CASE WHEN weight / (height / 100 * height / 100) > 30 THEN 1 ELSE 0 END AS isObese
from project_medical_data_history.patients;


-- Q-34 Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the
-- patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients,
-- admissions, and doctors tables for required information.

select p.patient_id, p.first_name, p.last_name, d.specialty
from project_medical_data_history.patients p
join admissions a on p.patient_id=a.patient_id
join doctors d on a.attending_doctor_id = d.doctor_id
where  d.first_name = 'Lisa' and a.diagnosis ='Epilepsy';


-- Q-35 All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission.
--  Show the patient_id and temp_password.
--  The password must be the following, in order:
--  1 patient_id
--  2 the numerical length of patient's last_name
--  3 year of patient's birth_date 

SELECT p.patient_id,
 CONCAT(p.patient_id, LENGTH(p.last_name), YEAR(p.birth_date)) AS temp_password
FROM patients p
inner JOIN admissions a ON p.patient_id = a.patient_id;















