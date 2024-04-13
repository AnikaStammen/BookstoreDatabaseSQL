-- Creating the customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(255)
);

-- Creating the books table
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    price NUMERIC(10, 2),
    genre VARCHAR(255)
);

-- Creating the orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id),
    customer_id INT REFERENCES customers(customer_id),
    quantity INT,
    order_date DATE
);

-- Populating 'customers' table
INSERT INTO customers (customer_id,name, email, address) VALUES
(1,'Alice Johnson', 'alicejohnson@example.com', '123 Elm St'),
(2,'Bob Smith', 'bobsmith@example.com', '456 Oak St'),
(3,'Carol Taylor', 'caroltaylor@example.com', '789 Pine St'),
(4,'David Lee', 'davidlee@example.com', '1012 Maple St'),
(5,'Emma Wilson', 'emmawilson@example.com', '234 Spruce St'),
(6,'Frank Moore', 'frankmoore@example.com', '567 Cedar St'),
(7,'Grace Hall', 'gracehall@example.com', '890 Birch St'),
(8,'Henry Allen', 'henryallen@example.com', '321 Ash St'),
(9,'Isabel Scott', 'isabelscott@example.com', '654 Redwood St'),
(10,'Jack Brown', 'jackbrown@example.com', '987 Walnut St');

-- Populating 'books' table
INSERT INTO books (book_id,title, price, genre) VALUES
(1,'1984', 15.00, 'Dystopian'),
(2,'To Kill a Mockingbird', 10.00, 'Fiction'),
(3,'The Great Gatsby', 20.00, 'Classic'),
(4,'Harry Potter and the Sorcerer’s Stone', 22.00, 'Fantasy'),
(5,'The Catcher in the Rye', 18.00, 'Literature'),
(6,'The Hobbit', 25.00, 'Fantasy'),
(7,'Pride and Prejudice', 19.50, 'Romance'),
(8,'Brave New World', 16.50, 'Dystopian'),
(9,'The Diary of Anne Frank', 13.50, 'Biography'),
(10,'Moby Dick', 17.50, 'Adventure'),
(11,'War and Peace', 21.00, 'Historical Fiction'),
(12,'The Lord of the Rings', 23.00, 'Fantasy'),
(13,'Crime and Punishment', 12.50, 'Crime'),
(14,'Wuthering Heights', 15.50, 'Gothic Fiction');

-- Populating 'orders' table
INSERT INTO orders (book_id, customer_id, quantity, order_date) VALUES
(1, 1, 1, '2023-01-15'),
(2, 2, 2, '2023-02-20'),
(3, 3, 1, '2023-03-05'),
(4, 1, 1, '2023-04-10'),
(5, 5, 2, '2023-04-15'),
(6, 6, 1, '2023-01-22'),
(7, 7, 3, '2023-02-25'),
(8, 8, 1, '2023-03-15'),
(9, 9, 2, '2023-01-30'),
(10, 10, 1, '2023-02-05'),
(11, 4, 2, '2023-04-20'),
(12, 2, 1, '2023-01-28'),
(13, 3, 1, '2023-02-17'),
(14, 1, 2, '2023-03-23'),
(14, 5, 3, '2023-04-12');


-- Insert data into the customers table
INSERT INTO customers (name, email, address) 
VALUES ('David Lee', 'davidlee@example.com', '1012 Maple St');

-- Update a book's price in the books table
UPDATE books 
SET price = price * 1.1 
WHERE book_id = 1;
-- Select all books cheaper than $15
SELECT * FROM books 
WHERE price < 15;



-- Calculate the total quantity of orders
SELECT SUM(quantity) AS total_quantity 
FROM orders;

-- List books with their orders
SELECT b.title, o.quantity, o.order_date 
FROM books AS b 
LEFT JOIN orders AS o 
ON b.book_id = o.book_id;

-- Find customers who ordered more than 1 book
SELECT DISTINCT c.name 
FROM customers AS c 
JOIN orders AS o 
ON c.customer_id = o.customer_id 
WHERE o.quantity > 1;


-- Count the number of books ordered by each customer
SELECT customer_id, COUNT(*) AS books_ordered 
FROM orders 
GROUP BY customer_id;

-- Increase order quantity by 1 for orders placed on '2023-03-10'
UPDATE orders 
SET quantity = quantity + 1 
WHERE order_date = '2023-03-10';

-- Delete orders with a specific book_id
DELETE FROM orders 
WHERE book_id = 3;

-- List all customers along with the books they have ordered and the quantity
SELECT c.name, b.title AS book_title, o.quantity 
FROM customers AS c 
JOIN orders AS o 
ON c.customer_id = o.customer_id 
JOIN books AS b 
ON o.book_id = b.book_id;

-- Insert multiple orders
INSERT INTO orders (book_id, customer_id, quantity, order_date) 
VALUES (1, 2, 1, '2023-04-01'), (2, 1, 2, '2023-04-02');

-- Retrieve orders made in March 2023
SELECT * FROM orders 
WHERE order_date 
BETWEEN '2023-03-01' 
AND '2023-03-31';

-- Show total sales (quantity) per book
SELECT book_id, SUM(quantity) AS total_sales 
FROM orders 
GROUP BY book_id;

-- Update customer email
UPDATE customers 
SET email = 'alicejohnson@newexample.com' 
WHERE customer_id = 1;

-- Select books not yet ordered
SELECT b.title 
FROM books AS b 
LEFT JOIN orders AS o 
ON b.book_id = o.book_id 
WHERE o.order_id IS NULL;

-- List customers and their total orders in descending order
SELECT c.customer_id, c.name, SUM(o.quantity) AS total_orders 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id 
ORDER BY total_orders DESC;

-- Delete customers with no orders
DELETE FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Show average book price
SELECT AVG(price) AS average_book_price 
FROM books;