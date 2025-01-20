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

SELECT FirstName || ' ' || LastName AS FullName 
FROM employees 
WHERE Title = 'Sales Support Agent';

-- part 2

SELECT media_types.Name, COUNT(tracks.TrackId) AS UsageCount 
FROM media_types
JOIN tracks ON media_types.MediaTypeId = tracks.MediaTypeId 
GROUP BY media_types.MediaTypeId 
ORDER BY UsageCount DESC;

SELECT customers.FirstName || ' ' || customers.LastName AS FullName, 
       invoices.InvoiceId, 
       invoices.InvoiceDate, 
       invoices.BillingCountry 
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId 
WHERE customers.Country = 'Brazil';

SELECT artists.Name AS ArtistName, COUNT(tracks.TrackId) AS TotalTracks 
FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId 
JOIN tracks ON albums.AlbumId = tracks.AlbumId 
JOIN genres ON tracks.GenreId = genres.GenreId 
WHERE genres.Name = 'Rock' 
GROUP BY artists.ArtistId 
ORDER BY TotalTracks DESC 
LIMIT 10;

SELECT customers.FirstName || ' ' || customers.LastName AS FullName, 
       SUM(invoices.Total) AS TotalSpent 
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId 
GROUP BY customers.CustomerId 
ORDER BY TotalSpent DESC 
LIMIT 1;

SELECT customers.FirstName || ' ' || customers.LastName AS FullName, 
       customers.CustomerId, 
       customers.Country 
FROM customers 
WHERE customers.Country != 'USA';

SELECT playlists.Name AS PlaylistName, COUNT(playlist_track.TrackId) AS TrackCount 
FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId 
GROUP BY playlists.PlaylistId 
ORDER BY TrackCount DESC;

SELECT tracks.Name AS TrackName, 
       albums.Title AS AlbumName, 
       media_types.Name AS MediaType, 
       genres.Name AS Genre 
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId 
JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId 
JOIN genres ON tracks.GenreId = genres.GenreId;

SELECT artists.Name AS ArtistName, 
       SUM(invoice_items.UnitPrice * invoice_items.Quantity) AS TotalEarnings 
FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId 
JOIN tracks ON albums.AlbumId = tracks.AlbumId 
JOIN invoice_items ON tracks.TrackId = invoice_items.TrackId 
GROUP BY artists.ArtistId 
ORDER BY TotalEarnings DESC 
LIMIT 10;

SELECT media_types.Name AS MediaType, COUNT(invoice_items.InvoiceLineId) AS PurchaseCount 
FROM media_types
JOIN tracks ON media_types.MediaTypeId = tracks.MediaTypeId 
JOIN invoice_items ON tracks.TrackId = invoice_items.TrackId 
GROUP BY media_types.MediaTypeId 
ORDER BY PurchaseCount DESC 
LIMIT 1;




