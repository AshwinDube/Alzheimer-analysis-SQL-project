use alzeimer;
select * from alzheimers_disease_patient_data;
-- ==================================================================================================================================
/*Making a copy of table so that the original dataset is protected*/
create table new_alzeimer like alzheimers_disease_patient_data;
insert into new_alzeimer 
select * from alzheimers_disease_patient_data;
select * from new_alzeimer;
/* New table is created named as "new_alzeimer"*/
-- ==================================================================================================================================
# Q1. Total number of Alzeimer patient 
select count(PatientID) from new_alzeimer;

# Ans: There are total 2149 Alzeimer Patient 

-- ============================================================================================================================
# Q2. Classifing age group having alzeimer
with cte as (
select Age,
case when Age between 50 and 60 then '50-60'
	 when Age between 61 and 70 then '61-70'
     when Age between 71 and 80 then '71-80'
     when Age between 81 and 90 then '81-90'
     when Age between 91 and 100 then '91-100'
end as age_group
from new_alzeimer)

select age_group , count(Age) from cte group by age_group;
-- ============================================================================================================================
# Q3. Is there any relation between gender with alzeimer 

select case when Gender = 0 then 'female' else 'Male' end as Gender ,
count(Gender)/(select count(*) from new_alzeimer) * 100 as Gender_wise_average
from new_alzeimer
group by Gender
;

-- ============================================================================================================================
# Q4. patient having high BMI and is High Bmi cause alzeimer?
with bmi_index as 
(
select case when BMI > 30 then 'Obeses'
			when BMI between 25 and 29.9 then 'over Weight'
			when BMI between 18.5 and 24.9 then 'Normal'
            else 'Under Weight'
end as BMI_bracket from new_alzeimer)

select BMI_bracket , count(BMI_bracket)/(select count(*) from new_alzeimer) * 100 as BMI_alzeimer_patient
from bmi_index group by bmi_Bracket order by BMI_alzeimer_patient ;

/*We can say that a people with obese are having risk of alzeimer*/

-- ============================================================================================================================
#Q5. Can smoking increse or cause the alzeimer 
select case when Smoking = 0 then 'No' else 'Yes' end as Smoking, 
count(Smoking) as count
from new_alzeimer group by Smoking;

/* There is no relation between Smoking and Alzeimer*/

-- ============================================================================================================================
# Q6. People having Alzeimer vs phisical activity

with activity as (
select case 
	when PhysicalActivity = 0 then 'No Activity'
    when PhysicalActivity between 1 and 2.5 then 'Low Activity'
    when PhysicalActivity between 2.6 and 7.5 then 'Moderate Activity'
    else 'High Activity' end as Activity_Criteria
    from new_alzeimer
)
select 
Activity_Criteria,count(Activity_Criteria)/(select count(*) from new_alzeimer)*100 alzeimer_activity_percentage
from activity group by Activity_Criteria;

-- ============================================================================================================================
# Q7. Can a healty diet prevent or heal Alzeimer
with diet_table as(
select 
	case when DietQuality between 0 and 3 then 'Low Diet Quality'
		 when DietQuality between 3.1 and 7 then 'Moderate Diet Quality'
         else 'Good Diet Quality'
	end as Diet_Category
from new_alzeimer)
    
select Diet_Category, count(Diet_Category)/(select count(*) from new_alzeimer) * 100 as Quality_Diet_Percent
from diet_table group by Diet_Category;
    
-- ============================================================================================================================
# Q8. Can a quality sleep heal Alzeimer or can prevent from Alzeimer
with sleep as(
select 
	case when Sleepquality between 0 and 3 then 'Low Sleep Quality'
		 when Sleepquality between 3.1 and 7 then 'Moderate Sleep Quality'
         else 'Good Sleep Quality'
	end as sleep_category
from new_alzeimer)

select sleep_category, count(sleep_category)/(select count(*) from new_alzeimer)*100 as QualitySleepPercent
from sleep  group by sleep_category;

-- ============================================================================================================================
# Q9 Is Alzeimer Heridatory
with heridatory as (
select case when 
FamilyHistoryAlzheimers = 0 then 'No' else 'Yes' end as FamilyHistoryAlzeimers from new_alzeimer)

select FamilyHistoryAlzeimers , count(*) as IsHeridatoryOrNot
from heridatory  group by FamilyHistoryAlzeimers;

/* We can say that alzeimer is not Heridatory*/



-- =====
select * from new_alzeimer;





