select * from [listingsv2]

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'listingsv2'

create table Nights_Spent (
ID bigint,
Amenities varchar(max),
Price money,
Minimum_Nights int,
Maximum_Nights int,
Minimum_Minimum_Nights int,
Maximum_Minimum_Nights int,
Minimum_Maximum_Nights int,
Maximum_Maximum_Nights int,
Minimum_Nights_Average float,
Maximum_Nights_Average float
)

Insert into [Nights_Spent](ID) select id from [listingsv2]

update b 
set
    b.Amenities = t.amenities,    
	b.Price = t.price,
	b.Minimum_Nights = t.minimum_nights,
	b.Maximum_Nights = t.maximum_nights,
	b.Minimum_Minimum_Nights = t.minimum_minimum_nights,
	b.Maximum_Minimum_Nights = t.maximum_minimum_nights,
	b.Minimum_Maximum_Nights = t.minimum_maximum_nights,
	b.Maximum_Maximum_Nights = t.maximum_maximum_nights,
	b.Minimum_Nights_Average = t.minimum_nights_avg_ntm,
	b.Maximum_Nights_Average = t.maximum_nights_avg_ntm
FROM [Nights_Spent] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

select * from Nights_Spent


	UPDATE Nights_Spent
SET Price = 0.00
WHERE Price IS NULL;