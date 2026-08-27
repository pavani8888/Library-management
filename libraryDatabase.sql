CREATE DATABASE library_management;
SHOW DATABASES;
USE library_management;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);
DESCRIBE students;
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);
DESCRIBE authors;
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);
DESCRIBE categories;
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(150) NOT NULL,
    author_id INT,
    category_id INT,
    publisher VARCHAR(100),
    quantity INT DEFAULT 1,
    available_copies INT DEFAULT 1,

    FOREIGN KEY (author_id)
        REFERENCES authors(author_id),

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);
DESCRIBE books;
INSERT INTO students
(student_name, department, email, phone)
VALUES
('Pavani', 'CSE', 'pavani@gmail.com', '9876543210'),
('Kaveri', 'ECE', 'kaveri@gmail.com', '9876543211'),
('Anjali', 'CSE', 'anjali@gmail.com', '9876543212'),
('Sneha', 'IT', 'sneha@gmail.com', '9876543213'),
('Harika', 'EEE', 'harika@gmail.com', '9876543214');
SELECT * FROM students;
INSERT INTO authors (author_name)
VALUES
('R.K. Narayan'),
('Chetan Bhagat'),
('J.K. Rowling'),
('George Orwell'),
('A.P.J. Abdul Kalam'),
('Robert C. Martin');
SELECT * FROM authors;
INSERT INTO categories (category_name)
VALUES
('Programming'),
('Fiction'),
('Science'),
('Biography'),
('Technology'),
('Novel');
SELECT * FROM categories;
INSERT INTO books
(book_title, author_id, category_id, publisher, quantity, available_copies)
VALUES
('Malgudi Days', 1, 2, 'Indian Publishers', 5, 5),
('Five Point Someone', 2, 6, 'Rupa Publications', 4, 4),
('Harry Potter', 3, 2, 'Bloomsbury', 6, 6),
('1984', 4, 2, 'Penguin Books', 3, 3),
('Wings of Fire', 5, 4, 'Universities Press', 5, 5),
('Clean Code', 6, 1, 'Prentice Hall', 4, 4),
('Programming Basics', 6, 1, 'Tech Publications', 5, 5);
SELECT * FROM books;
CREATE TABLE borrowings (
    borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) DEFAULT 'Borrowed',

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);
DESCRIBE borrowings;
INSERT INTO borrowings
(student_id, book_id, issue_date, due_date, return_date, status)
VALUES
(1, 1, '2026-08-01', '2026-08-15', '2026-08-12', 'Returned'),
(2, 3, '2026-08-05', '2026-08-19', NULL, 'Borrowed'),
(3, 6, '2026-08-07', '2026-08-21', '2026-08-20', 'Returned'),
(1, 5, '2026-08-10', '2026-08-24', NULL, 'Borrowed'),
(4, 2, '2026-08-12', '2026-08-26', NULL, 'Borrowed');
SELECT * FROM borrowings;
SELECT
    b.borrowing_id,
    s.student_name,
    bo.book_title,
    b.issue_date,
    b.due_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id;
SELECT
    bo.book_id,
    bo.book_title,
    a.author_name,
    c.category_name,
    bo.publisher,
    bo.quantity,
    bo.available_copies
FROM books bo
JOIN authors a
    ON bo.author_id = a.author_id
JOIN categories c
    ON bo.category_id = c.category_id;
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
SELECT
    s.student_name,
    bo.book_title,
    b.issue_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
WHERE b.status = 'Returned';
SELECT COUNT(*) AS total_students
FROM students;
SELECT COUNT(*) AS total_books
FROM books;
SELECT SUM(quantity) AS total_book_copies
FROM books;
SELECT *
FROM books
WHERE book_title LIKE '%Code%';
SELECT
    book_id,
    book_title,
    publisher,
    quantity,
    available_copies
FROM books
WHERE book_title LIKE '%Programming%';
SELECT
    bo.book_title,
    a.author_name
FROM books bo
JOIN authors a
    ON bo.author_id = a.author_id
WHERE a.author_name LIKE '%Martin%';
SELECT
    s.student_name,
    COUNT(b.borrowing_id) AS total_borrowings
FROM students s
LEFT JOIN borrowings b
    ON s.student_id = b.student_id
GROUP BY s.student_id, s.student_name;
SELECT
    c.category_name,
    COUNT(b.book_id) AS number_of_books
FROM categories c
LEFT JOIN books b
    ON c.category_id = b.category_id
GROUP BY c.category_id, c.category_name;
SELECT book_title
FROM books
WHERE book_id NOT IN
(
    SELECT book_id
    FROM borrowings
);
SELECT book_id
FROM borrowings;
SELECT book_title
FROM books
WHERE book_id NOT IN
(
    SELECT book_id
    FROM borrowings
);
SELECT
    bo.book_title,
    COUNT(b.borrowing_id) AS borrow_count
