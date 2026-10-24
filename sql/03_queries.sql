USE day8_facility_management;

-- 1. Basic SELECT / WHERE / ORDER BY
SELECT id, name, location, cleanliness_score
FROM facilities
WHERE status = 'active'
ORDER BY cleanliness_score ASC;

-- 2. Employees with department names (JOIN)
SELECT e.employee_code, u.name AS employee_name, e.job_title,
       d.name AS department, e.salary
FROM employees e
LEFT JOIN users u ON u.id = e.user_id
INNER JOIN departments d ON d.id = e.department_id
ORDER BY d.name, e.salary DESC;

-- 3. Average salary by department (GROUP BY)
SELECT d.name AS department, ROUND(AVG(e.salary), 2) AS average_salary,
       COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id
GROUP BY d.id, d.name
ORDER BY average_salary DESC;

-- 4. Departments with average salary greater than 50000 (HAVING)
SELECT d.name, ROUND(AVG(e.salary), 2) AS average_salary
FROM departments d
JOIN employees e ON e.department_id = d.id
GROUP BY d.id, d.name
HAVING AVG(e.salary) > 50000
ORDER BY average_salary DESC;

-- 5. Highest-paid employee (supports ties)
SELECT e.employee_code, u.name, e.job_title, d.name AS department, e.salary
FROM employees e
LEFT JOIN users u ON u.id = e.user_id
JOIN departments d ON d.id = e.department_id
WHERE e.salary = (SELECT MAX(salary) FROM employees);

-- 6. Facilities with poor cleanliness (below 5/10)
SELECT id, name, location, cleanliness_score
FROM facilities
WHERE cleanliness_score < 5
ORDER BY cleanliness_score ASC;

-- 7. Complaint count by facility, including facilities with zero complaints
SELECT f.id, f.name,
       COUNT(c.id) AS total_complaints,
       SUM(CASE WHEN c.status = 'open' THEN 1 ELSE 0 END) AS open_complaints
FROM facilities f
LEFT JOIN complaints c ON c.facility_id = f.id
GROUP BY f.id, f.name
ORDER BY total_complaints DESC, f.name;

-- 8. Inspection history for each facility
SELECT f.name AS facility, i.inspection_date, u.name AS inspector,
       i.cleanliness_score, i.odor_score, i.waste_level, i.notes
FROM inspections i
JOIN facilities f ON f.id = i.facility_id
JOIN employees e ON e.id = i.inspector_id
LEFT JOIN users u ON u.id = e.user_id
ORDER BY f.name, i.inspection_date DESC;

-- 9. Facilities that have at least one critical inspection (EXISTS subquery)
SELECT f.id, f.name, f.location
FROM facilities f
WHERE EXISTS (
    SELECT 1 FROM inspections i
    WHERE i.facility_id = f.id AND i.waste_level = 'critical'
);

-- 10. Latest inspection per facility (correlated subquery)
SELECT f.name, i.inspection_date, i.cleanliness_score, i.waste_level
FROM facilities f
JOIN inspections i ON i.facility_id = f.id
WHERE i.inspection_date = (
    SELECT MAX(i2.inspection_date)
    FROM inspections i2
    WHERE i2.facility_id = f.id
)
ORDER BY f.name;

-- 11. Complaints grouped by status
SELECT status, COUNT(*) AS complaint_count
FROM complaints
GROUP BY status
ORDER BY complaint_count DESC;

-- 12. Employee CRUD examples (use carefully)
-- INSERT INTO employees (department_id, employee_code, job_title, salary, hire_date)
-- VALUES (1, 'EMP-1005', 'Junior Inspector', 39000, '2026-10-01');
-- UPDATE employees SET salary = 41000 WHERE employee_code = 'EMP-1005';
-- DELETE FROM employees WHERE employee_code = 'EMP-1005';
