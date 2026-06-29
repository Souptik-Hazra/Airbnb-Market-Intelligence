CREATE INDEX idx_reviews_listing
ON reviews(listing_id);

CREATE INDEX idx_reviews_date
ON reviews(review_date);

CREATE INDEX idx_reviews_reviewer
ON reviews(reviewer_id);

CREATE INDEX idx_listings_city
ON listings(city);

CREATE INDEX idx_listings_price
ON listings(price);

CREATE INDEX idx_listings_rating
ON listings(review_scores_rating);

CREATE INDEX idx_listings_host
ON listings(host_id);

CREATE INDEX idx_listings_room
ON listings(room_type);

CREATE INDEX idx_listings_property
ON listings(property_type);