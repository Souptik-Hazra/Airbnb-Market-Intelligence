-- =========================================================
-- 02 INTERMEDIATE SQL QUERIES
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- Query 1
-- Number of Listings in Each City
-- =========================================================

SELECT
    city,
    COUNT(*) AS total_listings
FROM listings
GROUP BY city
ORDER BY total_listings DESC;


-- =========================================================
-- Query 2
-- Average Price by City
-- =========================================================

SELECT
    city,
    ROUND(AVG(price)::numeric,2) AS average_price
FROM listings
GROUP BY city
ORDER BY average_price DESC;


-- =========================================================
-- Query 3
-- Average Rating by City
-- =========================================================

SELECT
    city,
    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating
FROM listings
GROUP BY city
ORDER BY average_rating DESC;


-- =========================================================
-- Query 4
-- Total Listings by Room Type
-- =========================================================

SELECT
    room_type,
    COUNT(*) AS listings
FROM listings
GROUP BY room_type
ORDER BY listings DESC;


-- =========================================================
-- Query 5
-- Average Price by Room Type
-- =========================================================

SELECT
    room_type,
    ROUND(AVG(price)::numeric,2) AS average_price
FROM listings
GROUP BY room_type
ORDER BY average_price DESC;


-- =========================================================
-- Query 6
-- Total Listings by Property Type
-- =========================================================

SELECT
    property_type,
    COUNT(*) AS total_properties
FROM listings
GROUP BY property_type
ORDER BY total_properties DESC;


-- =========================================================
-- Query 7
-- Top 10 Hosts by Number of Listings
-- =========================================================

SELECT
    host_id,
    COUNT(*) AS total_listings
FROM listings
GROUP BY host_id
ORDER BY total_listings DESC
LIMIT 10;


-- =========================================================
-- Query 8
-- Cities Having More Than 1000 Listings
-- =========================================================

SELECT
    city,
    COUNT(*) AS total_listings
FROM listings
GROUP BY city
HAVING COUNT(*) > 1000
ORDER BY total_listings DESC;


-- =========================================================
-- Query 9
-- Room Types Having Average Price Greater Than 150
-- =========================================================

SELECT
    room_type,
    ROUND(AVG(price)::numeric,2) AS avg_price
FROM listings
GROUP BY room_type
HAVING AVG(price) > 150
ORDER BY avg_price DESC;


-- =========================================================
-- Query 10
-- Superhosts by City
-- =========================================================

SELECT
    city,
    COUNT(*) AS superhosts
FROM listings
WHERE host_is_superhost = TRUE
GROUP BY city
ORDER BY superhosts DESC;


-- =========================================================
-- Query 11
-- Instant Bookable Listings by City
-- =========================================================

SELECT
    city,
    COUNT(*) AS instant_bookings
FROM listings
WHERE instant_bookable = TRUE
GROUP BY city
ORDER BY instant_bookings DESC;


-- =========================================================
-- Query 12
-- Average Bedrooms by Property Type
-- =========================================================

SELECT
    property_type,
    ROUND(AVG(bedrooms)::numeric,2) AS avg_bedrooms
FROM listings
GROUP BY property_type
ORDER BY avg_bedrooms DESC;


-- =========================================================
-- Query 13
-- Price Category using CASE
-- =========================================================

SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price BETWEEN 100 AND 300 THEN 'Standard'
        WHEN price BETWEEN 301 AND 700 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_category,
    COUNT(*) AS listings
FROM listings
GROUP BY price_category
ORDER BY listings DESC;


-- =========================================================
-- Query 14
-- Average Rating by Room Type
-- =========================================================

SELECT
    room_type,
    ROUND(AVG(review_scores_rating)::numeric,2) AS avg_rating
FROM listings
GROUP BY room_type
ORDER BY avg_rating DESC;


-- =========================================================
-- Query 15
-- Top 10 Cities by Average Rating
-- =========================================================

SELECT
    city,
    ROUND(AVG(review_scores_rating)::numeric,2) AS avg_rating
FROM listings
GROUP BY city
ORDER BY avg_rating DESC
LIMIT 10;


-- =========================================================
-- Query 16
-- Number of Reviews per Listing
-- =========================================================

SELECT
    listing_id,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY listing_id
ORDER BY total_reviews DESC
LIMIT 10;


-- =========================================================
-- Query 17
-- Listings with More Than 500 Reviews
-- =========================================================

SELECT
    listing_id,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY listing_id
HAVING COUNT(*) > 500
ORDER BY total_reviews DESC;


-- =========================================================
-- Query 18
-- Reviews by Year
-- =========================================================

SELECT
    EXTRACT(YEAR FROM review_date) AS review_year,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_year
ORDER BY review_year;


-- =========================================================
-- Query 19
-- Reviews by Month
-- =========================================================

SELECT
    EXTRACT(MONTH FROM review_date) AS review_month,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_month
ORDER BY review_month;


-- =========================================================
-- Query 20
-- Average Price by City and Room Type
-- =========================================================

SELECT
    city,
    room_type,
    ROUND(AVG(price)::numeric,2) AS average_price
FROM listings
GROUP BY city, room_type
ORDER BY city, average_price DESC;