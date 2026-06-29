-- =========================================================
-- 04 WINDOW FUNCTIONS
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- Query 1
-- Rank Listings by Price (Global)
-- =========================================================

SELECT
    listing_id,
    city,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM listings;


-- =========================================================
-- Query 2
-- Dense Rank Listings by Rating
-- =========================================================

SELECT
    listing_id,
    city,
    review_scores_rating,
    DENSE_RANK() OVER (
        ORDER BY review_scores_rating DESC
    ) AS rating_rank
FROM listings;


-- =========================================================
-- Query 3
-- Row Number Within Each City
-- =========================================================

SELECT
    listing_id,
    city,
    price,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY price DESC
    ) AS row_num
FROM listings;


-- =========================================================
-- Query 4
-- Top 3 Most Expensive Listings Per City
-- =========================================================

WITH ranked AS
(
    SELECT
        listing_id,
        city,
        price,
        ROW_NUMBER() OVER(
            PARTITION BY city
            ORDER BY price DESC
        ) rn
    FROM listings
)

SELECT *
FROM ranked
WHERE rn <= 3;


-- =========================================================
-- Query 5
-- Previous Listing Price
-- =========================================================

SELECT
    listing_id,
    city,
    price,
    LAG(price) OVER(
        PARTITION BY city
        ORDER BY price
    ) AS previous_price
FROM listings;


-- =========================================================
-- Query 6
-- Next Listing Price
-- =========================================================

SELECT
    listing_id,
    city,
    price,
    LEAD(price) OVER(
        PARTITION BY city
        ORDER BY price
    ) AS next_price
FROM listings;


-- =========================================================
-- Query 7
-- Running Total of Prices
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    SUM(price)
    OVER(
        PARTITION BY city
        ORDER BY price
    ) AS running_total

FROM listings;


-- =========================================================
-- Query 8
-- Running Average Price
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    ROUND(

    AVG(price)
    OVER(
        PARTITION BY city
        ORDER BY price

    )::numeric,2)

AS running_avg

FROM listings;


-- =========================================================
-- Query 9
-- Highest Price Per City
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    MAX(price)
    OVER(
        PARTITION BY city
    ) AS highest_price

FROM listings;


-- =========================================================
-- Query 10
-- Lowest Price Per City
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    MIN(price)
    OVER(
        PARTITION BY city
    ) AS lowest_price

FROM listings;


-- =========================================================
-- Query 11
-- Difference from City Average
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    ROUND(

    (
    price-

    AVG(price)
    OVER(
        PARTITION BY city
    )

    )::numeric,2)

AS price_difference

FROM listings;


-- =========================================================
-- Query 12
-- Percent Rank
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    PERCENT_RANK()
    OVER(
        PARTITION BY city
        ORDER BY price
    ) AS percent_rank

FROM listings;


-- =========================================================
-- Query 13
-- Quartiles
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    NTILE(4)
    OVER(
        PARTITION BY city
        ORDER BY price
    ) AS quartile

FROM listings;


-- =========================================================
-- Query 14
-- Deciles
-- =========================================================

SELECT
    listing_id,
    city,
    price,

    NTILE(10)
    OVER(
        PARTITION BY city
        ORDER BY price
    ) AS decile

FROM listings;


-- =========================================================
-- Query 15
-- Cumulative Reviews
-- =========================================================

WITH review_counts AS
(
    SELECT
        listing_id,
        COUNT(*) AS reviews
    FROM reviews
    GROUP BY listing_id
)

SELECT

listing_id,

reviews,

SUM(reviews)
OVER(
ORDER BY reviews DESC
) cumulative_reviews

FROM review_counts;


-- =========================================================
-- Query 16
-- Average Price of Previous 5 Listings
-- =========================================================

SELECT
listing_id,
city,
price,

ROUND(

AVG(price)

OVER(

PARTITION BY city

ORDER BY price

ROWS BETWEEN 4 PRECEDING
AND CURRENT ROW

)::numeric,2)

moving_average

FROM listings;


-- =========================================================
-- Query 17
-- Top Rated Listing Per City
-- =========================================================

SELECT *

FROM

(
SELECT

listing_id,
city,
review_scores_rating,

ROW_NUMBER()

OVER(

PARTITION BY city

ORDER BY review_scores_rating DESC

) rn

FROM listings

)t

WHERE rn=1;


-- =========================================================
-- Query 18
-- Price Percentile
-- =========================================================

SELECT

listing_id,

city,

price,

CUME_DIST()

OVER(

PARTITION BY city

ORDER BY price

) percentile

FROM listings;


-- =========================================================
-- Query 19
-- Host Ranking by Listings
-- =========================================================

SELECT

host_id,

COUNT(*) listings,

RANK()

OVER(

ORDER BY COUNT(*) DESC

) host_rank

FROM listings

GROUP BY host_id;


-- =========================================================
-- Query 20
-- Review Ranking
-- =========================================================

WITH review_counts AS
(
SELECT

listing_id,

COUNT(*) reviews

FROM reviews

GROUP BY listing_id

)

SELECT

listing_id,

reviews,

RANK()

OVER(

ORDER BY reviews DESC

) review_rank

FROM review_counts;