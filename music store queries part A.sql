-- Q1 who is the senior most employee basen on job title?
SELECT employee_id, first_name, last_name, title, levels
FROM employee
ORDER BY levels DESC
LIMIT 1

-- Q2 which countries have the most invoices?
SELECT DISTINCT billing_country, COUNT(*) as number_of_invoice
FROM invoice
GROUP BY billing_country
ORDER BY number_of_invoice DESC

-- Q3 what are top 3 values of total invoice?
SELECT invoice_id, total
FROM invoice
ORDER BY total DESC
LIMIT 3

/* Q4 Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals */
SELECT DISTINCT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1

/* Q5 Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money */
SELECT invoice.customer_id, first_name, last_name, SUM(total) as total_spend
FROM customer JOIN invoice 
ON customer.customer_id = invoice.customer_id
GROUP BY invoice.customer_id, first_name, last_name
ORDER BY total_spend DESC
LIMIT 1