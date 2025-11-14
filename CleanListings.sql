select * from [listingsv2]

create table [Clean_Listings](
ID bigint,
Name varchar(max),
Description varchar(max),
PictureURL varchar(max),
HostID int,
HostName varchar(max),
Host_Since date,
HostLocation varchar(max),
Host_About varchar(max),
Host_ResponseTime varchar(max),
Host_ResponseRate varchar(max),
Host_SuperHost bit,
Host_Total_Listings int,
Host_Verification varchar(max),
Host_Profile_Pic bit,
Host_Identity_Verified bit,
Listing_Neighborhood varchar(max),
Latitude float,
Longitude float,
Property_Info varchar(max),
Room_Info varchar(max),
Amenities varchar(max),
Price money,
Minimum_Nights int,
Maximum_Nights int,
Minimum_Minimum_Nights int,
Maximum_Minimum_Nights int,
Minimum_Maximum_Nights int,
Maximum_Maximum_Nights int,
Minimum_Nights_Average float,
Maximum_Nights_Average float,
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

select * from [BetterDescription]

select * from [Clean_Listings]

Insert into [Clean_Listings](ID) select ID from [listingsv2]

UPDATE b
SET 
    b.ID = t.ID,
    b.Name = t.Name,
    b.Description = t.Description_New,
    b.pictureurl = t.pictureurl
FROM [Clean_Listings] AS b
LEFT JOIN [BetterDescription] AS t
    ON b.ID = t.ID;


ALTER TABLE [Clean_Listings]
ALTER COLUMN Host_SuperHost VARCHAR(max)

update b
set 
    b.HostID = t.Hostid,    
	b.HostName = t.hostname,
	b.Host_Since = t.host_since,
	b.HostLocation = t.hostlocation,
	b.Host_About = t.host_about,
	b.Host_ResponseTime = t.host_responsetime,
	b.Host_ResponseRate = t.host_responserate,
	b.Host_SuperHost = t.host_superhost
	FROM [Clean_Listings] AS b
LEFT JOIN [HostInfo] AS t
    ON b.ID = t.id;

ALTER TABLE [Clean_Listings]
ALTER COLUMN Host_Profile_Pic VARCHAR(max)

ALTER TABLE [Clean_Listings]
ALTER COLUMN Host_Identity_Verified VARCHAR(max)

update b 
set
    b.ID = t.id,
    b.Host_Total_Listings = t.host_total_listings,    
	b.Host_Verification = t.host_verification,
	b.Host_Profile_Pic = t.host_profile_pic,
	b.Host_Identity_Verified = t.host_identity_verified,
	b.Listing_Neighborhood = t.Listing_Neighborhood,
	b.Latitude = t.latitude,
	b.Longitude = t.longitude,
	b.Property_Info = t.Property_Info,
	b.Room_Info = t.Room_Info
FROM [Clean_Listings] AS b
LEFT JOIN [Property] AS t
    ON b.ID = t.id;


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
	b.Minimum_Nights_Average = t.Minimum_Nights_Average,
	b.Maximum_Nights_Average = t.Maximum_Nights_Average
FROM [Clean_Listings] AS b
LEFT JOIN [Nights_Spent] AS t
    ON b.ID = t.id;

	ALTER TABLE Clean_Listings
ALTER COLUMN Instant_Bookable VARCHAR(max);

update b 
set
    b.Number_of_Reviews = t.number_of_reviews,    
	b.Number_of_Reviews_30d = t.Number_of_Reviews_30d,
	b.Availability_EndofYear = t.Availability_EndofYear,
	b.Number_of_Reviews_LastYear = t.Number_of_Reviews_LastYear,
	b.Estimated_Occupancy_last365d = t.Estimated_Occupancy_last365d,
	b.Estimated_Revenue_last365d = t.Estimated_Revenue_last365d,
	b.First_Review = t.first_review,
	b.Last_Review = t.last_review,
	b.Review_Scores_Rating = t.review_scores_rating,
	b.Review_Scores_Accuracy = t.review_scores_accuracy,
	b.Review_Scores_Cleanliness = t.review_scores_cleanliness,
	b.Review_Scores_Checking = t.review_scores_checking,
	b.Review_Scores_Comm = t.review_scores_comm,
	b.Review_Scores_Location = t.review_scores_location,
	b.Review_Scores_Value = t.review_scores_value,
	b.License = t.license,
	b.Instant_Bookable = t.instant_bookable,
	b.Reviews_Monthly = t.Reviews_Monthly
FROM [Clean_Listings] AS b
LEFT JOIN [Reviews] AS t
    ON b.ID = t.id;


  -- 2nd highest number of reviews, for example, using Common Table Expressions (CTE)

with cte as (
select *, DENSE_RANK() over(order by number_of_reviews desc) [DR] from Clean_Listings
)

Select number_of_reviews from cte where DR = 2

  -- Sub Query along with Dense Rank

  select number_of_reviews as [2nd highest number] from (
  select *, DENSE_RANK() over(order by number_of_reviews desc) [DR] from Clean_Listings) x
  where DR = 2

   -- Sub Query

   select top 1 number_of_reviews [First highest number] from (
   select distinct top 2 number_of_reviews from Clean_Listings order by Number_of_Reviews desc) x
   order by Number_of_Reviews asc


	-- Top 3 rows with highest number of review

   select distinct top 3 number_of_reviews from Clean_Listings order by Number_of_Reviews desc

select * from Clean_Listings