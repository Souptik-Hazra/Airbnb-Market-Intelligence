import pandas as pd
import psycopg2

# =====================================================
# PostgreSQL Configuration
# =====================================================

DB_NAME = "airbnb_db"
DB_USER = "postgres"
DB_PASSWORD = "1947"      # <-- CHANGE THIS
DB_HOST = "localhost"
DB_PORT = "5432"

# =====================================================
# Connect
# =====================================================

print("Connecting to PostgreSQL...")

conn = psycopg2.connect(
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD,
    host=DB_HOST,
    port=DB_PORT
)

cur = conn.cursor()

print("Connected.\n")

# =====================================================
# Clean Tables
# =====================================================

print("Cleaning old tables...")

cur.execute("""
TRUNCATE TABLE reviews RESTART IDENTITY CASCADE;
TRUNCATE TABLE listings CASCADE;
TRUNCATE TABLE listings_data_dictionary CASCADE;
TRUNCATE TABLE reviews_data_dictionary CASCADE;
""")

conn.commit()

print("Done.\n")

# =====================================================
# Listings
# =====================================================

print("Importing Listings...")

with open(
    "data/cleaned/listings_cleaned.csv",
    "r",
    encoding="utf-8"
) as f:

    cur.copy_expert("""
    COPY listings
    FROM STDIN
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        NULL ''
    )
    """, f)

conn.commit()

print("✓ Listings Imported\n")

# =====================================================
# Reviews
# =====================================================

print("Preparing Reviews...")

reviews = pd.read_csv(
    "data/cleaned/reviews_cleaned.csv",
    parse_dates=["date"],
    low_memory=False
)

reviews.rename(
    columns={"date": "review_date"},
    inplace=True
)

# IMPORTANT
reviews = reviews[
    [
        "review_id",
        "listing_id",
        "review_date",
        "reviewer_id"
    ]
]

reviews.to_csv(
    "data/processed/reviews_postgres.csv",
    index=False
)

print("Importing Reviews...")

with open(
    "data/processed/reviews_postgres.csv",
    "r",
    encoding="utf-8"
) as f:

    cur.copy_expert("""
    COPY reviews(
        review_id,
        listing_id,
        review_date,
        reviewer_id
    )
    FROM STDIN
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        NULL ''
    )
    """, f)

conn.commit()

print("✓ Reviews Imported\n")

# =====================================================
# Listings Dictionary
# =====================================================

print("Importing Listings Dictionary...")

with open(
    "data/raw/Listings_data_dictionary.csv",
    "r",
    encoding="utf-8"
) as f:

    cur.copy_expert("""
    COPY listings_data_dictionary
    FROM STDIN
    WITH (
        FORMAT CSV,
        HEADER TRUE
    )
    """, f)

conn.commit()

print("✓ Listings Dictionary Imported\n")

# =====================================================
# Reviews Dictionary
# =====================================================

print("Importing Reviews Dictionary...")

with open(
    "data/raw/Reviews_data_dictionary.csv",
    "r",
    encoding="utf-8"
) as f:

    cur.copy_expert("""
    COPY reviews_data_dictionary
    FROM STDIN
    WITH (
        FORMAT CSV,
        HEADER TRUE
    )
    """, f)

conn.commit()

print("✓ Reviews Dictionary Imported\n")

# =====================================================
# Close
# =====================================================

cur.close()
conn.close()

print("=" * 60)
print("ALL TABLES IMPORTED SUCCESSFULLY")
print("=" * 60)