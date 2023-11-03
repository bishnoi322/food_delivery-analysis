CREATE DATABASE food_delivery;
USE food_delivery;
SELECT * FROM swiggy;
DESC swiggy;

# What are the overall sales trends for different restaurants ?
SELECT Restaurant,  SUM(Price) as Total_Sales
FROM swiggy 
GROUP BY Restaurant
ORDER BY Total_Sales DESC;
-- Oven Story Pizza, Mainland China and Barbeque Nation lead the overall sales trend. 

# What are the overall sales trends for food categories? 
SELECT Food_type, SUM(Price) as Total_Sales
FROM swiggy 
GROUP BY Food_type
ORDER BY Total_Sales DESC;
-- Although the top restaurants are of foreign food types, surprisingly Indian food is still a favourite followed by Chinese and North Indian. 


# In which areas or regions are the highest sales recorded? 
SELECT ID, Area, City, SUM(Price) AS TotalSales
FROM swiggy
GROUP BY Area,City
ORDER BY TotalSales DESC;
-- As one would guess the cities with highest sales are all metropolitan cities, That is, Mumbai, Delhi and Bangalore. This is due to their high population density and relative higher income housholds among many factors. 
 
# Can you identify areas with untapped sales potential?
SELECT ID, Area, City, COUNT(DISTINCT Restaurant) AS NumberOfRestaurants,
AVG(Price) AS AveragePrice, AVG(Avg_ratings) AS AverageRating, SUM(Total_ratings) AS TotalRatings,
COUNT(DISTINCT Food_type) AS NumberOfFoodTypes 
FROM swiggy 
GROUP BY Area, City
HAVING SUM(Total_ratings) < AVG(Total_ratings);
-- There seems to be an absence of any untapped potential as they have reached saturation atleast in all conventional ways. 

# How do order delivery times affect customer satisfaction and repeat business?
SELECT Delivery_time, AVG(Avg_ratings) as average_rating
FROM swiggy
GROUP BY Delivery_time
ORDER BY average_rating DESC;
-- Generally the restaurants with lowest delivery time have the highest ratings and this dataset reinforces that generalisation. 
 
# Can you identify any patterns in customer ordering behavior (e.g., recurring orders, popular combos)?
SELECT Food_type, COUNT(Food_type) as Frequency 
FROM swiggy 
GROUP BY Food_type
ORDER BY Frequency DESC;
-- As we have come to know earlier Indian food is the most frequently ordered food and this table shows us by how much and its a huge margin compared to other food type. 
 
SELECT Restaurant, COUNT(Restaurant) as Popularity 
FROM swiggy 
GROUP BY Restaurant
ORDER BY Popularity DESC;
-- Here the popularity competition is won by the La pino'Z pizza restaurant.
 
# How do the sales of your restaurant compare to competitors in the same area? 
SELECT Restaurant, SUM(Price) AS Total_Sales
FROM swiggy
WHERE City IN 
    (SELECT City 
     FROM swiggy 
     WHERE Restaurant = 'Keventers')
GROUP BY Restaurant;