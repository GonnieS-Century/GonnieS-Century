Select  * from [dbo].[dirty_cafe_sales] 


SELECT	dirty.Transaction_ID,
		typ.ItemID,
		dirty.Quantity,
		dirty.Total_Spent,
		dirty.Payment_Method,
		dirty.Transaction_Date
INTO	[Clean_Cafe_Data]
FROM	[dirty_cafe_sales] dirty

LEFT JOIN	[Item_type] typ
ON	(dirty.Item = typ.Item_Name)
	AND dirty.Item != 'UNKNOWN'


SELECT	* FROM	[Clean_Cafe_Data]

SELECT 
    c.Transaction_ID,
    t.Item_Name,
    c.Quantity,    
	t.Price_Per_Unit,
    c.Total_Spent,
    c.Payment_Method,
    c.Transaction_Date
FROM [Clean_Cafe_Data] AS c
LEFT JOIN [Item_type] AS t
    ON c.ItemID = t.ItemID;

ALTER TABLE [Clean_Cafe_Data]
ADD Price_Per_Unit DECIMAL(10,2);

UPDATE c
SET c.Price_Per_Unit = t.Price_Per_Unit
FROM [Clean_Cafe_Data] c
INNER JOIN [Item_type] t
    ON c.ItemID = t.ItemID;

update [Clean_Cafe_Data]
set Quantity = coalesce(Quantity, (Total_Spent/Price_Per_Unit)),
Total_Spent = coalesce(Total_Spent, (Price_Per_Unit * Quantity)),
Price_Per_Unit = coalesce(Price_Per_Unit, (Total_Spent/Quantity));

alter table [Clean_Cafe_Data]
add PaymentID int, Payment_Method varchar(250)

alter table [Clean_Cafe_Data]
drop column Payment_Method, PaymentID

UPDATE c
SET c.Location = p.Location
FROM [Clean_Cafe_Data] c
INNER JOIN [dirty_cafe_sales] p
    ON c.Transaction_ID = p.Transaction_ID;

UPDATE c
SET c.Payment_Method = p.Payment_Method
FROM [Clean_Cafe_Data] c
Left JOIN [dirty_cafe_sales] p
    ON c.Transaction_ID = p.Transaction_ID

SELECT 
    c.Transaction_ID,
    c.Quantity,    
    c.Total_Spent,
    c.Payment_Method,
    c.Transaction_Date,
	c.PaymentID
FROM [Clean_Cafe_Data] AS c
LEFT JOIN [transaction_type] AS t
    ON c.PaymentID = t.PaymentID;



update [Clean_Cafe_Data]
    CASE 
        WHEN c.Payment_Method IS NULL 
             OR c.Payment_Method IN ('NULL', 'UNKNOWN', 'ERROR') THEN tt.Payment_Method
        ELSE c.Payment_Method
    END IS NOT NULL

SELECT 
    c.Transaction_ID,
    c.Payment_Method AS Old_Payment_Method,
    tt.Payment_Method AS New_Payment_Method
FROM Clean_Cafe_Data c
JOIN transaction_type tt ON c.PaymentID = tt.PaymentID

UPDATE c
SET c.PaymentID = p.PaymentID
FROM [Clean_Cafe_Data] c
Left JOIN [transaction_type] p
    ON c.Payment_Method = p.Payment_Method

UPDATE Clean_Cafe_Data
SET Location = 'UNKNOWN'
WHERE Location IS NULL 
   OR Location = 'ERROR';

select * from [Clean_Cafe_Data]

alter table [clean_cafe_data]
add Transaction_Date date

UPDATE c
SET c.Transaction_Date = p.Transaction_Date
FROM [Clean_Cafe_Data] c
Left JOIN [dirty_cafe_sales] p
    ON c.Transaction_ID = p.Transaction_ID

UPDATE Clean_Cafe_Data
SET Transaction_Date = '2022-01-01'
WHERE Transaction_Date IS NULL 

UPDATE Clean_Cafe_Data
SET Payment_Method = 'UNKNOWN'
WHERE Payment_Method IS NULL 
   OR Payment_Method = 'ERROR';


--- The calculations for total_spent are already finished ---
--- Just have to fill in the null values in the Item_Name ---


select * from [Clean_Cafe_Data]

;WITH UniquePrices AS (
    SELECT 
        Price_Per_Unit,
        MAX(ItemID) AS ItemID,
        MAX(Item_Name) AS Item_Name
    FROM [Clean_Cafe_Data]
    WHERE ItemID IS NOT NULL AND Item_Name IS NOT NULL
    GROUP BY Price_Per_Unit
    HAVING COUNT(DISTINCT Item_Name) = 1
)
UPDATE c1
SET 
    c1.ItemID = 
        CASE 
            WHEN u.ItemID IS NOT NULL THEN u.ItemID 
            ELSE -1  -- or NULL if you prefer
        END,
    c1.Item_Name = 
        CASE 
            WHEN u.Item_Name IS NOT NULL THEN u.Item_Name 
            ELSE 'UNKNOWN'
        END
FROM [Clean_Cafe_Data] c1
LEFT JOIN UniquePrices u
    ON c1.Price_Per_Unit = u.Price_Per_Unit
WHERE c1.ItemID IS NULL OR c1.Item_Name IS NULL;  -- This script is to replace null values in Item ID and Item_Name with corresponding values in Price column.



update Clean_Cafe_Data 
set PaymentID =
case when PaymentID IS NOT NULL then PaymentID
else 1
end


--//--

select coalesce(Quantity, (Total_Spent/Price_Per_Unit)) as Quantity,
coalesce(Total_Spent, (Price_Per_Unit * Quantity)) as Total_Spent,
coalesce(Price_Per_Unit, (Total_Spent/Quantity)) as Price_Per_Unit
from [dbo].[dirty_cafe_sales]  -- equation used to determine the values to replace the nulls in the respective columns, if applicable


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Item_type'

