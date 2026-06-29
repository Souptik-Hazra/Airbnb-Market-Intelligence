-- =========================================================
-- 06 BUSINESS QUESTIONS
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- Question 1
-- Which cities generate the highest estimated revenue?
-- =========================================================

SELECT
    city,
    COUNT(*) AS listings,
    SUM(price) AS estimated_revenue
FROM listings
GROUP BY city
ORDER BY estimated_revenue DESC;


-- =========================================================
-- Question 2
-- Which hosts own the most listings?
-- =========================================================

SELECT
    host_id,
    COUNT(*) AS total_listings
FROM listings
GROUP BY host_id
ORDER BY total_listings DESC
LIMIT 20;


-- =========================================================
-- Question 3
-- Which cities have the highest average listing price?
-- =========================================================

SELECT
    city,
    ROUND(AVG(price)::numeric,2) AS average_price
FROM listings
GROUP BY city
ORDER BY average_price DESC;


-- =========================================================
-- Question 4
-- Which room type earns the highest average price?
-- =========================================================

SELECT
    room_type,
    ROUND(AVG(price)::numeric,2) AS average_price
FROM listings
GROUP BY room_type
ORDER BY average_price DESC;


-- =========================================================
-- Question 5
-- Which property types are most common?
-- =========================================================

SELECT
    property_type,
    COUNT(*) AS listings
FROM listings
GROUP BY property_type
ORDER BY listings DESC;


-- =========================================================
-- Question 6
-- Which cities have the highest average rating?
-- =========================================================

SELECT
    city,
    ROUND(AVG(review_scores_rating)::numeric,2) AS avg_rating
FROM listings
GROUP BY city
ORDER BY avg_rating DESC;


-- =========================================================
-- Question 7
-- Which hosts have the highest average rating?
-- (Minimum 5 listings)
-- =========================================================

SELECT
    host_id,
    COUNT(*) AS listings,
    ROUND(AVG(review_scores_rating)::numeric,2) AS avg_rating
FROM listings
GROUP BY host_id
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC
LIMIT 20;


-- =========================================================
-- Question 8
-- Top 20 Most Reviewed Listings
-- =========================================================

SELECT
    l.listing_id,
    l.name,
    l.city,
    COUNT(r.review_id) AS reviews
FROM listings l
JOIN reviews r
ON l.listing_id = r.listing_id
GROUP BY
    l.listing_id,
    l.name,
    l.city
ORDER BY reviews DESC
LIMIT 20;


-- =========================================================
-- Question 9
-- Which cities have the most reviews?
-- =========================================================

SELECT
    l.city,
    COUNT(r.review_id) AS total_reviews
FROM listings l
JOIN reviews r
ON l.listing_id = r.listing_id
GROUP BY l.city
ORDER BY total_reviews DESC;


-- =========================================================
-- Question 10
-- What percentage of listings are Superhosts?
-- =========================================================

SELECT

ROUND(

100.0 *

SUM(
CASE
WHEN host_is_superhost THEN 1
ELSE 0
END
)

/

COUNT(*)

,2)

AS superhost_percentage

FROM listings;


-- =========================================================
-- Question 11
-- What percentage of listings support Instant Booking?
-- =========================================================

SELECT

ROUND(

100.0 *

SUM(
CASE
WHEN instant_bookable THEN 1
ELSE 0
END
)

/

COUNT(*)

,2)

AS instant_booking_percentage

FROM listings;


-- =========================================================
-- Question 12
-- Which bedroom size is most profitable?
-- =========================================================

SELECT

bedrooms,

ROUND(AVG(price)::numeric,2) average_price

FROM listings

GROUP BY bedrooms

ORDER BY average_price DESC;


-- =========================================================
-- Question 13
-- Top Luxury Listings
-- =========================================================

SELECT

listing_id,
name,
city,
price,
review_scores_rating

FROM listings

ORDER BY
price DESC

LIMIT 20;


-- =========================================================
-- Question 14
-- Cities Having More Than 10000 Listings
-- =========================================================

SELECT

city,

COUNT(*) listings

FROM listings

GROUP BY city

HAVING COUNT(*) > 10000

ORDER BY listings DESC;


-- =========================================================
-- Question 15
-- Review Trend by Year
-- =========================================================

SELECT

EXTRACT(YEAR FROM review_date) year,

COUNT(*) reviews

FROM reviews

GROUP BY year

ORDER BY year;


-- =========================================================
-- Question 16
-- Review Trend by Month
-- =========================================================

SELECT

EXTRACT(MONTH FROM review_date) month,

COUNT(*) reviews

FROM reviews

GROUP BY month

ORDER BY month;


-- =========================================================
-- Question 17
-- Which cities have the most Luxury Listings?
-- =========================================================

SELECT

city,

COUNT(*) luxury_listings

FROM listings

WHERE price > 500

GROUP BY city

ORDER BY luxury_listings DESC;


-- =========================================================
-- Question 18
-- Top Hosts by Estimated Revenue
-- =========================================================

SELECT

host_id,

SUM(price) revenue,

COUNT(*) listings

FROM listings

GROUP BY host_id

ORDER BY revenue DESC

LIMIT 20;


-- =========================================================
-- Question 19
-- Which room type has the best ratings?
-- =========================================================

SELECT

room_type,

ROUND(AVG(review_scores_rating)::numeric,2) rating

FROM listings

GROUP BY room_type

ORDER BY rating DESC;


-- =========================================================
-- Question 20
-- Overall Business Summary
-- =========================================================

SELECT

COUNT(*) total_listings,

COUNT(DISTINCT host_id) total_hosts,

COUNT(DISTINCT city) total_cities,

ROUND(AVG(price)::numeric,2) average_price,

ROUND(AVG(review_scores_rating)::numeric,2) average_rating

FROM listings;