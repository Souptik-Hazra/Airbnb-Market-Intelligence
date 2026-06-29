import pandas as pd

print("=" * 80)
print("Loading datasets...")
print("=" * 80)

# Read datasets
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

    print("\nShape")
    print(df.shape)

    print("\nColumns")
    print(df.columns.tolist())

    print("\nData Types")
    print(df.dtypes)

    print("\nMemory Usage (MB)")
    print(round(df.memory_usage(deep=True).sum()/1024**2,2))

    print("\nFirst 5 Rows")
    print(df.head())

print("\nCompleted Successfully.")