FROM books bo
JOIN borrowings b
    ON bo.book_id = b.book_id
GROUP BY bo.book_id, bo.book_title
ORDER BY borrow_count DESC
LIMIT 1;
SELECT
    s.student_name,
    bo.book_title,
    b.issue_date,
    b.due_date
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
WHERE b.status = 'Borrowed'
AND b.due_date < CURDATE();
SELECT
    b.borrowing_id,
    s.student_name,
    bo.book_title,
    b.due_date,
    DATEDIFF(
        COALESCE(b.return_date, CURDATE()),
        b.due_date
    ) AS late_days,

    CASE
        WHEN DATEDIFF(
            COALESCE(b.return_date, CURDATE()),
            b.due_date
        ) > 0
        THEN DATEDIFF(
            COALESCE(b.return_date, CURDATE()),
            b.due_date
        ) * 5
        ELSE 0
    END AS fine_amount

FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id;
CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    borrowing_id INT NOT NULL,
    fine_amount DECIMAL(10,2) DEFAULT 0,
    payment_status VARCHAR(20) DEFAULT 'Unpaid',

    FOREIGN KEY (borrowing_id)
        REFERENCES borrowings(borrowing_id)
);
INSERT INTO fines
(borrowing_id, fine_amount, payment_status)
VALUES
(1, 0.00, 'Paid'),
(3, 0.00, 'Paid'),
(2, 40.00, 'Unpaid'),
(4, 15.00, 'Unpaid'),
(5, 5.00, 'Unpaid');
SELECT * FROM fines;
SELECT
    b.borrowing_id,
    s.student_name,
    s.department,
    bo.book_title,
    a.author_name,
    c.category_name,
    b.issue_date,
    b.due_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
JOIN authors a
    ON bo.author_id = a.author_id
JOIN categories c
    ON bo.category_id = c.category_id;
CREATE VIEW library_borrowing_report AS
SELECT
    b.borrowing_id,
    s.student_name,
    s.department,
    bo.book_title,
    a.author_name,
    c.category_name,
    b.issue_date,
    b.due_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
JOIN authors a
    ON bo.author_id = a.author_id
JOIN categories c
    ON bo.category_id = c.category_id;
SELECT *
FROM library_borrowing_report;
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';
UPDATE borrowings
SET
    return_date = '2026-08-27',
    status = 'Returned'
WHERE borrowing_id = 2;
SELECT *
FROM borrowings
WHERE borrowing_id = 2;
SELECT
    s.student_name,
    bo.book_title,
    b.due_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
WHERE b.borrowing_id = 2;
UPDATE books
SET available_copies = available_copies + 1
WHERE book_id = 3;
SELECT
    book_id,
    book_title,
    quantity,
    available_copies
FROM books
WHERE book_id = 3;
UPDATE books
SET available_copies = 6
WHERE book_id = 3;
INSERT INTO borrowings
(student_id, book_id, issue_date, due_date, status)
VALUES
(5, 4, '2026-08-27', '2026-09-10', 'Borrowed');
UPDATE books
SET available_copies = available_copies - 1
WHERE book_id = 4
AND available_copies > 0;
SELECT
    book_id,
    book_title,
    quantity,
    available_copies
FROM books
WHERE book_id = 4;
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
WHERE s.student_id = 5;
SELECT
    book_id,
    book_title,
    quantity,
    available_copies
FROM books
WHERE available_copies > 0;
SELECT
    s.student_name,
    bo.book_title,
    b.issue_date,
    b.due_date,
    b.return_date,
    b.status
FROM students s
JOIN borrowings b
    ON s.student_id = b.student_id
JOIN books bo
    ON b.book_id = bo.book_id
WHERE s.student_id = 1;
SHOW TABLES;
SELECT 'Students' AS table_name, COUNT(*) AS records FROM students
UNION ALL
SELECT 'Authors', COUNT(*) FROM authors
UNION ALL
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Books', COUNT(*) FROM books
UNION ALL
SELECT 'Borrowings', COUNT(*) FROM borrowings
UNION ALL
SELECT 'Fines', COUNT(*) FROM fines;
SELECT *
FROM library_borrowing_report;
CREATE VIEW library_borrowing_report AS
SELECT
    b.borrowing_id,
    s.student_name,
    s.department,
    bo.book_title,
    a.author_name,
    c.category_name,
    b.issue_date,
    b.due_date,
    b.return_date,
    b.status
FROM borrowings b
JOIN students s
    ON b.student_id = s.student_id
JOIN books bo
    ON b.book_id = bo.book_id
JOIN authors a
    ON bo.author_id = a.author_id
JOIN categories c
    ON bo.category_id = c.category_id;
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';
SELECT * FROM library_borrowing_report;



