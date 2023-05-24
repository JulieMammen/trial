---Wants to know the time spent in hospital
Select ROUND(AVG(time_in_hospital),0) As Avgstay
FROM Diabetes.dbo.diabetics
Order by time_in_hospital


---List of specialities and number of procedures/speciality
Select DISTINCT(medical_specialty),Count(medical_specialty)as total,AVG(num_procedures) as avgprocedures
FROM Diabetes.dbo.diabetics
Group by medical_specialty 
Order by avgprocedures desc

---Patients needed more procedures if they stayed longer in hospital
SELECT MAX(num_lab_procedures) as MAX,MIN(num_lab_procedures) AS MIN,ROUND(Avg(num_lab_procedures),1) as AVG
FROM Diabetes.dbo.diabetics

 Select  ROUND(AVG(time_in_hospital),0) As Avgstay,
 CASE WHEN num_lab_procedures>=0 AND num_lab_procedures<25 then 'FEW'
 WHEN num_lab_procedures>=25 AND num_lab_procedures<55 then 'average'
 WHEN num_lab_procedures>=55 THEN 'many' END AS PROCEDUREFREQUENCY
FROM Diabetes.dbo.diabetics
Group By num_lab_procedures
---Order by time_in_hospital DESC (DOESNT WORK IF I RUN LINE)

Looking for opportunities when patients came into the hospital with an emergency(admission_type_id of 1)but stayed less than average time in the hospital
WITH average_time_hospital AS (
SELECT  AVG(time_in_hospital) As Avgstay
FROM Diabetes.dbo.diabetics
)
Select count(*) as successful_case
FROM Diabetes.dbo.diabetics
WHERE admission_type_id=1
AND time_in_hospital< (SELECT * FROM average_time_hospital)
---33684
 ----COMPARED TO TOTAL NUMBER OF PATIENTS
 SELECT COUNT(*) as total_patients
 FROM Diabetes.dbo.diabetics
 ---101766
 ---percentage of succeessrate
 33%
 ---Patients with diabetes and hospital admissions
 SELECT encounter_id,diabetesMed,COUNT(*)
 FROM Diabetes.dbo.diabetics
 Where diabetesMed='YES'
 GROUP BY diabetesMed
 Order by encounter_id
 ------How frequently patient on diabetes medication came to hospital
  SELECT Distinct(patient_nbr), diabetesMed, Count(*) as Count
FROM Diabetes.dbo.diabetics
WHERE diabetesMed='YES'
Group by patient_nbr,diabetesMed
ORDER BY patient_nbr


   ---Ages of patients and  diabetes
  SELECT age, Count(*) AS TOTALDIABETESAGERANE 
FROM Diabetes.dbo.diabetics
WHERE diabetesMed='YES' 
GROUP BY age
HAVING COUNT(*)>0
ORDER BY TOTALDIABETESAGERANE DESC
------70-80 age range  WITH maximum number of patients(20191)

------readmission and diabetes patients
SELECT patient_nbr,readmitted,diabetesMed, Count(*) as total_count_for_readmission
FROM Diabetes.dbo.diabetics
WHERE readmitted !='NO' AND
diabetesMed='YES'
Group by readmitted,patient_nbr,diabetesMed
Order by diabetesMed

----Racial dominance in emergency room visit
SELECT patient_nbr,race,COUNT(admission_type_id) as Hospitalvisitcount
FROM Diabetes.dbo.diabetics
WHERE race='caucasian'
Group by patient_nbr,race
Order by race
---53601
SELECT patient_nbr,race,COUNT(admission_type_id) as Hospitalvisitcount
FROM Diabetes.dbo.diabetics
WHERE race='AfricanAmerican'
Group by patient_nbr,race
Order by race
----12932
Select Count(patient_nbr) As total_patients
FROM Diabetes.dbo.diabetics
---101766












