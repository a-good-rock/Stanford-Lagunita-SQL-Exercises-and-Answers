/* Q1. Find the names of all students who are friends with someone named Gabriel.*/

SELECT name 
FROM Highschooler join Friend on ID = ID1
WHERE ID2 in (SELECT ID FROM Highschooler WHERE name = "Gabriel");


/* Q2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and 
       the name and grade of the student they like. */
       
SELECT x.name, x.grade, y.name, y.grade
FROM Highschooler x join Likes on x.ID = ID1 join Highschooler y on y.ID = ID2
WHERE (x.grade - y.grade) >= 2;


/* Q3. For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, 
       with the two names in alphabetical order. */

SELECT distinct x.name, x.grade, y.name, y.grade
FROM Highschooler x join Likes a on x.ID = a.ID1 join Highschooler y on y.ID = a.ID2 join Likes b on b.ID1 = y.ID
WHERE b.ID2 = x.ID and x.name < y.name
ORDER by x.name, y.name;


/* Q4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and 
       grades. Sort by grade, then by name within each grade. */
       
SELECT name, grade
FROM Highschooler
WHERE ID not in (SELECT ID1 FROM Likes) and ID not in (SELECT ID2 FROM Likes)
ORDER by grade, name;


/* Q5. For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not 
       appear as an ID1 in the Likes table), return A and B's names and grades. */

SELECT a.name, a.grade, b.name, b.grade
FROM Highschooler a join Likes on a.ID = Likes.ID1 join Highschooler b on b.ID = Likes.ID2
WHERE b.ID not in (SELECT ID1 FROM Likes);


/* Q6. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by 
       name within each grade. */

SELECT distinct name, grade
FROM Highschooler join Friend on ID = ID1
WHERE ID not in (SELECT ID1 FROM Highschooler a join Friend on a.ID = ID1 join Highschooler b on b.ID = ID2 WHERE  a.grade <> b.grade)
ORDER by grade, name;


/* Q7. For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can 
       introduce them!). For all such trios, return the name and grade of A, B, and C. */

SELECT distinct a.name, a.grade, b.name, b.grade, c.name, c.grade
FROM Highschooler a, Highschooler b, Highschooler c, Friend f, Likes x, Friend g
WHERE a.ID = x.ID1 and b.ID = x.ID2 and a.ID = f.ID1 and b.ID not in (SELECT ID2 FROM Friend WHERE ID1 = a.ID)
      and c.ID = f.ID2 and b.ID = g.ID1 and c.ID = g.ID2; 
      

/* Q8. Find the difference between the number of students in the school and the number of different first names. */

SELECT count(ID) - count(distinct name)
FROM Highschooler;


/* Q9. Find the name and grade of all students who are liked by more than one other student. */

SELECT name, grade
FROM Highschooler
WHERE ID in (SELECT ID2 FROM Likes GROUP BY ID2 HAVING count(ID1) > 1);

