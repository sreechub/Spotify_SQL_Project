# Spotify Songs Data Analysis using SQL

![Spotify Logo](https://github.com/sreechub/Spotify_SQL_Project/blob/main/spotify_img.png)

## Objective

## Overview 
This project entails exploring a comprehensive Spotify dataset, encompassing diverse attributes related to tracks, albums, and artists, using **SQL**. The scope includes transforming a denormalized dataset into a normalized structure, executing SQL queries spanning multiple complexity levels (introductory, intermediate, and advanced), and enhancing query efficiency. Ultimately, the project aims to hone advanced SQL proficiency and uncover meaningful insights from the dataset.


## Creating a table

```sql
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
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```


Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `Artist`: The performer of the track.
- `Track`: The name of the song.
- `Album`: The album to which the track belongs.
- `Album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.

After the data is inserted, various SQL queries can be written to explore and analyze the data. 


---
## Analytical Questions

1. **Retrieve the names of all tracks that have more than 1 billion streams.**
   ```sql
   SELECT track,
   stream from spotify
   WHERE stream > 1000000000
   ```
   
2. **List all albums along with their respective artists.**
   ```sql
   SELECT DISTINCT album,
   artist from spotify
   order by 1
   ```
   
3. **Get the total number of comments for tracks where `licensed = TRUE`.**
   ```sql
   SELECT SUM(comments) as total_comments
   FROM spotify
   WHERE licensed = 'true'
   ```
   
4. **Find all tracks that belong to the album type `single`.**
   ```sql
   SELECT *
   FROM spotify
   WHERE album_type = 'single'
   ```
   
5. **Count the total number of tracks by each artist.**
    ```sql
    SELECT artist,
    COUNT(*) AS total_num_songs
    FROM spotify
    GROUP BY artist
    ORDER BY 2
    ```
    
6. **Calculate the average danceability of tracks in each album.**
    ```sql
    SELECT album,
    avg(danceability) as avg_danceability
    FROM spotify
    GROUP BY 1
    ORDER BY 2 DESC
    ```
    
7. **Find the top 5 tracks with the highest energy values.**
    ```sql
    SELECT track,
    MAX(energy)
    FROM spotify
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5
    ```
    
8. **List all tracks along with their views and likes where `official_video = TRUE`.**
    ```sql
    SELECT track,
    SUM(views) as total_views,
    SUM(likes) as total_likes
    FROM spotify
    WHERE official_video = 'true'
    GROUP BY 1
    ORDER BY 2 DESC
    ```
    
9. **For each album, calculate the total views of all associated tracks.**
    ```sql
    SELECT album,
    track,
    SUM(views)
    FROM spotify
    GROUP BY 1, 2
    ORDER BY 3 DESC
    ```
    
10. **Retrieve the track names that have been streamed on Spotify more than YouTube.**
    ```sql
    SELECT * FROM
    (SELECT track,
    COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) as streamed_on_youtube,
    COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) as streamed_on_spotify
    FROM spotify
    GROUP BY 1
    ) as t1
    WHERE streamed_on_spotify > streamed_on_youtube
    AND streamed_on_youtube <> 0
    ```
    
11. **Find the top 3 most-viewed tracks for each artist using window functions.**
    ```sql
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
    ```
    
12. **Write a query to find tracks where the liveness score is above the average.**
    ```sql
    SELECT track,
    artist,
    liveness
    FROM spotify
    WHERE liveness > (SELECT AVG(liveness) FROM spotify)
    ```
    
13. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
    ```sql
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
    ```
## Technology Stack
   **Database:** PostgreSQL
   **SQL Queries:** DDL, DML, Aggregations, Joins, Subqueries, Window Functions
   **Tools:** pgAdmin 4 (or any SQL editor), PostgreSQL (via Homebrew, Docker, or direct installation)
   
