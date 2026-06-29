-- =========================================================
-- 01 BASIC SQL QUERIES
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- Query 1
-- Total Listings
-- =========================================================

SELECT COUNT(*) AS total_listings
FROM listings;


-- =========================================================
-- Query 2
-- Total Reviews
-- =========================================================

SELECT COUNT(*) AS total_reviews
FROM reviews;


-- =========================================================
-- Query 3
-- Total Cities
-- =========================================================

SELECT COUNT(DISTINCT city) AS total_cities
FROM listings;


-- =========================================================
-- Query 4
-- Total Hosts
-- =========================================================

SELECT COUNT(DISTINCT host_id) AS total_hosts
FROM listings;


-- =========================================================
-- Query 5
-- Total Property Types
-- =========================================================

SELECT COUNT(DISTINCT property_type) AS property_types
FROM listings;


-- =========================================================
-- Query 6
-- Total Room Types
-- =========================================================

SELECT COUNT(DISTINCT room_type) AS room_types
FROM listings;


-- =========================================================
-- Query 7
-- Average Price
-- =========================================================

SELECT ROUND(AVG(price)::numeric,2) AS average_price
FROM listings;


-- =========================================================
-- Query 8
-- Minimum Price
-- =========================================================

SELECT MIN(price) AS minimum_price
FROM listings;


-- =========================================================
-- Query 9
-- Maximum Price
-- =========================================================

SELECT MAX(price) AS maximum_price
FROM listings;


-- =========================================================
-- Query 10
-- Average Bedrooms
-- =========================================================

SELECT ROUND(AVG(bedrooms)::numeric,2) AS average_bedrooms
FROM listings;


-- =========================================================
-- Query 11
-- Average Rating
-- =========================================================

SELECT ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating
FROM listings;


-- =========================================================
-- Query 12
-- Average Minimum Nights
-- =========================================================

SELECT ROUND(AVG(minimum_nights)::numeric,2) AS average_minimum_nights
FROM listings;


-- =========================================================
-- Query 13
-- Average Maximum Nights
-- =========================================================

SELECT ROUND(AVG(maximum_nights)::numeric,2) AS average_maximum_nights
FROM listings;


-- =========================================================
-- Query 14
-- Total Superhosts
-- =========================================================

SELECT COUNT(*) AS superhosts
FROM listings
WHERE host_is_superhost = TRUE;


-- =========================================================
-- Query 15
-- Total Instant Bookable Listings
-- =========================================================

SELECT COUNT(*) AS instant_bookable
FROM listings
WHERE instant_bookable = TRUE;


-- =========================================================
-- Query 16
-- Listings Having More Than 4 Bedrooms
-- =========================================================

SELECT COUNT(*) AS luxury_listings
FROM listings
WHERE bedrooms > 4;


-- =========================================================
-- Query 17
-- Listings Costing More Than 500
-- =========================================================

SELECT COUNT(*) AS expensive_listings
FROM listings
WHERE price > 500;


-- =========================================================
-- Query 18
-- Listings Rated Above 9
-- =========================================================

SELECT COUNT(*) AS highly_rated
FROM listings
WHERE review_scores_rating > 9;


-- =========================================================
-- Query 19
-- Listings Without Ratings
-- =========================================================

SELECT COUNT(*) AS listings_without_rating
FROM listings
WHERE review_scores_rating IS NULL;


-- =========================================================
-- Query 20
-- Top 10 Most Expensive Listings
-- =========================================================

SELECT
    listing_id,
    name,
    city,
    property_type,
    room_type,
    price
FROM listings
ORDER BY price DESC
LIMIT 10;