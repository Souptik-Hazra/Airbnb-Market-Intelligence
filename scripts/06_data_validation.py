import pandas as pd

listings = pd.read_csv("data/cleaned/listings_cleaned.csv")
reviews = pd.read_csv("data/cleaned/reviews_cleaned.csv")

print("=" * 80)
print("FINAL DATA VALIDATION")
print("=" * 80)

print("\nListings")
print(listings.shape)

print("Duplicate listing_id:",
      listings["listing_id"].duplicated().sum())

print("\nReviews")
print(reviews.shape)

print("Duplicate review_id:",
      reviews["review_id"].duplicated().sum())

print("Duplicate (listing_id, review_id):",
      reviews.duplicated(
          subset=["listing_id","review_id"]
      ).sum())

print("\nMissing listing references:")

missing = (
    set(reviews["listing_id"])
    - set(listings["listing_id"])
)

print(len(missing))

print("\nValidation Finished.")