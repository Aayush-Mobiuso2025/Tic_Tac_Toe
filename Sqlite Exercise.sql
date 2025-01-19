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

SELECT customers.Country, COUNT(customers.CustomerId) AS CustomerCount 
FROM customers 
GROUP BY customers.Country 
ORDER BY CustomerCount DESC;

SELECT customers.FirstName || ' ' || customers.LastName AS FullName, customers.CustomerId, SUM(invoices.Total) AS TotalSales 
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId 
GROUP BY customers.CustomerId 
ORDER BY TotalSales DESC 
LIMIT 5;

SELECT State, COUNT(CustomerId) AS CustomerCount 
FROM customers 
WHERE State IS NOT NULL 
GROUP BY State 
ORDER BY CustomerCount DESC;

SELECT strftime('%Y', InvoiceDate) AS Year, COUNT(InvoiceId) AS InvoiceCount 
FROM invoices 
WHERE Year IN ('2009', '2011') 
GROUP BY Year;









