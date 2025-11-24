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

-- Inserting IDs into new table before starting the join process

select * from [Property]	

select * from [listingsv2]

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
ALTER COLUMN Host_Profile_Pic VARCHAR(max); 

ALTER TABLE Property
ALTER COLUMN Host_Identity_Verified VARCHAR(max); 

UPDATE Property
SET Host_Profile_Pic = CASE 
                    WHEN Host_Profile_Pic = 1 THEN 'Y'
                    WHEN Host_Profile_Pic = 0 THEN 'N'
                  END; 
				  
--Changing profile pic column from 0 and 1 to Y and N

UPDATE  Property
SET Host_Identity_Verified= CASE 
                    WHEN Host_Identity_Verified = 1 THEN 'Y'
                    WHEN Host_Identity_Verified = 0 THEN 'N'
                  END; 
				  
--Changing Identity verified column from 0 and 1 to Y and N

				  
alter table Property
add Accomodations int,
Bathrooms int,
Bathroom_Info varchar(max),
Bedrooms int,
Beds int

-- Adding new columns to the table as I believed it's relevant to the table content (Property)

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
add Bathrooms float, Bathroom_Info varchar(max)  


alter table Property
alter column Bathrooms_Updated varchar(max)    -- Changing the two columns' datatypes in order to merge them into a new column to remove null values


	UPDATE Property
SET Bathroom_Info = 0
WHERE Bathroom_Info IS NULL;

update Property
set Bathroom_Info = 0.5
Where Bathroom_Info = 'Half-Bath' OR Bathroom_Info = 'Shared half-Bath' OR Bathroom_Info = 'Private half-bath'

-- Filling in null values in bathroom info with 0.5 if they say half bath in any capacity

UPDATE Property
SET Bathroom_Info = LEFT(Bathroom_Info, 
                         PATINDEX('%[^0-9.]%', Bathroom_Info + 'x') - 1)
WHERE Bathroom_Info LIKE '%[0-9]%';

-- Removing any text at the end of each cell so that only digits and dots remain, before merging the 2 columns into 1

UPDATE Property
SET Bathrooms_Updated = COALESCE(Bathrooms, Bathroom_Info);

-- Merging columns to form a new one


alter table Property
drop column Bathrooms, Bathroom_Info

-- Deleting the two old columns

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

-- Filling in null values, may be subject to change in accordance with data provider

alter table Property
alter column Bathrooms_Updated decimal (18,2)

-- Changing varchar datatype column to decimal

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Property'

-- Viewing to see if all the columns' datatypes are correct

select * from Property