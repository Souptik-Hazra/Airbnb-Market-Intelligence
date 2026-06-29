import pandas as pd

print("=" * 80)
print("Loading datasets...")
print("=" * 80)

# Load datasets
listings = pd.read_csv(
    "data/raw/Listings.csv",
    encoding="latin1",
    low_memory=False
)

reviews = pd.read_csv(
    "data/raw/Reviews.csv"
)

print("\nInitial Listings Shape:", listings.shape)
print("Initial Reviews Shape:", reviews.shape)

# --------------------------------------------------
# Drop unnecessary column
# --------------------------------------------------

print("\nDropping 'district' column...")
listings.drop(columns=["district"], inplace=True)

# --------------------------------------------------
# Convert data types
# --------------------------------------------------

print("Converting date columns...")

listings["host_since"] = pd.to_datetime(
    listings["host_since"],
    errors="coerce"
)

reviews["date"] = pd.to_datetime(
    reviews["date"],
    errors="coerce"
)

# --------------------------------------------------
# Fill missing values
# --------------------------------------------------

print("Handling missing values...")

listings["name"] = listings["name"].fillna("Unknown Listing")

listings["host_location"] = listings["host_location"].fillna("Unknown")

listings["host_response_time"] = listings["host_response_time"].fillna("Unknown")

listings["host_response_rate"] = listings["host_response_rate"].fillna(
    listings["host_response_rate"].median()
)

listings["host_acceptance_rate"] = listings["host_acceptance_rate"].fillna(
    listings["host_acceptance_rate"].median()
)

listings["host_is_superhost"] = listings["host_is_superhost"].fillna("f")

listings["host_total_listings_count"] = listings["host_total_listings_count"].fillna(
    listings["host_total_listings_count"].median()
)

listings["host_has_profile_pic"] = listings["host_has_profile_pic"].fillna("t")

listings["host_identity_verified"] = listings["host_identity_verified"].fillna("f")

listings["bedrooms"] = listings["bedrooms"].fillna(
    listings["bedrooms"].median()
)

review_columns = [
    "review_scores_rating",
    "review_scores_accuracy",
    "review_scores_cleanliness",
    "review_scores_checkin",
    "review_scores_communication",
    "review_scores_location",
    "review_scores_value"
]

for col in review_columns:
    listings[col] = listings[col].fillna(
        listings[col].median()
    )

# --------------------------------------------------
# Remove duplicate rows
# --------------------------------------------------

print("Removing duplicate rows...")

listings.drop_duplicates(inplace=True)
reviews.drop_duplicates(inplace=True)

# --------------------------------------------------
# Final information
# --------------------------------------------------

print("\nFinal Listings Shape:", listings.shape)
print("Final Reviews Shape:", reviews.shape)

print("\nRemaining Missing Values")
print(listings.isnull().sum())

# --------------------------------------------------
# Save cleaned datasets
# --------------------------------------------------

print("\nSaving cleaned datasets...")

listings.to_csv(
    "data/cleaned/listings_cleaned.csv",
    index=False
)

reviews.to_csv(
    "data/cleaned/reviews_cleaned.csv",
    index=False
)

print("\nCleaning Completed Successfully.")