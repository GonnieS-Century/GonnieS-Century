select * from [global_freelancers_raw]

create table [Satisfaction](
FreelancerID varchar(max),
Hourly_Rate_USD varchar(max),
Rating Decimal (5,2),
Active bit, 
Client_Satisfaction varchar(max)
)

 drop table Satisfaction 

 select * from Satisfaction

 Insert into [Satisfaction](FreelancerID) select freelancer_ID from [global_freelancers_raw]

 update c
set c.Hourly_Rate_USD = gfr.hourly_rate_USD,
c.Rating = gfr.rating,
c.Active = gfr.is_active,
c.Client_Satisfaction = gfr.client_satisfaction
from [Satisfaction] c
left join [global_freelancers_raw] gfr
on c.FreelancerID = gfr.freelancer_ID


UPDATE Satisfaction
SET Hourly_Rate_USD = REPLACE(REPLACE(REPLACE(Hourly_Rate_USD, 'USD', ''), '$', ''), ' ', '');

update Satisfaction
set client_Satisfaction = Replace(client_Satisfaction, '%', '')

update Satisfaction
set active = 'N'
where Active = '0'

update Satisfaction
set active = 'Y'
where Active = '1'


alter table Satisfaction
alter column Active varchar(max)

alter table Satisfaction
alter column Hourly_Rate_USD int

alter table Satisfaction
alter column Client_Satisfaction int

update Satisfaction
set hourly_Rate_USD = '00'
where hourly_Rate_USD is null

update Satisfaction
set Rating = '9.99'
where Rating is null

update Satisfaction
set Active = 'NA'
where Active is null

update Satisfaction
set Client_Satisfaction = '00'
where Client_Satisfaction is null


