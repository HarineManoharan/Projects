CREATE DATABASE sql_project


CREATE TABLE NSW_Property 
(
 State nvarchar(50),
 City_Town  nvarchar(50),
 Suburb    nvarchar(50),
 Postcode int,
 District nvarchar(50) NULL,
 Location nvarchar(50) NULL,
 Property_Median_value Decimal(10,2) NULL
 )

CREATE TABLE AUS_Postcode
(
 Postcode int,
 Suburb nvarchar(50),
 City nvarchar(50),
 State nvarchar(50),
 state_code nvarchar(5),
 latitude Decimal(10,6) PRIMARY KEY,
 Longitude Decimal (10,6),
 District nvarchar(50) NULL
 )

--1.Find out the number of cities in each state. 
SELECT 
  State,
  COUNT (DISTINCT City) Number_of_cities 
FROM AUS_Postcode 
GROUP BY State
ORDER BY Number_of_cities  DESC




--2.Find out the number of unique postcodes, and suburbs in each city .
SELECT 
  City,
  State,
  COUNT(DISTINCT postcode) AS Unique_postcodes,
  COUNT (DISTINCT Suburb) AS Unique_Suburbs
FROM AUS_Postcode 
WHERE City IS NOT NULL 
GROUP BY City,State
ORDER BY 
 Unique_Suburbs DESC,
 Unique_postcodes DESC

--3.Query the Average Property Median Value by Suburb, and by Postcode separately, and then by Suburb and Postcode together. Then put Where condition to remove those records where there is no median value.


SELECT 
  Suburb,
  AVG(Property_median_value) AS avg_property_median_value
FROM NSW_Property 
WHERE suburb IS NOT NULL AND Property_Median_value IS NOT NULL
GROUP BY Suburb
ORDER BY avg_property_median_value DESC



SELECT 
  Postcode,
  AVG(Property_median_value) AS avg_property_median_value
FROM NSW_Property 
WHERE Property_Median_value IS NOT NULL
GROUP BY Postcode
ORDER BY avg_property_median_value DESC



SELECT 
  Suburb,
  Postcode,
  AVG(Property_median_value) AS avg_property_median_value
FROM NSW_Property 
WHERE Property_median_value IS NOT NULL
GROUP BY 
  Suburb,
  Postcode
ORDER BY avg_property_median_value DESC

