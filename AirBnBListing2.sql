select * from [listingsv2]

create table [HostInfo] (
ID bigint,
HostID int,
HostName varchar(max),
Host_Since date,
HostLocation varchar(max),
Host_About varchar(max),
Host_ResponseTime varchar(max),
Host_ResponseRate varchar(max),
Host_SuperHost bit
)

select * from [HostInfo]

select host_neighbourhood, neighbourhood_cleansed from [listingsv2]

Insert into [HostInfo](ID) select id from [listingsv2]

select
    b.ID,
    t.Host_id,    
	t.host_name,
	t.host_since,
	t.host_location,
	t.host_about,
	t.host_response_time,
	t.host_response_rate,
	t.host_is_superhost
FROM [HostInfo] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

update b
set 
    b.HostID = t.Host_id,    
	b.HostName = t.host_name,
	b.Host_Since = t.host_since,
	b.HostLocation = t.host_location,
	b.Host_About = t.host_about,
	b.Host_ResponseTime = t.host_response_time,
	b.Host_ResponseRate = t.host_response_rate,
	b.Host_SuperHost = t.host_is_superhost
	FROM [HostInfo] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

	UPDATE HostInfo
SET HostLocation = ''
WHERE HostLocation IS NULL;

	UPDATE HostInfo
SET Host_About = ''
WHERE Host_About IS NULL;

alter table [HostInfo]
add Host_Neighborhood varchar(max)

update b
set b.Host_Neighborhood = t.neighbourhood_cleansed
from [HostInfo] b
left join [listingsv2] t
on b.ID = t.ID

alter table [HostInfo]
add Listing_Neighborhood varchar(max)

update b
set b.Listing_Neighborhood = t.neighbourhood_group_cleansed
from [HostInfo] b
left join [listingsv2] t
on b.ID = t.ID


	UPDATE HostInfo
SET Host_SuperHost = ''
WHERE Host_SuperHost IS NULL;

SELECT 
  CASE 
    WHEN Host_SuperHost = 1 THEN 'Yes'
    WHEN Host_SuperHost = 0 THEN 'No'
    ELSE NULL
  END AS Host
FROM HostInfo;  -- viewing the 0 and 1 value changes before applying them

ALTER TABLE HostInfo
ALTER COLUMN Host_SuperHost VARCHAR(max); -- Changing superhost column to varchar

UPDATE HostInfo
SET Host_SuperHost = CASE 
                    WHEN Host_SuperHost = 1 THEN 'Y'
                    WHEN Host_SuperHost = 0 THEN 'N'
                  END;

-- TO DO TUESDAY FOR THIS TABLE!!!!!
-- CONVERT NULL VALUES TO 0, THEN CONVERT 0 AND 1 TO NO AND YES, RESPECTIVELY!!!!! 