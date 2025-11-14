select * from [listingsv2]

create table Property (
ID bigint,
Host_Total_Listings int,
Host_Verification varchar(max),
Host_Profile_Pic bit,
Host_Identity_Verified bit,
Listing_Neighborhood varchar(max),
Latitude float,
Longitude float,
Property_Info varchar(max),
Room_Info varchar(max)
)

Insert into [Property](ID) select id from [listingsv2]

select * from [Property]	

select 
    b.ID,
    t.host_total_listings_count,    
	t.host_verifications,
	t.host_has_profile_pic,
	t.host_identity_verified,
	t.neighbourhood_group_cleansed,
	t.latitude,
	t.longitude,
	t.property_type,
	t.room_type
FROM [Property] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

update b 
set
    b.ID = t.id,
    b.Host_Total_Listings = t.host_total_listings_count,    
	b.Host_Verification = t.host_verifications,
	b.Host_Profile_Pic = t.host_has_profile_pic,
	b.Host_Identity_Verified = t.host_identity_verified,
	b.Listing_Neighborhood = t.neighbourhood_group_cleansed,
	b.Latitude = t.latitude,
	b.Longitude = t.longitude,
	b.Property_Info = t.property_type,
	b.Room_Info = t.room_type
FROM [Property] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

ALTER TABLE Property
ALTER COLUMN Host_Profile_Pic VARCHAR(max); --Changing profile pic column from 0 and 1 to Y and N

ALTER TABLE Property
ALTER COLUMN Host_Identity_Verified VARCHAR(max); --Changing Identity verified column from 0 and 1 to Y and N

UPDATE Property
SET Host_Profile_Pic = CASE 
                    WHEN Host_Profile_Pic = 1 THEN 'Y'
                    WHEN Host_Profile_Pic = 0 THEN 'N'
                  END;
UPDATE  Property
SET Host_Identity_Verified= CASE 
                    WHEN Host_Identity_Verified = 1 THEN 'Y'
                    WHEN Host_Identity_Verified = 0 THEN 'N'
                  END;

				  
alter table Property
add Accomodations int,
Bathrooms int,
Bathroom_Info varchar(max),
Bedrooms int,
Beds int

update b 
set
	b.Accomodations = t.accommodates,
	b.Bathrooms = t.bathrooms,
	b.Bathroom_Info = t.bathrooms_text,
	b.Bedrooms = t.bedrooms,
	b.Beds = t.beds
FROM [Property] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

alter table Property
add Bathrooms float, Bathroom_Info varchar(max)  -- Changing the two columns' datatypes in order to merge them into a new column to remove null values

alter table Property
alter column Bathrooms_Updated varchar(max)

	UPDATE Property
SET Bathroom_Info = 0
WHERE Bathroom_Info IS NULL;

update Property
set Bathroom_Info = 0.5
Where Bathroom_Info = 'Half-Bath' OR Bathroom_Info = 'Shared half-Bath' OR Bathroom_Info = 'Private half-bath'

UPDATE Property
SET Bathroom_Info = LEFT(Bathroom_Info, 
                         PATINDEX('%[^0-9.]%', Bathroom_Info + 'x') - 1)
WHERE Bathroom_Info LIKE '%[0-9]%';

UPDATE Property
SET Bathrooms_Updated = COALESCE(Bathrooms, Bathroom_Info);


alter table Property
drop column Bathrooms, Bathroom_Info

update b 
set
	b.Bathrooms = t.bathrooms,
	b.Bathroom_Info = t.bathrooms_text
FROM [Property] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

update Property
set Bedrooms = 0
where Bedrooms is null

update Property
set Beds = 0
where Beds is null

alter table Property
alter column Bathrooms_Updated decimal (18,2)

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Property'

select * from Property