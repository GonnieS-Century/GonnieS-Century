select * from [global_freelancers_raw]

create table [Skills] (
FreelancerID varchar(max),
Age float,
Country varchar(max),
Language varchar(max),
Primary_Skill varchar(max),
Years_of_Experience float
)

Drop table skills

Insert into [Skills](FreelancerID) select freelancer_ID from [global_freelancers_raw]

select * from Skills
where years_of_Experience is null

update c
set c.Age = gfr.age,
c.Country = gfr.country,
c.Language = gfr.language,
c.Primary_Skill = gfr.primary_Skill,
c.Years_of_Experience = gfr.years_of_experience
from [Skills] c
left join [global_freelancers_raw] gfr
on c.FreelancerID = gfr.freelancer_ID

Alter table Skills
alter column Age int

Alter table Skills
alter column Years_of_Experience int

update Skills
set Age = coalesce(Age, (18 + Years_of_Experience))
where Age is null

update skills
set age = '0'
where Age is null

update skills 
set Years_of_Experience = '99'
where years_of_Experience is null