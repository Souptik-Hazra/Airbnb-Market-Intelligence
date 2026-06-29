-- =====================================================
-- Airbnb Market Intelligence Database
-- =====================================================

DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS listings CASCADE;
DROP TABLE IF EXISTS listings_data_dictionary CASCADE;
DROP TABLE IF EXISTS reviews_data_dictionary CASCADE;

-- =====================================================
-- LISTINGS
-- =====================================================

CREATE TABLE listings (

    listing_id BIGINT PRIMARY KEY,

    name TEXT,

    host_id BIGINT,

    host_since DATE,

    host_location TEXT,

    host_response_time TEXT,

    host_response_rate DOUBLE PRECISION,

    host_acceptance_rate DOUBLE PRECISION,

    host_is_superhost BOOLEAN,

    host_total_listings_count DOUBLE PRECISION,

    host_has_profile_pic BOOLEAN,

    host_identity_verified BOOLEAN,

    neighbourhood TEXT,

    city TEXT,

    latitude DOUBLE PRECISION,

    longitude DOUBLE PRECISION,

    property_type TEXT,

    room_type TEXT,

    accommodates INTEGER,

    bedrooms DOUBLE PRECISION,

    amenities TEXT,

    price INTEGER,

    minimum_nights INTEGER,

    maximum_nights INTEGER,

    review_scores_rating DOUBLE PRECISION,

    review_scores_accuracy DOUBLE PRECISION,

    review_scores_cleanliness DOUBLE PRECISION,

    review_scores_checkin DOUBLE PRECISION,

    review_scores_communication DOUBLE PRECISION,

    review_scores_location DOUBLE PRECISION,

    review_scores_value DOUBLE PRECISION,

    instant_bookable BOOLEAN
);

-- =====================================================
-- REVIEWS
-- =====================================================

CREATE TABLE reviews (

    review_pk BIGSERIAL PRIMARY KEY,

    review_id BIGINT,

    listing_id BIGINT NOT NULL,

    review_date DATE,

    reviewer_id BIGINT,

    CONSTRAINT fk_listing
        FOREIGN KEY (listing_id)
        REFERENCES listings(listing_id)
);

-- =====================================================
-- LISTINGS DATA DICTIONARY
-- =====================================================

CREATE TABLE listings_data_dictionary (

    field TEXT PRIMARY KEY,

    description TEXT
);

-- =====================================================
-- REVIEWS DATA DICTIONARY
-- =====================================================

CREATE TABLE reviews_data_dictionary (

    field TEXT PRIMARY KEY,

    description TEXT
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_listing_city
ON listings(city);

CREATE INDEX idx_listing_price
ON listings(price);

CREATE INDEX idx_listing_property
ON listings(property_type);

CREATE INDEX idx_listing_room
ON listings(room_type);

CREATE INDEX idx_listing_host
ON listings(host_id);

CREATE INDEX idx_reviews_listing
ON reviews(listing_id);

CREATE INDEX idx_reviews_reviewid
ON reviews(review_id);

CREATE INDEX idx_reviews_date
ON reviews(review_date);

CREATE INDEX idx_reviews_reviewer
ON reviews(reviewer_id);