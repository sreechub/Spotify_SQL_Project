DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
artist VARCHAR(255),
track VARCHAR(255),
album VARCHAR(255),
album_type VARCHAR(50),
danceability FLOAT,
energy FLOAT,
loudness FLOAT,
speechiness FLOAT,
acousticness FLOAT,
instrumentalness FLOAT,
liveness FLOAT,
valence FLOAT,
tempo FLOAT,
duration_min FLOAT,
title VARCHAR(255),
channel VARCHAR(255),
views FLOAT,
likes FLOAT, 
comments FLOAT,
licensed BOOLEAN,
official_video BOOLEAN,
stream BIGINT,
energy_liveness FLOAT,
most_played_on VARCHAR(50)
);

SELECT * FROM spotify;
--Q1. Retreive the names of all tracks that have 1 billion streams.
SELECT track, 
stream from spotify 
WHERE stream > 1000000000
--Q2. List all albums along with their respective artists.
SELECT DISTINCT album, 
artist from spotify 
order by 1 
--Q3. Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) as total_comments
FROM spotify 
WHERE licensed = 'true'

--Q4. Find all tracks that belong to the album type single.
SELECT * FROM spotify 
WHERE album_type = 'single'

--Q5. Count the total number of tracks by each artist.
SELECT artist, 
COUNT(*) AS total_num_songs
FROM spotify
GROUP BY artist 
ORDER BY 2

--Q6. Calculate the average danceability of tracks in each album.
SELECT album,
avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC

--Q7. Find the top 5 tracks with the highest energy values.
SELECT track,
MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--Q8. List all tracks along with their views and likes where official_video = TRUE.
SELECT track,
SUM(views) as total_views,
SUM(likes) as total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC

--Q9. For each album, calculate the total views of all associated tracks.
SELECT album,
track,
SUM(views)
FROM spotify
GROUP BY 1, 2
ORDER BY 3 DESC

--Q10. Retreive the track names that have been streamed on Spotify more than Youtube.
SELECT * FROM
(SELECT track,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) as streamed_on_youtube,
COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) as streamed_on_spotify
FROM spotify
GROUP BY 1
) as t1
WHERE streamed_on_spotify > streamed_on_youtube
AND streamed_on_youtube <> 0

--Q11. Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist
as
(SELECT artist,
track,
SUM(views) as total_view,
DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) as rank
FROM spotify
GROUP BY 1, 2
ORDER BY 1, 3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3

--Q12. Write a query to find tracks where the liveness score is above the average
SELECT track,
artist,
liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

--Q13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte
as
(SELECT album,
MAX(energy) as highest_energy,
MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1
)
SELECT album,
highest_energy - lowest_energy as energy_diff
FROM cte
ORDER BY 2 DESC