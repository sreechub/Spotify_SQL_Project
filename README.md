# Spotify Songs Data Analysis using SQL

![Spotify Logo](https://github.com/sreechub/Spotify_SQL_Project/blob/main/spotify_img.png)

## Objective

## Overview 
This project entails exploring a comprehensive Spotify dataset, encompassing diverse attributes related to tracks, albums, and artists, using **SQL**. The scope includes transforming a denormalized dataset into a normalized structure, executing SQL queries spanning multiple complexity levels (introductory, intermediate, and advanced), and enhancing query efficiency. Ultimately, the project aims to hone advanced SQL proficiency and uncover meaningful insights from the dataset.

```sql
-- create table
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
## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `Artist`: The performer of the track.
- `Track`: The name of the song.
- `Album`: The album to which the track belongs.
- `Album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.

### 4. Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into **easy**, **medium**, and **advanced** levels to help progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.

### 5. Query Optimization
In advanced stages, the focus shifts to improving query performance. Some optimization strategies include:
- **Indexing**: Adding indexes on frequently queried columns.
- **Query Execution Plan**: Using `EXPLAIN ANALYZE` to review and refine query performance.
  
---
## Analytical Questions

1. **Retrieve the names of all tracks that have more than 1 billion streams.**
   ```sql
   SELECT track,
   stream from spotify
   WHERE stream > 1000000000
   ```
4. List all albums along with their respective artists.
5. Get the total number of comments for tracks where `licensed = TRUE`.
6. Find all tracks that belong to the album type `single`.
7. Count the total number of tracks by each artist.
8. Calculate the average danceability of tracks in each album.
9. Find the top 5 tracks with the highest energy values.
10. List all tracks along with their views and likes where `official_video = TRUE`.
11. For each album, calculate the total views of all associated tracks.
12. Retrieve the track names that have been streamed on Spotify more than YouTube.
13. Find the top 3 most-viewed tracks for each artist using window functions.
14. Write a query to find tracks where the liveness score is above the average.
15. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
```sql
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC
```
   
