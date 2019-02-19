/* Q1. For every situation where student A likes student B, but student B likes a different student C, return the names and grades of 
       A, B, and C. */
       
SELECT a.name, a.grade, b.name, b.grade, c.name, c.grade
FROM Highschooler a join Likes x on a.ID = x.ID1 join Highschooler b on x.ID2 = b.ID join Likes y on b.ID = y.ID1
     join Highschooler c on y.ID2 = c.ID
WHERE a.ID not in (SELECT ID2 FROM Likes WHERE ID1 = b.ID);


/* Q2. Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades. */

SELECT name, grade
FROM Highschooler 
WHERE ID not in (SELECT ID1 FROM Friend join Highschooler a on ID1 = a.ID join Highschooler b on b.ID = ID2
                 WHERE b.grade = a.grade);
                 

/* Q3. What is the average number of friends per student? (Your result should be just one number.) */

SELECT avg(friendCount) 
FROM (SELECT count(ID2) as friendCount FROM Friend GROUP by ID1);


/* Q4. Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count 
       Cassandra, even though technically she is a friend of a friend. */
       
SELECT count(distinct g.ID2) + count(distinct f.ID2)
FROM (SELECT ID FROM Highschooler WHERE name = "Cassandra") a join Friend f on a.ID = f.ID1
      join Friend g on f.ID2 = g.ID1
WHERE g.ID2 <> a.ID and f.ID2 <> g.ID2;       


/* Q5. Find the name and grade of the student(s) with the greatest number of friends. */

SELECT name, grade
FROM Highschooler join Friend on ID = ID1
GROUP by ID
Having count(ID2) = (SELECT max(friendCount) FROM (SELECT count(ID2) as friendCount FROM Friend GROUP by ID1));
