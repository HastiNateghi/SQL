/*Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet */


/* Yelp Dataset Profiling and Understanding:

^Profile the data by finding the total number of records for each of the tables below

^just replace each table name

^query to find the total number of records in the following tables 

+-------------------------+
| total_records_Attribute |
+-------------------------+
|                   10000 |
+-------------------------+

*/

SELECT COUNT(*) AS total_records_Attribute
FROM Attribute;
 

SELECT COUNT(*) AS total_records
FROM Business;

SELECT COUNT(*) AS total_records
FROM Category;






/* Query to find the total records using Primary or Foreign key in each following table. 
Can find the key in ER diagram using one-many relationships 

If two foreign keys are listed in the table, I specified that foreign key:
Table Tip has TWO FOREIGN KEYS


*/

SELECT COUNT(DISTINCT id) AS total_distinct_records
FROM Business;


SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Hours;

SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Attribute;


SELECT COUNT(DISTINCT user_id) AS total_distinct_records
FROM Tip;


SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Tip;





-- Archecking whether any columns with null values in the Users table? 

-- checking all the columns in User table to find any Null rows in any of the columns 
	
SELECT *
FROM User
WHERE id IS NULL OR name IS NULL OR review_count IS NULL OR yelping_since IS NULL 
OR useful IS NULL OR funny IS NULL OR cool IS NULL OR fans IS NULL  
OR average_stars IS NULL OR compliment_hot IS NULL OR compliment_more IS NULL 
OR compliment_profile IS NULL OR compliment_cute IS NULL OR compliment_list IS NULL 
OR compliment_note IS NULL OR compliment_plain IS NULL OR compliment_cool IS NULL
OR compliment_funny IS NULL OR compliment_writer IS NULL OR compliment_photos IS NULL;



	
-- For each table and column listed below, finding the smallest, largest , and average value:
-- EXAMPLE SQL CODE using aggregate functions:

SELECT

    MIN(stars) AS minimum,
    MAX(stars) AS maximum,
    AVG(stars) AS avgerage

FROM
    Review;





-- Listing the cities with the most reviews in descending order:
-- In this query, I group by the table by 'City' and Sum the number of reviews for each city

SELECT CITY,
SUM (REVIEW_count) AS tot_review
FROM BUSINESS

GROUP BY CITY
ORDER BY tot_review DESC;


	




	
-- Finding the distribution of star ratings to the business in the following cities:

SELECT stars AS star_rating, COUNT(*) AS count

FROM 
	Business

WHERE city = 'Avon'
GROUP BY star_rating;


SELECT stars AS star_rating, COUNT(*) AS count

FROM 
	Business

WHERE city = 'Beachwood'
GROUP BY star_rating;






-- Finding the top 3 users based on their total number of reviews:
-- to find the answer I had to use the User table and Review_count column based on the ER diagram

SELECT id, NAME,  REVIEW_COUNT

FROM user

ORDER BY REVIEW_COUNT DESC
LIMIT 3; 
	
		

		


/* !!!!ANSWERING BUSSINES QUESTION: 
	Does posing more reviews correlate with more fans???

	
 To answer this question
 I used a SQL query to group the User table based on the review_count 
 and then I summed the number of fans for each group

RESULTS:
Based on the first 25 rows returned, we can observe that there is no one-to-one correlation 
between the total review counts and the number of fans. 
For instance, the maximum review_count is 2000 with a total fans number of 253,
whereas a smaller review_count of 968 exhibits a higher summed fan count of 497. 
The findings suggest that there isn't a direct correlation between the total 
number of reviews posted by users and the number of fans they have. 
In other words, having a higher review count doesn't necessarily mean having more fans. 
My interpretation is that factors other than review activity could influence the number 
of fans a user has, such as the quality or popularity of their reviews.

 */

SELECT id, name, review_count, SUM(fans) AS sum_fans

FROM User

GROUP BY review_count
ORDER BY review_count DESC;





	
/*Are there more reviews with the word "love" or with the word "hate" in them?

SQL code used to arrive at answer:

I used subquery to write this SQL code and find the answer 

RESULT:

+------------+------------+
| love_count | hate_count |
+------------+------------+
|       1780 |        232 |
+------------+------------+

*/

SELECT 
    (SELECT COUNT(*) FROM review WHERE text LIKE '%love%') AS love_count,
    (SELECT COUNT(*) FROM review WHERE text LIKE '%hate%') AS hate_count;
	






-- Finding the top 10 users with the most fans:
-- this query finds the top 10 users with the most fans. 
	
