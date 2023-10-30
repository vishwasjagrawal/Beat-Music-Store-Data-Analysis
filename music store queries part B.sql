-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with A
SELECT DISTINCT email, first_name, last_name, genre.name AS genre_name 
FROM genre JOIN track ON genre.genre_id=track.genre_id
	JOIN invoice_line ON track.track_id=invoice_line.track_id
	JOIN invoice ON invoice_line.invoice_id=invoice.invoice_id
	JOIN customer ON invoice.customer_id=customer.customer_id
WHERE genre.name = 'Rock'
ORDER BY email

--2. Let's invite the artists who have written the most rock music in our dataset. Write a
-- Query that returns the Artist name and total track count of the top 10 rock bands.
SELECT artist.name, COUNT(track_id) AS total_track_count
FROM genre JOIN track ON genre.genre_id=track.genre_id
	JOIN album ON track.album_id=album.album_id
	JOIN artist ON album.artist_id=artist.artist_id
WHERE genre.name = 'Rock'
GROUP BY artist.name
ORDER BY total_track_count DESC
LIMIT 10

/* 3. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first */
SELECT name AS track_name, milliseconds AS song_length
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC