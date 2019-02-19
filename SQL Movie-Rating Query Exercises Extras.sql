/* Q1. Find the names of all reviewers who rated Gone with the Wind.  */

SELECT name
FROM Reviewer
WHERE rID in (SELECT rID FROM Rating WHERE mID = (SELECT mID FROM Movie WHERE title = "Gone with the Wind"));


/* Q2. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, 
       and number of stars. */

SELECT name, title, stars
FROM Movie join Rating using(mID) join Reviewer using(rID)
WHERE director = name;


/* Q3. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the 
       reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)  */

SELECT name
FROM Reviewer
UNION
SELECT title 
FROM Movie
ORDER by name, title;


/* Q4. Find the titles of all movies not reviewed by Chris Jackson. */

SELECT title
FROM Movie
WHERE mID not in (SELECT mID FROM Rating Where rID = (SELECT rID FROM Reviewer WHERE name = "Chris Jackson"));


/* Q5. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
       Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the 
       names in the pair in alphabetical order. */

SELECT distinct x.name, y.name
FROM (Reviewer join Rating using(rID)) x join (Reviewer join Rating using(rID)) y
WHERE x.mID = y.mID and x.rID <> y.rID and x.name < y.name
ORDER by x.name, y.name;



/* Q6. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and 
       number of stars. */

SELECT name, title, stars
FROM Movie join Rating using(mID) join Reviewer using(rID)
WHERE stars = (SELECT min(stars) FROM Rating);


/* Q7. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, 
       list them in alphabetical order. */

SELECT title, avg(stars) as avgStars
FROM Movie join Rating using(mID)
GROUP by mID
ORDER by avgStars DESC, title;


/* Q8. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query 
       without HAVING or without COUNT.) */
       
SELECT name
FROM Reviewer 
WHERE rID in (SELECT rID FROM Rating GROUP by rID HAVING count(all mID) >= 3);


/* Q9. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, 
       along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both 
       with and without COUNT.) */
       
SELECT title, director
FROM Movie
WHERE director in (SELECT director FROM Movie GROUP by director HAVING count(mID) > 1)
ORDER by director, title;


/* Q10.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more 
   difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing 
   the movie(s) with that average rating.) */

SELECT title, avg(stars) as avgStars
FROM Movie join Rating using(mID) 
GROUP by mID
HAVING avgStars = (SELECT max(avgRating) FROM (SELECT avg(stars) as avgRating FROM Rating GROUP by mID));


/* Q11. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more 
   difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the
   movie(s) with that average rating.) */

SELECT title, avg(stars)
FROM Rating join Movie using(mID)
GROUP by mID
HAVING avg(stars) = (SELECT min(avgStars) FROM (SELECT avg(stars) as avgStars FROM Rating GROUP by mID));


/* Q12. For each director, return the director's name together with the title(s) of the movie(s) they directed that received the 
   highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.*/

SELECT director, title, stars
FROM Movie join Rating using(mID)
WHERE director IS NOT NULL
GROUP by director
HAVING stars = max(stars);

