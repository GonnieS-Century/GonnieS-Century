select * from [global_freelancers_raw]

create table [Clean_Freelancers](
FreelancerID varchar(max),
Name varchar(max),
Gender varchar(max),
Age int,
Country varchar(max),
Language varchar(max),
Primary_Skill varchar(max),
Years_of_Experience int,
Hourly_Rate_USD int,
Rating Decimal (5,2),
Active varchar(max), 
Client_Satisfaction int
)

select * from Clean_Freelancers

Insert into [Clean_Freelancers](FreelancerID) select freelancerID from [gender_type]

update c
set c.Name = gt.name,
c.Gender = gt.gender
from [Clean_Freelancers] c
left join [gender_type] gt
on c.FreelancerID = gt.freelancerID

update c
set c.Age = s.age,
c.Country = s.country,
c.Language = s.language,
c.Primary_Skill = s.primary_Skill,
c.Years_of_Experience = s.years_of_experience
from [Clean_Freelancers] c
left join [Skills] s
on c.FreelancerID = s.freelancerID

 update c
set c.Hourly_Rate_USD = sat.hourly_rate_USD,
c.Rating = sat.rating,
c.Active = sat.active,
c.Client_Satisfaction = sat.client_satisfaction
from [Clean_Freelancers] c
left join [Satisfaction] sat
on c.FreelancerID = sat.freelancerID