SELECT id, name, fans

FROM User

ORDER BY fans DESC
LIMIT 10;





Inferences and Analysis

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
	

i. Do the two groups you chose to analyze have a different distribution of hours?

YES. 

I used the city 'Las Vegas' and the 'Shopping' category to compare businesse.
In 'Las Vegas', businesses in 'shopping' category with 2-3 star rating are open after 5 pm
while businesses in 'shopping' category with 4-5 star rating are not open after 5 pm.

Also I calculated the average opening and closing time for 2-3 star rating shopping businesses in Las Vegas and 
compared it with 4-5 star rating to find the difference in the  distribution of hours 
we can see the difference below:

+-------------------+-----------------+-----------------+
| star_rating_group |avg_opening_time | avg_closing_time 
+-------------------+-----------------+-----------------
| 2-3 Stars         |8.92             | 19.69           |                     
| 4-5 Stars         |8.0              | 16.42           |            
+-------------------+---------------+-------------------



ii. Do the two groups you chose to analyze have a different number of reviews?

YES.
         
4-5 star rating businesses in Las Vegas and in 'shopping' category have higher number of reviews (244 reviews)
compared to 2-3 star rating businesses (108) as we see below:

+-------------------+-----------------+
| star_rating_group | total_N_reviews |
+-------------------+-----------------+
| 2-3 Stars         |  108            |
| 4-5 Stars         |  244            |
+-------------------+-----------------+


         
iii. Are you able to infer anything from the location data provided between these two groups? Explain.

This table that returns by running the query attached below 

+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+
| star_rating_group | address                     | city      | state | postal_code | latitude | longitude | business_count |
+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+
| 2-3 Stars         | 3421 E Tropicana Ave, Ste I | Las Vegas | NV    | 89121       |  36.0994 |    -115.1 |              1 |
| 2-3 Stars         | 3808 E Tropicana Ave        | Las Vegas | NV    | 89121       |  36.1007 |  -115.091 |              1 |
| 4-5 Stars         | 1000 Scenic Loop Dr         | Las Vegas | NV    | 89161       |  36.1357 |  -115.428 |              1 |
| 4-5 Stars         | 3555 W Reno Ave, Ste F      | Las Vegas | NV    | 89118       |  36.0964 |  -115.187 |              1 |
+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+


SO we discuss the following:

Based on the location data provided, we can infer that businesses with 2-3 stars and businesses with 4-5 stars are located in different areas within Las Vegas. Specifically:

Businesses with 2-3 stars are located at addresses such as 3421 E Tropicana Ave and 3808 E Tropicana Ave.
Businesses with 4-5 stars are located at addresses such as 1000 Scenic Loop Dr and 3555 W Reno Ave.

Additionally, it could indicate potential differences in the types of businesses or demographics of customers in these areas, which may influence the ratings they receive.




SQL code used for analysis:




/* CODE 1 : I used the city 'Las Vegas' and the 'Shopping' category to compare businesses.
Then I developed my code by adding the opening hours, 
and average of the opening time and closing time of bussiness in each star rating sub-category
and then I added the review counts for comparison */


SELECT 
    CASE 
        WHEN b.stars >= 4 THEN '4-5 Stars'
        WHEN b.stars >= 2 AND b.stars < 4 THEN '2-3 Stars'
        ELSE '1 Star or Less'
    END AS star_rating_group,

    -- comparing average opening and closing time

    SUBSTR(h.HOURS, INSTR(h.HOURS, '|') + 1) AS OPENING_HOURS,
    AVG(SUBSTR(SUBSTR(h.HOURS, INSTR(h.HOURS, '|') + 1), 1, 2) * 1.0) AS avg_opening_time,
    AVG(SUBSTR(SUBSTR(h.HOURS, INSTR(h.HOURS, '-') + 1), 1, 2) * 1.0) AS avg_closing_time,

    -- comparing number of reviews

    SUM(b.review_count) as total_N_reviews

    -- joining tables
FROM 
    business b
INNER JOIN 
    hours h ON b.id = h.business_id
INNER JOIN 
    category c ON b.id = c.business_id

WHERE 
    b.city = 'Las Vegas' 
    AND c.category = 'Shopping'
GROUP BY 
    star_rating_group; 

RESULTS:

