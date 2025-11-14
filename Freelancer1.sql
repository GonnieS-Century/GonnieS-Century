create database [Project3]

select * from [global_freelancers_raw]

create table [gender_type](
FreelancerID varchar(max),
Name varchar(max),
Gender varchar(max)
)

drop table [gender_type]

select * from [gender_type]

Insert into [gender_type](FreelancerID) select freelancer_ID from [global_freelancers_raw]

update c
set c.Name = gfr.name,
c.Gender = gfr.gender
from [gender_type] c
left join [global_freelancers_raw] gfr
on c.FreelancerID = gfr.freelancer_ID

update [gender_type]
set Gender = 'F'
where Gender like 'F%'

update [gender_type]
set Gender = 'M'
where Gender like 'M%'



SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'global_freelancers_raw'
