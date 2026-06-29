-- =========================================================
-- 03 ADVANCED SQL QUERIES
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- Query 1
-- Top 10 Highest Revenue Potential Cities
-- =========================================================

SELECT
    city,
    COUNT(*) AS listings,
    SUM(price) AS total_revenue
FROM listings
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 10;


-- =========================================================
-- Query 2
-- Top 10 Highest Revenue Hosts
-- =========================================================

SELECT
    host_id,
    COUNT(*) AS listings,
    SUM(price) AS revenue
FROM listings
GROUP BY host_id
ORDER BY revenue DESC
LIMIT 10;


-- =========================================================
-- Query 3
-- Cities Above Overall Average Price
-- =========================================================

SELECT
    city,
    ROUND(AVG(price)::numeric,2) AS avg_price
FROM listings
GROUP BY city
HAVING AVG(price) >
(
    SELECT AVG(price)
    FROM listings
)
ORDER BY avg_price DESC;


-- =========================================================
-- Query 4
-- Listings Above City Average Price
-- =========================================================

SELECT
    l.listing_id,
    l.city,
    l.price
FROM listings l
JOIN
(
    SELECT
        city,
        AVG(price) avg_price
    FROM listings
    GROUP BY city
) c
ON l.city=c.city
WHERE l.price>c.avg_price
ORDER BY l.city;


-- =========================================================
-- Query 5
-- Top Reviewed Listings
-- =========================================================

SELECT
    l.listing_id,
    l.name,
    COUNT(r.review_id) reviews
FROM listings l
JOIN reviews r
ON l.listing_id=r.listing_id
GROUP BY l.listing_id,l.name
ORDER BY reviews DESC
LIMIT 20;


-- =========================================================
-- Query 6
-- Listings Without Reviews
-- =========================================================

SELECT
    listing_id,
    name,
    city
FROM listings
WHERE listing_id NOT IN
(
    SELECT DISTINCT listing_id
    FROM reviews
);


-- =========================================================
-- Query 7
-- Top Rated Listing Per City
-- =========================================================

WITH ranked AS
(
SELECT
city,
listing_id,
name,
review_scores_rating,
ROW_NUMBER() OVER
(
PARTITION BY city
ORDER BY review_scores_rating DESC
) rn
FROM listings
)

SELECT *
FROM ranked
WHERE rn=1;


-- =========================================================
-- Query 8
-- Most Common Property Type in Each City
-- =========================================================

WITH cte AS
(
SELECT
city,
property_type,
COUNT(*) total,
ROW_NUMBER() OVER
(
PARTITION BY city
ORDER BY COUNT(*) DESC
) rn
FROM listings
GROUP BY city,property_type
)

SELECT
city,
property_type,
total
FROM cte
WHERE rn=1;


-- =========================================================
-- Query 9
-- Hosts Having More Than 20 Listings
-- =========================================================

SELECT
host_id,
COUNT(*) total_listings
FROM listings
GROUP BY host_id
HAVING COUNT(*)>20
ORDER BY total_listings DESC;


-- =========================================================
-- Query 10
-- Price Difference From City Average
-- =========================================================

SELECT
listing_id,
city,
price,

price-
AVG(price) OVER
(
PARTITION BY city
) difference
FROM listings;


-- =========================================================
-- Query 11
-- Review Count by City
-- =========================================================

SELECT
l.city,
COUNT(r.review_id) reviews
FROM listings l
JOIN reviews r
ON l.listing_id=r.listing_id
GROUP BY l.city
ORDER BY reviews DESC;


-- =========================================================
-- Query 12
-- Average Rating by Property Type
-- =========================================================

SELECT
property_type,
ROUND(AVG(review_scores_rating)::numeric,2) rating
FROM listings
GROUP BY property_type
ORDER BY rating DESC;


-- =========================================================
-- Query 13
-- Average Price by Bedrooms
-- =========================================================

SELECT
bedrooms,
ROUND(AVG(price)::numeric,2) avg_price
FROM listings
GROUP BY bedrooms
ORDER BY bedrooms;


-- =========================================================
-- Query 14
-- Listings Costing More Than City Average
-- =========================================================

SELECT *
FROM listings l
WHERE price>
(
SELECT AVG(price)
FROM listings
WHERE city=l.city
);


-- =========================================================
-- Query 15
-- Average Review Count Per Listing
-- =========================================================

SELECT
ROUND(AVG(review_count)::numeric,2)
AS avg_reviews
FROM
(
SELECT
listing_id,
COUNT(*) review_count
FROM reviews
GROUP BY listing_id
)t;


-- =========================================================
-- Query 16
-- Hosts With Highest Average Rating
-- =========================================================

SELECT
host_id,
ROUND(AVG(review_scores_rating)::numeric,2) rating
FROM listings
GROUP BY host_id
HAVING COUNT(*)>=5
ORDER BY rating DESC
LIMIT 20;


-- =========================================================
-- Query 17
-- Most Expensive Listing in Each City
-- =========================================================

WITH ranked AS
(
SELECT
city,
listing_id,
price,
ROW_NUMBER() OVER
(
PARTITION BY city
ORDER BY price DESC
) rn
FROM listings
)

SELECT *
FROM ranked
WHERE rn=1;


-- =========================================================
-- Query 18
-- Cheapest Listing in Each City
-- =========================================================

WITH ranked AS
(
SELECT
city,
listing_id,
price,
ROW_NUMBER() OVER
(
PARTITION BY city
ORDER BY price
) rn
FROM listings
)

SELECT *
FROM ranked
WHERE rn=1;


-- =========================================================
-- Query 19
-- City Revenue Share
-- =========================================================

SELECT
city,
SUM(price) revenue,
ROUND(
SUM(price)*100.0/
SUM(SUM(price)) OVER(),
2
) revenue_percent
FROM listings
GROUP BY city
ORDER BY revenue DESC;


-- =========================================================
-- Query 20
-- Top 20 Listings by Rating Then Price
-- =========================================================

SELECT
listing_id,
name,
city,
review_scores_rating,
price
FROM listings
ORDER BY
review_scores_rating DESC,
price DESC
LIMIT 20;