+-------------------+---------------+-------------------+--------------------+-----------------+
| star_rating_group | OPENING_HOURS |  avg_opening_time |   avg_closing_time | total_N_reviews |
+-------------------+---------------+-------------------+--------------------+-----------------+
| 2-3 Stars         | 8:00-22:00    | 8.923076923076923 | 19.692307692307693 |             108 |
| 4-5 Stars         | 8:00-17:00    |               8.0 | 16.416666666666668 |             244 |
+-------------------+---------------+-------------------+--------------------+-----------------+





/* CODE 2: to address the location question (number iii), I added the location columns into my code
and did group by by location information as follow */


SELECT 
    CASE 
        WHEN b.stars >= 4 THEN '4-5 Stars'
        WHEN b.stars >= 2 AND b.stars < 4 THEN '2-3 Stars'
        ELSE '1 Star or Less'
    END AS star_rating_group,
    b.address,
    b.city,
    b.state,
    b.postal_code,
    b. latitude,
    b.longitude,

    COUNT(*) AS business_count
FROM 
    business b
JOIN 
    category c ON b.id = c.business_id
WHERE 
    b.city = 'Las Vegas' 
    AND c.category = 'Shopping'
GROUP BY 
    star_rating_group, b.address, b.city, b.state, b.postal_code, b. latitude, b.longitude ;


RESULTS:
+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+
| star_rating_group | address                     | city      | state | postal_code | latitude | longitude | business_count |
+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+
| 2-3 Stars         | 3421 E Tropicana Ave, Ste I | Las Vegas | NV    | 89121       |  36.0994 |    -115.1 |              1 |
| 2-3 Stars         | 3808 E Tropicana Ave        | Las Vegas | NV    | 89121       |  36.1007 |  -115.091 |              1 |
| 4-5 Stars         | 1000 Scenic Loop Dr         | Las Vegas | NV    | 89161       |  36.1357 |  -115.428 |              1 |
| 4-5 Stars         | 3555 W Reno Ave, Ste F      | Las Vegas | NV    | 89118       |  36.0964 |  -115.187 |              1 |
+-------------------+-----------------------------+-----------+-------+-------------+----------+-----------+----------------+
		



		
2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:  bussiness counts and Average Review Count

Open businesses have a higher count (8480) compared to closed businesses (1520).


Open businesses have a higher average review count (269300) compared to closed businesses (35261).
      
         
ii. Difference 2: Average Star Rating

Open businesses tend to have a slightly higher average star rating (3.68) compared to closed businesses (3.52).
         
         
         
SQL code used for analysis:

/* I used case statement to find open and closed businesses,
 I also used review_count and stars columns to find the differences in this query */

SELECT
    CASE
        WHEN b.is_open = 1 THEN 'Open'
        ELSE 'Closed'
    END AS business_status,
    COUNT(*) AS business_count,
    SUM(b.review_count) AS SUM_review_count,
    AVG(b.stars) AS avg_star_rating
FROM
    business b
GROUP BY
    business_status;

RESULTS:

+-----------------+----------------+------------------+-------------------+
| business_status | business_count | SUM_review_count |   avg_star_rating |
+-----------------+----------------+------------------+-------------------+
| Closed          |           1520 |            35261 | 3.520394736842105 |
| Open            |           8480 |           269300 | 3.679009433962264 |
+-----------------+----------------+------------------+-------------------+




	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. Indicate the type of analysis you chose to do:
         
 In this project I want to help the businesses to predict the overall star rating. so they need to work toward improvment or make vital desicions.
         
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

To conduct this project and research, I gather all the data needed to help the business, so to assist businesses in understanding the critical factors contributing to their operational sustainability, we will emphasize various key metrics. These include the number of reviews, the business's star rating, operational hours, and notably, its geographical location. Gathering latitude and longitude coordinates alongside details such as city, state, postal code, and address will facilitate streamlined data processing in subsequent analyses. Additionally, leveraging categories and attributes will aid in distinguishing between various business types. Furthermore, the attribute is_open will delineate between active businesses and those that have permanently closed, distinct from those merely having no operating hours.

         
iv. Provide the SQL code you used to create your final dataset:


