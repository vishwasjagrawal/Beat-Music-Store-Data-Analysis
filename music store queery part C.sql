/* 1. Find how much amount spent by each customer on best selling artist? Write a query to return
customers name, artist name and total spent */
WITH bsa AS
(SELECT artist.artist_id, artist.name AS artist_name, SUM(quantity * invoice_line.unit_price) AS total_spend
FROM invoice_line
	JOIN track ON invoice_line.track_id=track.track_id
	JOIN album ON track.album_id=album.album_id 
	JOIN artist ON album.artist_id=artist.artist_id
GROUP BY artist.artist_id, artist.name
ORDER BY total_spend DESC
LIMIT 1
)
SELECT artist_name, first_name, last_name, SUM(quantity * invoice_line.unit_price) AS total_sp
FROM customer 
	JOIN invoice ON customer.customer_id=invoice.customer_id
	JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
	JOIN track ON invoice_line.track_id=track.track_id
	JOIN album ON track.album_id=album.album_id 
	JOIN bsa ON album.artist_id=bsa.artist_id
GROUP BY artist_name, first_name, last_name
ORDER BY total_sp DESC	


/* 2. We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres */
WITH country_best_genre AS
(SELECT  billing_country, genre.name AS genre_n, SUM(invoice_line.unit_price * invoice_line.quantity) AS total_purchase, 
	ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(invoice_line.unit_price * invoice_line.quantity) DESC) AS r_no
FROM invoice
	JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
	JOIN track ON invoice_line.track_id=track.track_id
	JOIN genre ON track.genre_id=genre.genre_id
GROUP BY billing_country, genre.name 
ORDER BY billing_country ASC, total_purchase DESC)

SELECT  billing_country AS country_n , genre_n, total_purchase
FROM country_best_genre 
WHERE r_no = 1


/* 3. Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount */
WITH country_best_customer AS(
	SELECT  billing_country, first_name, last_name, SUM(invoice_line.unit_price * invoice_line.quantity) AS total_purchase, 
		ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(invoice_line.unit_price * invoice_line.quantity) DESC) AS r_no
	FROM customer
 		JOIN invoice ON customer.customer_id=invoice.customer_id
		JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
	GROUP BY billing_country, first_name, last_name 
	ORDER BY billing_country ASC)

SELECT  billing_country AS country_n , first_name, last_name, total_purchase
FROM country_best_customer
WHERE r_no = 1
