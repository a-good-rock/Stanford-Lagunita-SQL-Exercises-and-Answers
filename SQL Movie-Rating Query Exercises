/* Q1. Find the titles of all movies directed by Steven Spielberg.  */

SELECT title
FROM Movie
WHERE director = "Steven Spielberg";


/* Q2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. */

SELECT year
FROM Movie 
WHERE mID in (SELECT mID FROM Rating WHERE stars >= 4)
ORDER by year;


/* Q3. Find the titles of all movies that have no ratings. */

SELECT title
FROM Movie
WHERE mID not in (SELECT mID FROM Rating);


/* Q4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a 
       NULL value for the date.  */
SELECT name
FROM Reviewer 
WHERE rID in (SELECT rID FROM Rating WHERE ratingDate IS NULL);


/* Q5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
       Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.  */
       
SELECT name, title, stars, ratingDate
FROM Movie join Rating on Movie.mID = Rating.mID join Reviewer on Rating.rID = Reviewer.rID
ORDER by name, title, stars;


/* Q6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the 
       reviewer's name and the title of the movie. */
 
SELECT name, title
FROM Reviewer join Rating using(rID) join Movie using(mID) join Rating r on r.rID = Rating.rID
WHERE r.mID = rating.mID and r.ratingDate > Rating.ratingDate and r.stars > Rating.stars;


/* Q7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and 
       number of stars. Sort by movie title.  */
       
SELECT title, max(stars)
FROM Movie join Rating using(mID)
GROUP by mID
ORDER by title;


/* Q8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given 
       to that movie. Sort by rating spread from highest to lowest, then by movie title. */
       
SELECT title, (max(stars) - min(stars)) as spread
FROM Rating join Movie using(mID)
GROUP by mID
ORDER by spread DESC, title;


/* Q9. Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 
       1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 
       and movies after. Don't just calculate the overall average rating before and after 1980.) */
       
SELECT abs(postAvg - preAvg)
FROM (SELECT avg(avgStars) as postAvg FROM (SELECT avg(stars) as avgStars FROM Rating join Movie using(mID) WHERE year > 1980 GROUP by mID)),
(SELECT avg(avgStars) as preAvg FROM (SELECT avg(stars) as avgStars FROM Rating join Movie using(mID) WHERE year < 1980 GROUP by mID));

 
 
