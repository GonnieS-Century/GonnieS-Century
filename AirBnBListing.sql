create database [Project2]

select * from [listingsv2]

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'listingsv2'  -- See the data type of each column in case convert is necessary

create table [BetterDescription] (
ID bigint,
Name varchar(max),
Description varchar(max),
PictureURL varchar(max)
)  

-- For merging description and neighborhood from dirty data without destructive edit

select * from [BetterDescription]

Insert into [BetterDescription](Name) select name from [listingsv2] -- Always start join by inserting equivilant IDs into the new table first

INSERT INTO BetterDescription([Name])
SELECT CONVERT(varchar(max), name) 
FROM [listingsv2];

-- The datatype for name column in the raw data was nvarchar, so a convert statement was necessary

select
    b.ID,
    t.Name,    
	t.Description,
	t.picture_url,
	t.neighborhood_overview
FROM [BetterDescription] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

-- Preview before making the left join effective

UPDATE b
SET 
    b.Name = t.Name,
    b.Description = t.Description,
    b.pictureurl = t.picture_url,
    b.neighborhood = t.neighborhood_overview
FROM [BetterDescription] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

ALTER TABLE [BetterDescription]
DROP COLUMN Description, Neighborhood;

ALTER TABLE [BetterDescription] ADD Description_New VARCHAR(max);

UPDATE [BetterDescription]
SET Description_New = CONCAT(Description, ' ', Neighborhood);

-- Merging the description and neighborhood overview columns into one, since they seem logically interchangeable
