import pandas as pd

print("=" * 80)
print("VERIFYING CLEANED DATASETS")
print("=" * 80)

# Load cleaned datasets
listings = pd.read_csv(
    "data/cleaned/listings_cleaned.csv",
    low_memory=False
)

reviews = pd.read_csv(
    "data/cleaned/reviews_cleaned.csv",
    low_memory=False
)

datasets = {
    "Listings": listings,
    "Reviews": reviews
}

for name, df in datasets.items():

    print("\n" + "=" * 80)
    print(name.upper())
    print("=" * 80)

    print("\nShape:")
    print(df.shape)

    print("\nDuplicate Rows:")
    print(df.duplicated().sum())

    print("\nMissing Values:")
    print(df.isnull().sum())

    print("\nData Types:")
    print(df.dtypes)

# Verify primary keys
print("\n" + "=" * 80)
print("PRIMARY KEY CHECK")
print("=" * 80)

print("Duplicate listing_id:", listings["listing_id"].duplicated().sum())
print("Duplicate review_id:", reviews["review_id"].duplicated().sum())

# Verify foreign key relationship
missing_listing_ids = (
    set(reviews["listing_id"])
    - set(listings["listing_id"])
)

print("\nReview records referencing missing listings:", len(missing_listing_ids))

print("\nVerification Completed Successfully.")