SELECT B.id,
			   B.name,
			   B.address,
			   B.city,
			   B.state,
			   B.postal_code,
			   B.latitude,
			   B.longitude,
			   B.review_count,
			   B.stars,
			   MAX(CASE
			   WHEN H.hours LIKE "%monday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS monday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%tuesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS tuesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%wednesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS wednesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%thursday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS thursday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%friday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS friday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%saturday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS saturday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%sunday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS sunday_hours,
			   GROUP_CONCAT(DISTINCT(C.category)) AS categories,
			   GROUP_CONCAT(DISTINCT(A.name)) AS attributes,
			   B.is_open
		FROM business B
		INNER JOIN hours H
		ON B.id = H.business_id
		INNER JOIN category C
		ON B.id = C.business_id
		GROUP BY B.id                           
                  
iii. Output of your finished dataset:

due to server limitation I just copied the first 25 rows:

+------------------------+-------------------------------+---------------------------------+---------------+-------+-------------+----------+-----------+--------------+-------+--------------+---------------+-----------------+----------------+--------------+----------------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------+---------+
| id                     | name                          | address                         | city          | state | postal_code | latitude | longitude | review_count | stars | monday_hours | tuesday_hours | wednesday_hours | thursday_hours | friday_hours | saturday_hours | sunday_hours | categories                                                                                                                                         | is_open |
+------------------------+-------------------------------+---------------------------------+---------------+-------+-------------+----------+-----------+--------------+-------+--------------+---------------+-----------------+----------------+--------------+----------------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------+---------+
| -0DET7VdEQOJVJ_v6klEug | Flaming Kitchen               | 3235 York Regional Road 7       | Markham       | ON    | L3R 3P9     |  43.8484 |  -79.3487 |           25 |   3.0 | 12:00-23:00  | 12:00-23:00   | 12:00-23:00     | 12:00-23:00    | 12:00-23:00  | 12:00-23:00    | 12:00-23:00  | Asian Fusion,Restaurants                                                                                                                           |       1 |
| -2HjuT4yjLZ3b5f_abD87Q | Freeman's Car Stereo          | 4821 South Blvd                 | Charlotte     | NC    | 28217       |  35.1727 |  -80.8755 |            8 |   3.5 | 9:00-19:00   | 9:00-19:00    | 9:00-19:00      | 9:00-19:00     | 9:00-19:00   | 9:00-17:00     | None         | Electronics,Shopping,Automotive,Car Stereo Installation                                                                                            |       1 |
| -3oxnPPPU3YoxO9M1I2idg | Eklectic Pie - Mesa           | 1859 S Stapley Dr, Ste 105-3    | Mesa          | AZ    | 85204       |  33.3799 |  -111.806 |          129 |   4.0 | 11:00-21:00  | 11:00-21:00   | 11:00-21:00     | 11:00-21:00    | 11:00-22:00  | 11:00-22:00    | 11:00-21:00  | Restaurants,Bars,Italian,Nightlife,Pizza,Salad,Gluten-Free                                                                                         |       0 |
| -9y2L9qSbqukVl8LzEOGdg | Wooly Wonders                 | 3421 E Tropicana Ave, Ste I     | Las Vegas     | NV    | 89121       |  36.0994 |    -115.1 |           11 |   3.5 | 10:00-16:00  | 10:00-19:00   | 10:00-16:00     | 10:00-19:00    | 10:00-16:00  | 10:00-16:00    | None         | Knitting Supplies,Shopping                                                                                                                         |       0 |
| -CdstAUdEvci8GeJG8owpQ | Motors & More                 | 2315 Highland Dr                | Las Vegas     | NV    | 89102       |  36.1465 |  -115.167 |            7 |   5.0 | 7:00-17:00   | 7:00-17:00    | 7:00-17:00      | 7:00-17:00     | 7:00-17:00   | 8:00-12:00     | None         | Home Services,Solar Installation,Heating & Air Conditioning/HVAC                                                                                   |       1 |
| -Eu04UHRqmGGyvYRDY8-tg | West Side Market              | 1979 W 25th St                  | Cleveland     | OH    | 44113       |  41.4847 |  -81.7031 |          723 |   4.5 | 7:00-16:00   | None          | 7:00-16:00      | None           | 7:00-18:00   | 7:00-18:00     | 10:00-16:00  | Shopping,Food,Seafood Markets,Fruits & Veggies,Ethnic Food,Market Stalls,Farmers Market,Specialty Food,Public Markets,Meat Shops                   |       1 |
| -K4gAv8_vjx8-2BxkVeRkA | Baby Cakes                    | 4145 Erie St                    | Willoughby    | OH    | 44094       |  41.6399 |  -81.4064 |            5 |   3.5 | None         | 11:00-17:00   | 11:00-17:00     | 11:00-20:00    | 11:00-17:00  | 10:00-17:00    | None         | Bakeries,Food                                                                                                                                      |       1 |
| -KWHuAnRPvNBIh2yhBC2kg | The Wine Mill                 | 4964 Akron Cleveland Rd         | Peninsula     | OH    | 44264       |  41.2043 |  -81.4954 |           42 |   4.5 | None         | 15:00-21:00   | 15:00-21:00     | 15:00-21:00    | 15:00-23:00  | 15:00-23:00    | 14:00-18:00  | Bars,Wine Bars,Nightlife                                                                                                                           |       1 |
| -OsPCfouYyJ3vjgOKBtzGA | Brubaker's Pub                | 5823 Darrow Rd                  | Hudson        | OH    | 44236       |  41.2237 |  -81.4394 |            5 |   3.0 | 11:00-2:30   | 11:00-2:30    | 11:00-2:30      | 11:00-2:30     | 11:00-2:30   | 11:00-2:30     | 12:00-2:30   | Bars,Restaurants,Nightlife,Pubs                                                                                                                    |       1 |
| -PtTGvWsckUL8tTutHr6Ew | Snip-its Rocky River          | 21609 Center Ridge Rd           | Rocky River   | OH    | 44116       |  41.4595 |  -81.8587 |           18 |   2.5 | 10:00-19:00  | 10:00-19:00   | 10:00-19:00     | 10:00-19:00    | 10:00-19:00  | 9:00-17:30     | 10:00-16:00  | Beauty & Spas,Hair Salons                                                                                                                          |       1 |
| -Ucy8i4uc_OzN8y5fkGVaQ | Taliesin West                 | 12621 N Frank Lloyd Wright Blvd | Scottsdale    | AZ    | 85259       |  33.6063 |  -111.845 |          223 |   4.5 | 8:30-14:30   | 8:30-17:00    | 8:30-17:00      | 8:30-14:30     | 8:30-20:00   | 8:30-15:00     | 8:30-15:00   | Arts & Entertainment,Tours,Local Flavor,Architects,Professional Services,Travel Services,Hotels & Travel,Museums,Architectural Tours               |       1 |
| -_Zd5p9FpWeGZitXFQ5t6Q | Fresh Bonsai Nails & Spa      | 9555 Yonge Street, Unit 7       | Richmond Hill | ON    | L4C 9M5     |  43.8595 |  -79.4337 |            7 |   1.5 | 9:30-19:00   | 9:30-19:00    | 9:30-19:00      | 9:30-19:00     | 9:30-19:00   | 9:30-18:00     | 9:30-16:00   | Day Spas,Beauty & Spas                                                                                                                             |       1 |
| -ayZoW_iNDsunYXX_0x1YQ | Standard Restaurant Supply    | 2922 E McDowell Rd              | Phoenix       | AZ    | 85008       |  33.4664 |  -112.018 |           15 |   3.5 | 8:00-18:00   | 8:00-18:00    | 8:00-18:00      | 8:00-18:00     | 8:00-18:00   | 9:00-17:00     | None         | Shopping,Wholesalers,Restaurant Supplies,Professional Services,Wholesale Stores                                                                    |       1 |
| -d9qyfNhLMQwVVg_raBKeg | What A Bagel                  | 973 Eglinton Avenue W           | York          | ON    | M6C 2C4     |  43.6999 |  -79.4295 |            8 |   3.0 | 6:00-15:30   | 6:00-15:30    | 6:00-15:30      | 6:00-15:30     | 6:00-15:30   | 6:00-15:30     | None         | Restaurants,Bagels,Breakfast & Brunch,Food                                                                                                         |       1 |
| -hjbcaxaU9yYXY2iI-49sw | Pinnacle Fencing Solutions    |                                 | Phoenix       | AZ    | 85060       |  33.4805 |  -111.997 |           13 |   4.0 | 8:00-16:00   | 8:00-16:00    | 8:00-16:00      | 8:00-16:00     | 8:00-16:00   | None           | None         | Home Services,Contractors,Fences & Gates                                                                                                           |       1 |
| -iu4FxdfxN4rU4Fu9BjiFw | Alterations Express           | 17240 Royalton Rd               | Strongsville  | OH    | 44136       |  41.3141 |  -81.8207 |            3 |   4.0 | 8:00-19:00   | 8:00-19:00    | 8:00-19:00      | 8:00-19:00     | 8:00-19:00   | 8:00-18:00     | None         | Shopping,Bridal,Dry Cleaning & Laundry,Local Services,Sewing & Alterations                                                                         |       1 |
| -j4NsiRzSMrMk2N_bGH_SA | Extra Space Storage           | 2880 W Elliot Rd                | Chandler      | AZ    | 85224       |  33.3496 |  -111.892 |            5 |   4.0 | 8:00-17:30   | 8:00-17:30    | 8:00-17:30      | 8:00-17:30     | 8:00-17:30   | 8:00-17:30     | 10:00-14:00  | Home Services,Self Storage,Movers,Shopping,Local Services,Home Decor,Home & Garden                                                                 |       1 |
| -n27mJ_jQWGCuIukTvg9Mg | Cabin Fever                   | 1669 Bloor Street W             | Toronto       | ON    | M6P 1A6     |  43.6553 |  -79.4567 |           26 |   4.5 | 16:00-2:00   | 18:00-2:00    | 18:00-2:00      | 18:00-2:00     | 18:00-2:00   | 16:00-2:00     | 16:00-2:00   | Cafes,Art Galleries,Arts & Entertainment,Restaurants,Books,Mags,Music & Video,Shopping,Coffee & Tea,Pubs,Bars,Food,Vinyl Records,Nightlife,Arcades |       1 |
| -sBfEBOoKgWcYhLXt7i3nw | Christian Brothers Automotive | 290 E Ocotillo Rd               | Chandler      | AZ    | 85249       |   33.248 |  -111.837 |           63 |   5.0 | 7:00-18:00   | 7:00-18:00    | 7:00-18:00      | 7:00-18:00     | 7:00-18:00   | None           | None         | Automotive,Auto Repair,Oil Change Stations,Transmission Repair                                                                                     |       1 |
| -tKN8LLme5IMC9AjzB9y9Q | A & A Traders                 | 56-60 Easter Road               | Edinburgh     | EDH   | EH7 5RQ     |  55.9586 |   -3.1717 |            6 |   3.5 | 9:00-18:00   | 9:00-18:00    | 9:00-18:00      | 9:00-18:00     | 9:00-18:00   | 9:00-18:00     | None         | Home & Garden,Shopping                                                                                                                             |       1 |
| -uiBBVWI6tMDm2JFbZFrOw | Gussied Up                    | 1090 Bathurst St                | Toronto       | ON    | M5R 1W5     |  43.6727 |  -79.4142 |            6 |   4.5 | None         | 11:00-19:00   | 11:00-19:00     | 11:00-19:00    | 11:00-19:00  | 11:00-17:00    | 12:00-16:00  | Women's Clothing,Shopping,Fashion                                                                                                                  |       1 |
| 0-aPEeNc2zVb5Gp-i7Ckqg | Buddy's Muffler & Exhaust     | 1509 Hickory Grove Rd           | Gastonia      | NC    | 28056       |  35.2772 |    -81.06 |            4 |   5.0 | 8:30-17:00   | 8:30-17:00    | 8:30-17:00      | 8:30-17:00     | 8:30-17:00   | 9:00-15:00     | None         | Automotive,Auto Repair                                                                                                                             |       1 |
| 01xXe2m_z048W5gcBFpoJA | Five Guys                     | 2641 N 44th St, Ste 100         | Phoenix       | AZ    | 85008       |   33.478 |  -111.986 |           63 |   3.5 | 10:00-22:00  | 10:00-22:00   | 10:00-22:00     | 10:00-22:00    | 10:00-22:00  | 10:00-22:00    | 10:00-22:00  | American (New),Burgers,Fast Food,Restaurants                                                                                                       |       1 |
| 035AcFz2oozXxkaHi83yaQ | Innercity MMA                 | 403 Dundas Street W             | Toronto       | ON    | M5T 1G6     |  43.6536 |  -79.3947 |            3 |   5.0 | 17:00-22:00  | 18:00-22:00   | 17:00-22:00     | 18:00-22:00    | 17:00-22:00  | None           | None         | Fitness & Instruction,Martial Arts,Active Life                                                                                                     |       1 |
| 06I2r8S3tHP_LwGnnkk6Uw | All Storage - Anthem          | 2620 W Horizon Ridge Pkwy       | Henderson     | NV    | 89052       |  36.0021 |  -115.102 |            3 |   3.5 | 9:00-16:30   | 9:00-16:30    | 9:00-16:30      | 9:00-16:30     | 9:00-16:30   | 9:00-16:30     | None         | Truck Rental,Local Services,Self Storage,Parking,Automotive                                                                                        |       1 |
+------------------------+-------------------------------+---------------------------------+---------------+-------+-------------+----------+-----------+--------------+-------+--------------+---------------+-----------------+----------------+--------------+----------------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------+---------+
