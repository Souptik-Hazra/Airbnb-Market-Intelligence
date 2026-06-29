import pandas as pd

reviews = pd.read_csv(
    "data/cleaned/reviews_cleaned.csv",
    low_memory=False
)

duplicates = reviews[
    reviews.duplicated(subset=["review_id"], keep=False)
].sort_values("review_id")

print("Duplicate review_id rows:", len(duplicates))
print()

print(duplicates.head(20))

duplicates.to_csv(
    "reports/duplicate_review_ids.csv",
    index=False
)

print("\nDuplicate rows saved to:")
print("reports/duplicate_review_ids.csv")