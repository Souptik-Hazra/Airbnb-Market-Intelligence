# 🏠 Airbnb Market Intelligence

An end-to-end **Data Analytics**, **Machine Learning**, and **Business Intelligence** project that analyzes Airbnb listings across multiple cities to uncover pricing trends, host performance, and customer review insights.

---

## 📌 Project Overview

This project follows a complete data analytics pipeline from raw Airbnb data to interactive dashboards and predictive analytics.

### Objectives

- Analyze Airbnb market trends
- Identify factors affecting listing prices
- Compare pricing across cities
- Study host performance
- Analyze customer reviews
- Build a Machine Learning model for price prediction
- Create an interactive Power BI dashboard

---

# 📂 Project Structure

```text
Airbnb-Market-Intelligence/
│
├── dashboard/
│   ├── Airbnb_Market_Intelligence.pbix
│   └── Dashboard.pdf
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── external/
│
├── database/
│
├── images/
│
├── models/
│   └── random_forest_model.pkl
│
├── notebooks/
│   ├── 01_data_collection.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_exploratory_data_analysis.ipynb
│   ├── 04_feature_engineering.ipynb
│   ├── ...
│   └── 09_machine_learning.ipynb
│
├── reports/
├── scripts/
├── sql/
│
├── README.md
└── requirements.txt
```

---

# 📊 Dashboard Pages

## Executive Dashboard

- Total Listings
- Total Hosts
- Total Reviews
- Average Price
- Average Review Score
- Total Cities
- Top 10 Cities by Listings
- Room Type Distribution
- Average Price by City

---

## Pricing Analysis

- Average Price
- Median Price
- Maximum Price
- Minimum Price
- Average Price by Property Type
- Average Price by Room Type
- Average Price by City
- Price Category Distribution
- Review Score Distribution

---

# 🤖 Machine Learning

## Model

- Random Forest Regressor

## Target

- Airbnb Listing Price

### Workflow

```
Raw Dataset
      ↓
Data Cleaning
      ↓
Feature Engineering
      ↓
Train/Test Split
      ↓
Random Forest Regressor
      ↓
Model Evaluation
      ↓
Saved Model (.pkl)
```

---

# 📈 Feature Engineering

Created new features including:

- Host Experience
- Amenities Count
- Bedroom Density
- Price Per Guest
- Overall Review Score
- Host Quality
- Estimated Monthly Revenue
- Price Category
- Rating Category

---

# 🛠 Technologies Used

### Programming
- Python
- SQL

### Libraries
- Pandas
- NumPy
- Scikit-learn
- Matplotlib
- Seaborn
- Joblib

### Dashboard
- Microsoft Power BI

### Database
- PostgreSQL

### Tools
- Jupyter Notebook
- Visual Studio Code
- Git
- GitHub
- pgAdmin 4

---

# 📊 Dataset Summary

- 280K+ Listings
- 182K+ Hosts
- 5M+ Reviews
- 10 Cities

---

# 📸 Dashboard Preview

Add screenshots here.

```
dashboard/
    screenshots/
```

---

# ⚙ Installation

Clone repository

```bash
git clone https://github.com/souptik-hazra/Airbnb-Market-Intelligence.git
```

Move inside project

```bash
cd Airbnb-Market-Intelligence
```

Install dependencies

```bash
pip install -r requirements.txt
```

---

# 💡 Business Questions Answered

- Which city has the highest Airbnb prices?
- Which room type is the most expensive?
- Which property types generate the highest prices?
- How do review scores affect pricing?
- Which cities have the most listings?
- How are listings distributed across price categories?

---

# 🚀 Future Scope

- Streamlit Deployment
- Real-time Price Prediction
- Interactive Web Dashboard
- Recommendation System
- Time-Series Price Forecasting

---

# 👨‍💻 Author

**Souptik Hazra**

- MCA, Vellore Institute of Technology
- Data Analytics | Machine Learning | Business Intelligence

---

## ⭐ If you like this project, don't forget to Star the repository!