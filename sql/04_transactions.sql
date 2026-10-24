USE day8_facility_management;

-- Example transaction: adjust salary and inspect the changed row.
-- Run the whole block in a single database session.
START TRANSACTION;
UPDATE employees
SET salary = salary + 1000
WHERE employee_code = 'EMP-1001';

SELECT employee_code, salary
FROM employees
WHERE employee_code = 'EMP-1001';

-- Choose ONE:
COMMIT;
-- Or, instead of COMMIT, use ROLLBACK; to discard the update.

-- Demonstration of rollback without changing persistent data:
START TRANSACTION;
UPDATE facilities SET cleanliness_score = 0 WHERE id = 1;
SELECT id, name, cleanliness_score FROM facilities WHERE id = 1;
ROLLBACK;
SELECT id, name, cleanliness_score FROM facilities WHERE id = 1;
