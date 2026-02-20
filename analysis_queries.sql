USE ONLINEBOOKSTORE;

-- Retrieve all books in the "Fiction" genre

SELECT *
FROM BOOKS
WHERE GENRE = 'FICTION';


-- Find books published after the year 1950

SELECT *
FROM BOOKS
WHERE PUBLISHED_YEAR > 1950
ORDER BY PUBLISHED_YEAR;


-- List all customers from the Canada

SELECT *
FROM CUSTOMERS
WHERE COUNTRY = 'CANADA';


-- Show orders placed in November 2023

SELECT *
FROM ORDERS
WHERE YEAR(ORDER_DATE) = '2023'
  AND MONTH(ORDER_DATE) = '11'
ORDER BY ORDER_DATE;


-- Retrieve the total stock of books available

SELECT SUM(STOCK)
FROM BOOKS;


-- Find the details of the most expensive book

SELECT *
FROM BOOKS
ORDER BY PRICE DESC
LIMIT 1;


-- Show all customers who ordered more than 1 quantity of a book

SELECT *
FROM CUSTOMERS
JOIN ORDERS 
  ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
WHERE QUANTITY > 1
ORDER BY QUANTITY;


-- Retrieve all orders where the total amount exceeds $20

SELECT *
FROM ORDERS
WHERE TOTAL_AMOUNT > 20
ORDER BY TOTAL_AMOUNT;


-- List all genres available in the Books table

SELECT GENRE
FROM BOOKS
GROUP BY GENRE;


-- Find the book with the lowest stock

SELECT *
FROM BOOKS
WHERE STOCK = (
    SELECT MIN(STOCK)
    FROM BOOKS
);


-- Calculate the total revenue generated from all orders

SELECT ROUND(SUM(TOTAL_AMOUNT), 2) AS REVENUE
FROM ORDERS;


-- Retrieve the total number of books sold for each genre

SELECT 
    GENRE, 
    SUM(QUANTITY) AS Q
FROM BOOKS
JOIN ORDERS 
  ON BOOKS.BOOK_ID = ORDERS.BOOK_ID
GROUP BY GENRE;


-- Find the average price of books in the "Fantasy" genre

SELECT 
    GENRE, 
    ROUND(AVG(PRICE), 2)
FROM BOOKS
WHERE GENRE = 'FANTASY'
GROUP BY GENRE;


-- List customers who have placed at least 2 orders

SELECT *
FROM (
    SELECT 
        CUSTOMERS.CUSTOMER_ID, 
        NAME, 
        COUNT(NAME) AS COUNT
    FROM CUSTOMERS
    JOIN ORDERS 
      ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
    GROUP BY CUSTOMERS.CUSTOMER_ID, NAME
) AS X
WHERE COUNT >= 2
ORDER BY COUNT;


-- Find the most frequently ordered book

SELECT 
    COUNT(ORDERS.BOOK_ID) AS ORDER_COUNT, 
    BOOKS.BOOK_ID
FROM ORDERS
JOIN BOOKS 
  ON ORDERS.BOOK_ID = BOOKS.BOOK_ID
GROUP BY BOOKS.BOOK_ID;


-- Show the top 3 most expensive books of 'Fantasy' Genre

SELECT *
FROM BOOKS
WHERE GENRE = 'FANTASY'
ORDER BY PRICE DESC
LIMIT 3;


-- Retrieve the total quantity of books sold by each author

SELECT 
    AUTHOR, 
    SUM(QUANTITY)
FROM ORDERS
JOIN BOOKS 
  ON ORDERS.BOOK_ID = BOOKS.BOOK_ID
GROUP BY AUTHOR;


-- List the cities where customers who spent over $30 are located

SELECT CITY
FROM CUSTOMERS
JOIN ORDERS 
  ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
WHERE TOTAL_AMOUNT > 30
GROUP BY CITY;


-- Find the customer who spent the most on orders

SELECT 
    CUSTOMERS.CUSTOMER_ID, 
    NAME, 
    SUM(TOTAL_AMOUNT) AS TM
FROM CUSTOMERS
JOIN ORDERS 
  ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
GROUP BY CUSTOMERS.CUSTOMER_ID, NAME
ORDER BY TM DESC;


-- Calculate the stock remaining after fulfilling all orders

SELECT 
    BOOKS.BOOK_ID,
    TITLE,
    AUTHOR,
    GENRE,
    PUBLISHED_YEAR,
    PRICE,
    (STOCK - QUANTITY) AS TOTALSTOCK
FROM BOOKS
JOIN ORDERS 
  ON BOOKS.BOOK_ID = ORDERS.BOOK_ID;