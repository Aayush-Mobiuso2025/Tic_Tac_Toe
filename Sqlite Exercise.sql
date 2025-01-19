SELECT * FROM albums;

SELECT Title 
FROM albums 
WHERE AlbumId = 67;

SELECT Name, Milliseconds / 1000 AS LengthInSeconds 
FROM tracks 
WHERE LengthInSeconds BETWEEN 50 AND 70;

SELECT albums.Title 
FROM albums
JOIN artists ON albums.ArtistId = artists.ArtistId 
WHERE artists.Name LIKE '%black%';

SELECT DISTINCT BillingCountry 
FROM invoices;

SELECT invoices.BillingCity, SUM(invoices.Total) AS TotalInvoiceAmount 
FROM invoices 
GROUP BY invoices.BillingCity 
ORDER BY TotalInvoiceAmount DESC 
LIMIT 1;
