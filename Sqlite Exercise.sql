SELECT * FROM albums;

SELECT Title 
FROM albums 
WHERE AlbumId = 67;

SELECT Name, Milliseconds / 1000 AS LengthInSeconds 
FROM tracks 
WHERE LengthInSeconds BETWEEN 50 AND 70;
