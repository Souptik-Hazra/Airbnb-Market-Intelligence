-- =========================================================
-- 05 VIEWS
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

DROP VIEW IF EXISTS vw_city_summary CASCADE;
DROP VIEW IF EXISTS vw_host_summary CASCADE;
DROP VIEW IF EXISTS vw_room_type_summary CASCADE;
DROP VIEW IF EXISTS vw_property_summary CASCADE;
DROP VIEW IF EXISTS vw_review_summary CASCADE;
DROP VIEW IF EXISTS vw_top_listings CASCADE;
DROP VIEW IF EXISTS vw_price_segments CASCADE;
DROP VIEW IF EXISTS vw_city_room_price CASCADE;

-- =========================================================
-- View 1
-- City Summary
-- =========================================================

CREATE VIEW vw_city_summary AS

SELECT

    city,

    COUNT(*) AS total_listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating,

    COUNT(DISTINCT host_id) AS total_hosts

FROM listings

GROUP BY city;



-- =========================================================
-- View 2
-- Host Summary
-- =========================================================

CREATE VIEW vw_host_summary AS

SELECT

    host_id,

    COUNT(*) AS total_listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating,

    SUM(price) AS estimated_revenue

FROM listings

GROUP BY host_id;



-- =========================================================
-- View 3
-- Room Type Summary
-- =========================================================

CREATE VIEW vw_room_type_summary AS

SELECT

    room_type,

    COUNT(*) AS listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating

FROM listings

GROUP BY room_type;



-- =========================================================
-- View 4
-- Property Type Summary
-- =========================================================

CREATE VIEW vw_property_summary AS

SELECT

    property_type,

    COUNT(*) AS listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating

FROM listings

GROUP BY property_type;



-- =========================================================
-- View 5
-- Review Summary
-- =========================================================

CREATE VIEW vw_review_summary AS

SELECT

    listing_id,

    COUNT(*) AS total_reviews,

    MIN(review_date) AS first_review,

    MAX(review_date) AS last_review

FROM reviews

GROUP BY listing_id;



-- =========================================================
-- View 6
-- Top Listings
-- =========================================================

CREATE VIEW vw_top_listings AS

SELECT

    listing_id,

    name,

    city,

    property_type,

    room_type,

    price,

    review_scores_rating

FROM listings

WHERE review_scores_rating >= 9

ORDER BY review_scores_rating DESC,
         price DESC;



-- =========================================================
-- View 7
-- Price Segments
-- =========================================================

CREATE VIEW vw_price_segments AS

SELECT

    listing_id,

    city,

    price,

    CASE

        WHEN price < 100 THEN 'Budget'

        WHEN price BETWEEN 100 AND 300 THEN 'Standard'

        WHEN price BETWEEN 301 AND 700 THEN 'Premium'

        ELSE 'Luxury'

    END AS price_segment

FROM listings;



-- =========================================================
-- View 8
-- City + Room Type Analysis
-- =========================================================

CREATE VIEW vw_city_room_price AS

SELECT

    city,

    room_type,

    COUNT(*) AS listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating

FROM listings

GROUP BY city, room_type;



-- =========================================================
-- Verify Views
-- =========================================================

SELECT * FROM vw_city_summary;

SELECT * FROM vw_host_summary LIMIT 20;

SELECT * FROM vw_room_type_summary;

SELECT * FROM vw_property_summary LIMIT 20;

SELECT * FROM vw_review_summary LIMIT 20;

SELECT * FROM vw_top_listings LIMIT 20;

SELECT * FROM vw_price_segments LIMIT 20;

SELECT * FROM vw_city_room_price;