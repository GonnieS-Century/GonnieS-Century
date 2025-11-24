select * from [listingsv2]

create table Reviews(
ID bigint,
Number_of_Reviews int,
Number_of_Reviews_30d int,
Availability_EndofYear int,
Number_of_Reviews_LastYear int,
Estimated_Occupancy_last365d int,
Estimated_Revenue_last365d int,
First_Review date,
Last_Review date,
Review_Scores_Rating float,
Review_Scores_Accuracy float,
Review_Scores_Cleanliness float,
Review_Scores_Checking float,
Review_Scores_Comm float,
Review_Scores_Location float,
Review_Scores_Value float,
License varchar(max),
Instant_Bookable bit,
Reviews_Monthly decimal(18,2)
)

Insert into [Reviews](ID) select id from [listingsv2]

update b 
set
    b.Number_of_Reviews = t.number_of_reviews,    
	b.Number_of_Reviews_30d = t.number_of_reviews_l30d,
	b.Availability_EndofYear = t.availability_eoy,
	b.Number_of_Reviews_LastYear = t.number_of_reviews_ly,
	b.Estimated_Occupancy_last365d = t.estimated_occupancy_l365d,
	b.Estimated_Revenue_last365d = t.estimated_revenue_l365d,
	b.First_Review = t.first_review,
	b.Last_Review = t.last_review,
	b.Review_Scores_Rating = t.review_scores_rating,
	b.Review_Scores_Accuracy = t.review_scores_accuracy,
	b.Review_Scores_Cleanliness = t.review_scores_cleanliness,
	b.Review_Scores_Checking = t.review_scores_checkin,
	b.Review_Scores_Comm = t.review_scores_communication,
	b.Review_Scores_Location = t.review_scores_location,
	b.Review_Scores_Value = t.review_scores_value,
	b.License = t.license,
	b.Instant_Bookable = t.instant_bookable,
	b.Reviews_Monthly = t.reviews_per_month
FROM [Reviews] AS b
LEFT JOIN [listingsv2] AS t
    ON b.ID = t.id;

select * from Reviews

update Reviews
set Estimated_Revenue_last365d = 0
where Estimated_Revenue_last365d is null

update REviews
set First_Review = '1000-01-01'
Where First_Review = '1999-01-01' 

-- Filling in null values as appropriately as I can
-- I previously updated the first review column to insert 1999 for null values, but decided to change to 1000 afterwards, for better understanding on what needs to be filled later

update Reviews
set
Review_Scores_Rating = coalesce(Review_Scores_Rating, 0.00),
Review_Scores_Accuracy = coalesce(Review_Scores_Accuracy, 0.00),
Review_Scores_Cleanliness = coalesce(Review_Scores_Cleanliness, 0.00),
Review_Scores_Checking = coalesce(Review_Scores_Checking, 0.00),
Review_Scores_Comm = coalesce(Review_Scores_Comm, 0.00),
Review_Scores_Location = coalesce(Review_Scores_Location, 0.00),
Review_Scores_Value = coalesce(Review_Scores_Value, 0.00),
License = coalesce(License, 'N/A'),
Reviews_Monthly = coalesce(Reviews_Monthly, 0.00)
where Review_Scores_Rating is null
or Review_Scores_Accuracy is null
or Review_Scores_Cleanliness is null
or Review_Scores_Checking is null
or Review_Scores_Comm is null
or Review_Scores_Location is null
or Review_Scores_Value is null
or License is null
or Reviews_Monthly is null;

-- Filling in null values with more appropriate values. Subject to change in accordance with data provider

ALTER TABLE Reviews
ALTER COLUMN Instant_Bookable VARCHAR(max);

UPDATE Reviews
SET Instant_Bookable = CASE 
                    WHEN Instant_Bookable = 1 THEN 'Y'
                    WHEN Instant_Bookable = 0 THEN 'N'
                  END;

-- Converting boolian values into Y and N