# Online-Movie-Store
📦 Online Movie Store Database
A complete SQL database project that models the backend of an online movie store, including users, movies, genres, transactions, reviews, and admin accounts.
This repository demonstrates real-world SQL design, normalization, and data retrieval techniques.

🛠️ Project Overview

This project contains:

✔️ Full database schema

User accounts

Admin accounts

Movie catalog

Movie genres

Customer reviews

Transaction history

✔️ Data integrity features

Primary keys

Foreign keys

CHECK constraints

UNIQUE & NOT NULL rules

Cascading table drops (safe re-runs)

✔️ Sample data

Includes one user, one admin, one movie, one genre, a review, and a transaction to test queries.

✔️ Queries & Views

Basic SELECT queries

Joins between multiple tables

Two summary views:

customer_purchase_summary

movie_review_summary
```
📂 File Structure
├── schema.sql       # Creates all tables + inserts sample data
├── queries.sql     # All queries, joins, and views
└── README.md                    # Project documentation
```
⚙️ How to Run
1. Run the schema & inserts

This builds the full database structure and loads sample rows:

schema.sql

2. Run the queries & views

This file depends on the tables created in Part 1:

queries.sql


Works on:

Oracle SQL Developer

SQL*Plus

Any Oracle-compatible environment

🧠 Learning Goals Demonstrated

Relational database design

Table creation with constraints

Referential integrity (PK/FK)

SQL joins (inner joins across 3 tables)

Creating reusable views

Sorting, filtering, and organizing data

Writing clean, modular SQL code
