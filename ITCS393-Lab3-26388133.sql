-- Q1
 SELECT StudentID, FirstName, LastName, year(current_date()) - year(Birthdate) as 'Age'
 FROM Student 
 WHERE EMail LIKE '%@hotmail.com%';

-- Q2
SELECT StudentID, concat(FirstName, ' ' ,LastName) AS 'Fullname', year(current_date()) - year(Birthdate) as 'Age'
FROM Student 
WHERE year(current_date()) - year(Birthdate) > 20;

-- Q3
SELECT concat(s.FirstName, ' ' ,s.LastName) AS 'Fullname', s.EMail, s.Phone
FROM student s INNER JOIN Payment p ON s.StudentID = p.StudentID;

-- Q4
SELECT s.StudentID, p.ExamID, concat(s.FirstName, ' ' ,s.LastName) AS 'Fullname', e.Score AS 'Examination Score'
FROM student s INNER JOIN PracticeExam p ON s.StudentID = p.StudentID 
INNER JOIN ExamScore e ON p.ExamID = e.ExamID;

-- Q5
SELECT concat(s.FirstName, ' ' ,s.LastName) AS 'Fullname', e.Score AS 'Examination Score'
FROM student s INNER JOIN PracticeExam p ON s.StudentID = p.StudentID 
INNER JOIN ExamScore e ON p.ExamID = e.ExamID
ORDER BY Score DESC LIMIT 1;

-- Q6
SELECT concat(i.Firstname, ' ', i.Lastname) AS 'Full Name', CourseAmount
FROM Instructor i LEFT JOIN Course c ON i.InstructorID = c.InstructorID
ORDER BY CourseAmount DESC LIMIT 1;

-- Q7
SELECT concat(s.Firstname, ' ', s.Lastname) AS 'Full Name', CourseAmount
FROM student s LEFT JOIN EnrollCourse e ON s.StudentID = e.StudentID 
INNER JOIN Course c ON e.CourseID = c.CourseID
WHERE CourseAmount = (SELECT MAX(CourseAmount) FROM Course)
ORDER BY CourseAmount DESC;

-- Q8
SELECT CourseName
FROM Course c LEFT JOIN ELearningVDO e ON c.CourseID = e.CourseID
WHERE e.CourseID IS NULL;