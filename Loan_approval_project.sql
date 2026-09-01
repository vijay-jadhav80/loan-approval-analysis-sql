use loan_aproval;


-- overview of columns 
describe loan;

-- overview of the datset 
select * from loan;

-- The total number of loan applications (total number of rows)
select count(*) from loan;


-- The total number of columns 
select count(*) as Total_columns 
from information_schema.columns 
where table_name = "loan";


-- approved lone status
select count(*) from loan
 where loan_status = "Approved";

--  rejected loan status
select count(*) from loan
 where loan_status = "Rejected";


-- Approved & rejected loan status
select  loan_status , count(*) as total_count
from loan group by loan_status;


-- loan approved status in percentage
select count(*)*100/999 as loan_approved_percenrage
 from loan where loan_status = "Approved";
 
 
 -- Check for NULL/missing values in every column.
 
 -- gender
 select count(*) as missing_gender 
 from loan where gender is null;
 
 -- marrid
 select count(*) as missing_married
 from loan where married is null;

  -- dependents 
select count(*) as missing_dependants 
from loan where dependents is null;
-- null values are not avelable in this dataset 


-- Check whether there are any duplicate loan IDs.
describe loan;
-- here loane id dosenot duplicat becouse loan id is primary key


-- minimum ,maximum  and  average age of applicant 
select min(age) as minimum_age ,
 max(age) as maximum_age ,
 avg(age) as average_age
 from loan;
 
 
 -- minimum ,maximum and average applicant_income
  select min(applicant_income)  as minimum_applicant_income, 
 max(applicant_income) as maximum_applicant_incomet,
 avg(applicant_income) as average_applicant_income
 from loan;
 
 
 -- minimum ,maximum and average loan_amount
 select min(loan_amount)  as minimum_loan_amount, 
 max(loan_amount) as maximum_loan_amount,
 avg(loan_amount) as average_loan_amount
 from loan;


-- minimum , maximum and average loan term
 select min(loan_term)  as minimum_loan_term_in_days, 
 max(loan_term) as maximum_lloan_term_in_days,
 avg(loan_term) as average_loan_term_in_days
 from loan;


-- number of unique values of categorical column

-- gender column
select gender ,count(*) as  total_count 
from loan group by gender;

-- married status 
select married , count(*) as total_count
from loan group by married;

-- dependents
select dependents, count(*) as total_count
from loan group by dependents; 

-- education status 
select education , count(*) as total_count
from loan group by education;

-- employment_status
select employment_status , count(*) as
total_count from loan group by employment_status;

-- property_area
select  property_area , count(*) as total_count
from loan group by property_area;

-- credit_history
select credit_history, count(*) as 
total_count from loan group by credit_history;

-- loan_status
select loan_status , count(*) as total_count
from loan group by loan_status;


-- ** Applicant Demographics ** 

-- number of applicant gender 
select gender , count(*) as total_count 
from loan group by gender;


-- male loan approval rate 
select count(*) as male_loan_approval 
from loan where loan_status = "Approved" and gender = "male" ;

select 
round(sum(case when gender = "male"
 and loan_status = "Approved" 
 then 1 else 0 end)/sum(case when gender = "male" then 1 else 0 end) * 100 ,2) 
 as male_loan_approval_rate 
 from loan;

-- female loan approval rate 
select count(*) as female_loane_approved
from loan where loan_status = "Approved" and gender = "female" ;


-- married persons loan approval rate 
select count(*) as married_person_loan_approved
from loan where loan_status = "Approved" and married = "Yes";


 -- unmarried persons loan approval rate 
select count(*) as unmarried_person_loan_approved
from loan where loan_status = "Approved" and married = "No";


-- graduate persno loan approved rate 
select count(*) as graduare__person_loan_approved
from loan where loan_status = "Approved" and education = "Graduate" ;

-- no graduate persno loan approved rate 
select count(*) as Not_graduare__person_loan_approved
from loan where loan_status = "Approved" and education = "Not Graduate" ;



-- employement status
select employment_status , count(*) as status
from loan group by employment_status;


-- comapring loan approval rate with salaried ,self_employed ,unemployeed
select employment_status ,
 count(*) as total_applicant,
 sum(case when loan_status = "Approved" then 1 else  0 end) as approved,
 sum(case when loan_status = "Approved" then 1 else  0 end)/count(*) *100 as approval_percentage
from loan group by employment_status;
  
  
-- number of applicant in each property area 
select  property_area , count(*) 
from loan group by property_area;


-- loan approval rate of property areas
select property_area , 
count(*) as applicant_count ,
sum(case when loan_status = "Approved" then 1 else 0 end) as Approved_count,
sum(case when loan_status = "Approved" then 1 else 0 end)/count(*)*100 as approval_rate
from loan group by property_area; 

-- diffrent number of dependent approval rate 
select dependents , 
count(*) as total_count,
sum(case when loan_status = "Approved" then 1 else 0 end) as approved,
sum(case when loan_status = "Rejected" then 1 else 0 end) as rejected,
sum(case when loan_status = "Approved" then 1 else 0 end)/ count(*) * 100 as approval_rate
from loan group by dependents; 


