-- =========================================================
-- 07 DATABASE OPTIMIZATION
-- Airbnb Market Intelligence
-- PostgreSQL 18
-- =========================================================

-- =========================================================
-- INDEXES
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_listings_city
ON listings(city);

CREATE INDEX IF NOT EXISTS idx_listings_price
ON listings(price);

CREATE INDEX IF NOT EXISTS idx_listings_host
ON listings(host_id);

CREATE INDEX IF NOT EXISTS idx_listings_room_type
ON listings(room_type);

CREATE INDEX IF NOT EXISTS idx_listings_property_type
ON listings(property_type);

CREATE INDEX IF NOT EXISTS idx_listings_rating
ON listings(review_scores_rating);

CREATE INDEX IF NOT EXISTS idx_listings_superhost
ON listings(host_is_superhost);

CREATE INDEX IF NOT EXISTS idx_reviews_listing
ON reviews(listing_id);

CREATE INDEX IF NOT EXISTS idx_reviews_date
ON reviews(review_date);

CREATE INDEX IF NOT EXISTS idx_reviews_reviewer
ON reviews(reviewer_id);

-- =========================================================
-- UPDATE QUERY PLANNER STATISTICS
-- =========================================================

ANALYZE listings;
ANALYZE reviews;

-- =========================================================
-- RECLAIM STORAGE
-- =========================================================

VACUUM ANALYZE listings;
VACUUM ANALYZE reviews;

-- =========================================================
-- EXPLAIN QUERY PLAN
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM listings
WHERE city = 'Paris';

EXPLAIN ANALYZE
SELECT
    city,
    AVG(price)
FROM listings
GROUP BY city;

EXPLAIN ANALYZE
SELECT
    l.city,
    COUNT(r.review_id)
FROM listings l
JOIN reviews r
ON l.listing_id = r.listing_id
GROUP BY l.city;

-- =========================================================
-- MATERIALIZED VIEW
-- =========================================================

DROP MATERIALIZED VIEW IF EXISTS mv_city_summary;

CREATE MATERIALIZED VIEW mv_city_summary AS

SELECT

    city,

    COUNT(*) AS listings,

    ROUND(AVG(price)::numeric,2) AS average_price,

    ROUND(AVG(review_scores_rating)::numeric,2) AS average_rating,

    COUNT(DISTINCT host_id) AS hosts

FROM listings

GROUP BY city;

CREATE INDEX idx_mv_city
ON mv_city_summary(city);

-- =========================================================
-- REFRESH MATERIALIZED VIEW
-- =========================================================

REFRESH MATERIALIZED VIEW mv_city_summary;

-- =========================================================
-- PERFORMANCE TEST
-- =========================================================

EXPLAIN ANALYZE

SELECT *

FROM mv_city_summary

ORDER BY average_price DESC;

-- =========================================================
-- CHECK INDEXES
-- =========================================================

SELECT

schemaname,
tablename,
indexname

FROM pg_indexes

WHERE tablename IN ('listings','reviews');

-- =========================================================
-- TABLE SIZE
-- =========================================================

SELECT

relname AS table_name,

pg_size_pretty(pg_total_relation_size(relid)) AS table_size

FROM pg_catalog.pg_statio_user_tables

ORDER BY pg_total_relation_size(relid) DESC;

-- =========================================================
-- DATABASE SIZE
-- =========================================================

SELECT

current_database(),

pg_size_pretty(pg_database_size(current_database()));

-- =========================================================
-- TOP 10 LARGEST TABLES
-- =========================================================

SELECT

relname,

pg_size_pretty(pg_total_relation_size(relid))

FROM pg_catalog.pg_statio_user_tables

ORDER BY pg_total_relation_size(relid) DESC

LIMIT 10;

-- =========================================================
-- ACTIVE CONNECTIONS
-- =========================================================

SELECT

pid,

state,

query

FROM pg_stat_activity

WHERE datname=current_database();

-- =========================================================
-- LONG RUNNING QUERIES
-- =========================================================

SELECT

pid,

now()-query_start AS duration,

state,

query

FROM pg_stat_activity

WHERE state='active'

ORDER BY duration DESC;

-- =========================================================
-- VERIFY MATERIALIZED VIEW
-- =========================================================

SELECT *

FROM mv_city_summary

ORDER BY average_price DESC;