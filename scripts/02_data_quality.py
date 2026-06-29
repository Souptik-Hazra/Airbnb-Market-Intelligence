import pandas as pd

print("=" * 80)
print("Loading datasets...")
print("=" * 80)

listings = pd.read_csv(
    "data/raw/Listings.csv",
    encoding="latin1",
    low_memory=False
)

reviews = pd.read_csv(
    "data/raw/Reviews.csv"
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

    print("\nMissing Percentage:")
    print((df.isnull().sum() / len(df) * 100).round(2))

    print("\nUnique Values:")
    print(df.nunique())

print("\nCompleted Successfully.")