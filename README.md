# Number Guessing Game

# Relational Database Number Guessing Game

An interactive, database-driven command-line game built entirely in Bash and powered by a PostgreSQL relational database. This project was developed as a final requirement for the FreeCodeCamp Relational Database Certification.

## 🚀 Project Overview

The script generates a random secret number between 1 and 1000 and challenges players to guess it. What sets this apart from a standard scripting project is its persistent backend integration: it automatically tracks player history, counts games played, and updates each user's personal best score (fewest number of guesses).

### Key Features
* **Persistent User Memory:** Remembers returning users and fetches their lifetime stats.
* **Input Validation:** Gracefully detects non-integer inputs (like text strings or decimals) without costing the player a turn.
* **Dynamic Database Operations:** Automatically updates relational tables with zero user disruption upon game completion.

---

## 🛠️ Tech Stack & Concepts Used

* **Language:** Bash (Linux Shell Scripting)
* **Database:** PostgreSQL (Relational Database Management System)
* **Control Flow:** `while` loops, conditional loops (`while true`), and `if/elif/else` statements.
* **Input Parsing:** Internal Field Separator (`IFS`) string parsing and Regular Expressions (`regex`) for strict data type validation.

---

## 📊 Database Schema

The application utilizes a one-to-many relationship mapping players to their individual game records:

1. **`users` Table**
   * `user_id` (SERIAL, Primary Key)
   * `username` (VARCHAR, Unique)

2. **`games` Table**
   * `game_id` (SERIAL, Primary Key)
   * `user_id` (INT, Foreign Key referencing `users.user_id`)
   * `guesses` (INT)

