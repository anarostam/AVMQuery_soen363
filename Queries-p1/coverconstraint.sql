--8)overlap constraints
SELECT p.ssn, p.first_name
FROM person p
JOIN Victim v ON p.SSN = v.ssn
JOIN emergency_respondent er ON p.SSN = er.ssn
--Covering constraints
SELECT p.SSN, p.first_name
FROM person p
WHERE p.SSN NOT IN (
SELECT ssn FROM Victim 
UNION
SELECT ssn FROM emergency_respondent
)
