# 📚 Library Management Database

A SQL-based **Library Management Database** project developed using **MySQL**.

## 📌 Project Overview

The Library Management Database is designed to manage and organize library-related information such as students, books, authors, categories, borrowing records, and fines.

This project demonstrates practical implementation of relational database concepts and SQL queries using MySQL.

## ✨ Features

- 👩‍🎓 Student Management
- 📚 Book Management
- ✍️ Author Management
- 🗂️ Category Management
- 🔄 Book Borrowing Records
- 🔍 Book Search
- 🔗 SQL JOIN Operations
- 📊 Aggregate Functions
- 🔎 Subqueries
- ⏰ Overdue Book Detection
- 💰 Fine Calculation
- 👀 SQL Views
- 📋 Library Borrowing Reports

## 🛠️ Technologies Used

- **Database:** MySQL
- **Language:** SQL
- **Tool:** MySQL Workbench
- **Version Control:** Git & GitHub

## 🗄️ Database Tables

### 👩‍🎓 Students

Stores information about students registered in the library.

Main fields include:

- `student_id`
- `student_name`
- `department`
- `email`
- `phone`

### ✍️ Authors

Stores information about book authors.

Main fields include:

- `author_id`
- `author_name`

### 🗂️ Categories

Stores different categories of books.

Main fields include:

- `category_id`
- `category_name`

### 📚 Books

Stores information about books and their availability.

Main fields include:

- `book_id`
- `book_title`
- `author_id`
- `category_id`
- `publisher`
- `quantity`
- `available_copies`

### 🔄 Borrowings

Stores book issue and return information.

Main fields include:

- `borrowing_id`
- `student_id`
- `book_id`
- `issue_date`
- `due_date`
- `return_date`
- `status`

### 💰 Fines

Stores fine information related to borrowed books.

Main fields include:

- `fine_id`
- `borrowing_id`
- `fine_amount`
- `payment_status`

## 🔗 Database Relationships

```text
Students
    │
    │ student_id
    ▼
Borrowings
    │
    │ book_id
    ▼
Books
   ↙  ↘
Authors  Categories

Borrowings
    │
    │ borrowing_id
    ▼
Fines
```

## 📊 SQL Concepts Implemented

The project demonstrates the following SQL concepts:

- Database and table creation
- Primary Keys
- Foreign Keys
- `INSERT`
- `SELECT`
- `UPDATE`
- `WHERE`
- `LIKE`
- `JOIN`
- `LEFT JOIN`
- `COUNT()`
- `SUM()`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- Subqueries
- `NOT IN`
- `DATEDIFF()`
- `COALESCE()`
- `CASE`
- SQL Views

## 🔍 Sample SQL Queries

### View All Books

```sql
SELECT * FROM books;
```

### View All Students

```sql
SELECT * FROM students;
```

### Search for a Book

```sql
SELECT *
FROM books
WHERE book_title LIKE '%Code%';
```

### Display Borrowed Books

```sql
SELECT
    s.student_name,
    bo.book_title,
    b.issue_date,
    b.due_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
WHERE b.status = 'Borrowed';
```

### Find Books That Were Never Borrowed

```sql
SELECT book_title
FROM books
WHERE book_id NOT IN
(
    SELECT book_id
    FROM borrowings
);
```

## 👀 Library Borrowing Report

A SQL View named `library_borrowing_report` is used to generate a complete library borrowing report.

```sql
SELECT *
FROM library_borrowing_report;
```

The report combines information such as:

- Student Name
- Department
- Book Title
- Author
- Category
- Issue Date
- Due Date
- Return Date
- Status

## 💰 Fine Calculation

The project calculates fines for overdue books using SQL date functions.

**Fine Rate: ₹5 per overdue day**

```text
Fine = Late Days × ₹5
```

The `DATEDIFF()` function is used to calculate the number of overdue days.

---

# 📸 Screenshots

## 👩‍🎓 Students Table

![Students Table](https://github.com/pavani8888/Library-management/blob/main/Screenshots/students.png?raw=true)

---

## 📚 Books Table

![Books Table](https://github.com/pavani8888/Library-management/blob/main/Screenshots/books.png?raw=true)

---

## 🔄 Borrowings Table

![Borrowings Table](https://github.com/pavani8888/Library-management/blob/main/Screenshots/borrowings.png?raw=true)

---

## 🔗 JOIN Query Result

![JOIN Query Result](https://github.com/pavani8888/Library-management/blob/main/Screenshots/joinsquery.png?raw=true)

---

## 💰 Fine Calculation

![Finel Calculation](https://github.com/pavani8888/Library-management/blob/main/Screenshots/final.png?raw=true)

## 📁 Project Structure

```text
Library-management/
│
├── README.md
├── libraryDatabase.sql
│
└── Screenshots/
    ├── students.png
    ├── books.png
    ├── borrowings.png
    ├── joins query.png
    └── fina.png
```

## 🚀 How to Run the Project

### Step 1

Install **MySQL Server** and **MySQL Workbench**.

### Step 2

Open the SQL file:

```text
libraryDatabase.sql
```

### Step 3

Execute the SQL script in MySQL Workbench.

### Step 4

Select the database:

```sql
USE library_management;
```

### Step 5

Check the available tables:

```sql
SHOW TABLES;
```

### Step 6

Run the required SQL queries to view students, books, borrowing records, fines, and reports.

## 🌟 Advantages

- Reduces manual library record management.
- Organizes student and book information.
- Makes borrowing records easy to manage.
- Helps identify overdue books.
- Supports fine calculation.
- Provides useful library reports.
- Demonstrates practical relational database concepts.

## 🔮 Future Scope

The project can be further enhanced with:

- 🔐 Admin Login
- 👤 Student Login
- 🌐 Web-Based Interface
- 📱 Mobile Application
- 📧 Email Notifications
- 🔔 Due Date Reminders
- 📖 Online Book Reservation
- 💳 Online Fine Payment
- 📊 Interactive Dashboard

## 🎓 Learning Outcomes

Through this project, I gained practical knowledge of:

- MySQL
- SQL Queries
- Relational Database Design
- Primary and Foreign Keys
- Table Relationships
- JOIN Operations
- Aggregate Functions
- Subqueries
- SQL Views
- Date Functions
- Database Management

## 👩‍💻 Author

**Pavani**

B.Tech Student

## 📄 License

This project is developed for **educational and academic purposes**.