--  average age of loan approval status 
select avg(age) as avg_age_loan_approval_status
 from loan where loan_status = "Approved" ;

-- average age of loan_approved and loan_rejected status
select loan_status ,
 avg(age) as avg_age 
from loan group by loan_status;




-- ** Financial Analysis ** 


-- comparing average applicant income between approved and rejected applicant
select loan_status,
avg(applicant_income) as average_applicant_income
from loan group by loan_status;


-- comparing average co-applicant income between approved and rejected applicant
select loan_status,
avg(coapplicant_income) as average_co_applicant_income
from loan group by loan_status; 


-- comparing average loan amount between between approved and rejected applicant
select loan_status,
avg(loan_amount) as Avg_loan_amount 
from loan group by loan_status;


-- highest loan amount among approved loans
select max(loan_amount) as high_loan_amount_approved_loans
from loan where loan_status = "Approved";

-- highest loan amount among rejected loans
select max(loan_amount) as high_loan_amount_rejected_loans
from loan where loan_status = "Rejected";


-- highest income applicant
select * from loan 
where applicant_income = 
(select max(applicant_income) from loan);

-- lowest income applicant
select * from loan 
where applicant_income =
(select min(applicant_income) from loan) ;


-- low ,medium ,high income rate with approval rate 
select (case when applicant_income < 35000 then "Low"
when applicant_income < 65000 then "medium"
else "High" end) as applicant_income_range ,
count(*) as Total_applicant,
sum(case when loan_status = "Approved" then 1 else 0 end) as Approved,
sum(case when loan_status = "Rejected" then 1 else 0 end) as Rejected,
round(sum(case when loan_status = "Approved" then 1 else 0 end) /count(*) * 100,2) as approval_rate 
from loan group by Applicant_income_range; 


-- divide low , medium and high group lones and compareing loan approval rate 
 
 -- firestly we calculate minimum ,average and maximum loan amount  
select min(loan_amount) as minimum_loan_amount,
avg(loan_amount) as avvg_loan_amount,
max(loan_amount) as maximum_loan_amount
from loan;

-- calculate low , medium and maximum loan amount and approval rate 
select (case when loan_amount <100000 then "low"
when loan_amount < 200000 then "Medium"
else "high" end) as loan_amount_range,
count(*) as total_loan_applicant,
sum(case when loan_status = "Approved" then 1 else 0 end) as approved_loans,
sum(case when loan_status = "Rejected" then 1 else 0 end) as Rejected_loans,
round(sum(case when loan_status = "Approved" then 1 else 0 end) /count(*) * 100,2) as loan_approval_rate
from loan group by loan_amount_range;



-- applicant income with recived loan amounts 

-- firestly we are calculate min, medium , max applicant income 
select min(applicant_income) as minimum_applicant_income,
avg(applicant_income) as average_applicant_income ,
max(applicant_income) as Maximum_applicant_income
from loan;

-- income with recived loan amounts
select 
(case when applicant_income < 40000 then "low"
when applicant_income < 90000 then "medium"
else "high" end) as applicant_income_catagory,
count(*) as app_inco_category_count,
avg(applicant_income) as average_applicant_income,
avg(loan_amount) as avg_loan_amount
from loan group by applicant_income_catagory; 



-- comparing loan approval rate with diffrent cradit history
select 
credit_history,
count(*) as total_applicant,
sum(case when loan_status = "Approved" then 1 else 0 end) as loan_approved,
sum(case when loan_status = "Rejected" then 1 else 0 end) as loan_rejected,
round(sum(case when loan_status = "Approved" then 1 else 0 end)/count(*) * 100,2) as loan_approval_rate 
from loan group by credit_history;


-- avg income of each cradit history group 
select credit_history,
avg(applicant_income) as avg_applicant_income,
count(8) as number_of_applicant
from loan 
group by credit_history;


-- avg loan amount for each cradit history
select 
credit_history,
avg(loan_amount) as avg_loan_amount
from loan 
group by credit_history; 


-- good cradit history but reject loans
select * from loan
where credit_history = 1
and loan_status = "Approved";

-- poor cradit history but approved loans
select * from loan 
where credit_history = 0
and  loan_status = "Approved";


-- high applicant income but loan are rejected 
select * from loan
where applicant_income > 80000
and loan_status = "Rejected";


-- low applicant income but approved loans
select * from loan 
where applicant_income < 35000
and loan_status = "Approved"; 


-- applicant and their large loans compare with loan amount
select loan_id,
applicant_income,
loan_amount,
loan_amount / applicant_income as loan_to_income_ratio
 from loan where  (loan_amount/applicant_income) > 2;  



-- loan approved and high income applicant with good-cradit history with approval rate 
select 
(case when applicant_income > 70000 then "high_income+good_cradit" 
else "other applicant" end) as group_of_cradit_history ,
count(*) as total_applicant,
sum(case when loan_status = "Approved" then 1 else 0 end) as Approved,
sum(case when loan_status = "Rejected" then 1 else 0 end) as Rejected,
round(sum(case when loan_status = "Approved" then 1 else 0 end)/count(*) * 100,2) as approval_rate
from loan group by  group_of_cradit_history ;


