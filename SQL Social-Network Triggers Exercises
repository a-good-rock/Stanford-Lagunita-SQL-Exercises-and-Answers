/* Q1. Write a trigger that makes new students named 'Friendly' automatically like everyone else in their grade. That is, after the 
       trigger runs, we should have ('Friendly', A) in the Likes table for every other Highschooler A in the same grade as 'Friendly'.*/

CREATE TRIGGER A
AFTER INSERT on Highschooler
For each row
WHEN new.name = "Friendly"
begin
    INSERT into Likes SELECT new.ID, ID FROM Highschooler WHERE grade = new.grade and new.ID <> ID;
end


/* Q2. Write one or more triggers to manage the grade attribute of new Highschoolers. If the inserted tuple has a value less than 9 or 
       greater than 12, change the value to NULL. On the other hand, if the inserted tuple has a null value for grade, change it to 9. */

CREATE Trigger g
AFTER insert on Highschooler
For each row
WHEN new.grade > 12 or new.grade < 9
begin
    UPDATE Highschooler set grade = NULL WHERE id = new.id;
end
|
CREATE Trigger n
AFTER INSERT on Highschooler
for each row
WHEN new.grade IS NULL
begin
    UPDATE Highschooler set grade = 9 WHERE id = new.id;
end


/* Q3. Write one or more triggers to maintain symmetry in friend relationships. Specifically, if (A,B) is deleted from Friend, then
       (B,A) should be deleted too. If (A,B) is inserted into Friend then (B,A) should be inserted too. Don't worry about updates 
       to the Friend table. */

CREATE Trigger d
AFTER delete on Friend
for each row
begin
    delete from Friend WHERE ID1 = old.ID2 and ID2 = old.ID1;
end
|
CREATE Trigger i
AFTER INSERT on Friend
for each row
begin
    insert into Friend values (new.ID2, new.ID1);
end


/* Q4. Write a trigger that automatically deletes students when they graduate, i.e., when their grade is updated to exceed 12. */

CREATE Trigger e
AFTER UPDATE on Highschooler
for each row
WHEN new.grade > 12
begin
    DELETE from Highschooler WHERE id = new.id;
end


/* Q5. Write a trigger that automatically deletes students when they graduate, i.e., when their grade is updated to exceed 12 
       (same as Question 4). In addition, write a trigger so when a student is moved ahead one grade, then so are all of his or 
       her friends. */

CREATE Trigger m
AFTER UPDATE on Highschooler
for each row
WHEN new.grade > old.grade
begin
    UPDATE Highschooler set grade = grade+1 WHERE ID in (SELECT ID2 FROM Friend WHERE ID1 = new.ID);
end
|
CREATE Trigger d
AFTER UPDATE on Highschooler
for each row
WHEN new.grade > 12
begin
    DELETE from Highschooler WHERE id = new.id;
end

/* Q6. Write a trigger to enforce the following behavior: If A liked B but is updated to A liking C instead, and B and C were 
       friends, make B and C no longer friends. Don't forget to delete the friendship in both directions, and make sure the trigger 
       only runs when the "liked" (ID2) person is changed but the "liking" (ID1) person is not changed. */

CREATE Trigger 
AFTER UPDATE on Likes
for each row
WHEN new.ID1 = old.ID1 and new.ID2 <> old.ID2
begin
    DELETE from Friend WHERE ID1 = old.ID2 and ID2 = new.ID2;
    DELETE from Friend WHERE ID1 = new.ID2 and ID2 = old.ID2;
end