-- factor associated with aproval cradit_history , income  loan_amount or  employement_status 
-- select
-- (income)  do later 



-- typical profile of an approved applicant using averages and most common categories
select avg(age) as average_age,
avg(applicant_income) as avg_applicant_income,
avg(loan_amount) as loan_amount, 
avg(coapplicant_income) as avg_co_applicant_income,
avg(loan_term) as avg_loan_term
from loan where loan_status = "Approved"
group by loan_status  ;

-- most common gender approved loans
select gender ,
count(*) as total
from loan where loan_status = "Approved"
group by gender  order by total
desc limit 1;

-- most common married status  to ampproved loans
select married,
count(*) as total
from loan 
where loan_status = "Approved"
group by married
order by total desc limit 1;


-- most common educated people  to ampproved loans
select  education ,
count(*) as total 
from loan 
where loan_status = "Approved"
group by education 
order by total 
desc limit 1;


-- most commmon employment tatus  to approved loans
select  employment_status ,
count(*) as total 
from loan 
where loan_status = "Approved"
group by employment_status 
order by total desc
limit 1;

-- most common property are to approved loans
select 
property_area,
count(*) as total 
from loan 
where loan_status = "Approved"
group by property_area
order by total 
desc limit 1;



-- tipical profile for rejected loans 


-- averages of numeric columns for only rejected loans
select 
avg(applicant_income) as avg_applicant_income,
avg(coapplicant_income) as avg_coapplicant_income,
avg(loan_amount) as avg_loan_amount,
avg(age) as avg_age
from loan  where loan_status = "Rejected";



select
loan_status,
sum(case when gender = "male" then 1 else 0 end) as gender_male,
sum(case when gender = "female" then 1 else 0 end) as gender_female,
sum(case when married = "Yes" then 1 else 0 end) as married_status_yess,
sum(case when married = "No" then 1 else 0 end ) as married_status_No,
sum(case when employment_status = "Unemployed" then 1 else 0 end) as emp_status_un_emp,
sum(case when employment_status = "Salaried" then 1 else 0 end) as emp_status_salaried_emp,
sum(case when employment_status = "Self-Employed" then 1 else 0 end) as emp_status_self_emp,
sum(case when credit_history = 1 then 1 else 0 end ) as credit_history_1,
sum(case when credit_history = 0 then 1 else 0 end ) as credit_history_0,
sum(case when property_area = "Semiurban" then 1 else 0 end ) as prop_Semiurban,
sum(case when property_area = "Urban" then 1 else 0 end ) as prop_Urban,
sum(case when property_area = "Rural" then 1 else 0 end ) as prop_Rural

from loan where loan_status = "Rejected"
group by loan_status ;


-- employment status requires highest average loan amount

select employment_status,
avg(loan_amount) as average_loan_amount
from loan 
group by employment_status
order by average_loan_amount
desc limit 1;



-- property are to highest rejection rate 
select property_area,
count(*) as  total_loans,
sum(case when loan_status = "rejected" then 1 else 0 end) as rejected_loans,
round(sum(case when loan_status = "rejected" then 1 else 0 end) / count(*) * 100,2) as reject_rate 
from loan 
group by property_area
order by reject_rate
desc limit 1;



-- education group with highest approval rate 

select
education ,
count(*) as total_applicant,
sum(case when loan_status = "Approved" then 1 else 0 end) as approved_count,
round(sum(case when loan_status = "Approved" then 1 else 0 end)/ count(*) * 100,2) as loan_approval_rate
from loan 
group by education
order by loan_approval_rate
desc limit 1;


select min(age) as minimum_age ,
max(age) as maximum_age
from loan;

-- grouping of age with highest loan approval rate 

select
(case when age >= 21 and age < 31 then "21 to 30"
when age >= 31 and age < 41  then "31 to 40"
when age >= 41 and age < 51 then "41 to 50 "
else "51 to 60" end ) as age_group ,
count(*) as age_group_count,
sum(case when loan_status = "Approved" then 1 else 0 end) as Approved_loans_count,
round(sum(case when loan_status = "Approved" then 1 else 0 end)/count(*) * 100,2) as approval_rate 
from loan
group by age_group 
order by approval_rate 
desc ;


-- employment status and gradit history with highest loan approval rate 

select 
employment_status ,
credit_history,
round(sum(case when loan_status = "Approved" then 1 else 0 end)/ count(*) * 100,2) as approval_rate 
from loan
group by employment_status,credit_history
order by approval_rate 
desc limit 1;


-- top 10 highest loan_amount they are approved

select loan_id,
loan_amount,
gender ,
education ,
employment_status ,
property_area,
loan_status
from loan where loan_status = "Approved"
order by loan_amount 
desc limit 10;


-- 5 most important factors associvated with the loan_aproval
-- ans
-- 1 - employment status salaried  and cradit history is 1(which is means good cradit history)
-- 2- most of the applicant are graduated and their approval rate is more than 50%

select * from loan limit 10;


 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 