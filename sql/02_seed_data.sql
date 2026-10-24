USE day8_facility_management;

INSERT INTO users (name,email,password,role) VALUES
('Aarav Sharma','aarav@example.test','$2y$10$examplehashnotusable','inspector'),
('Meera Patil','meera@example.test','$2y$10$examplehashnotusable','inspector'),
('Rohan Deshmukh','rohan@example.test','$2y$10$examplehashnotusable','resident'),
('Sana Khan','sana@example.test','$2y$10$examplehashnotusable','resident'),
('Admin User','admin@example.test','$2y$10$examplehashnotusable','admin');

INSERT INTO departments (name,location) VALUES
('Facilities Operations','North Zone'),
('Public Health','Central Zone'),
('Maintenance','West Zone');

INSERT INTO employees (user_id,department_id,employee_code,job_title,salary,hire_date) VALUES
(1,1,'EMP-1001','Facility Inspector',52000.00,'2023-04-10'),
(2,2,'EMP-1002','Senior Inspector',68500.00,'2021-08-16'),
(5,3,'EMP-1003','Maintenance Manager',82000.00,'2020-02-01'),
(NULL,1,'EMP-1004','Operations Assistant',43000.00,'2024-01-15');

INSERT INTO facilities (name,location,cleanliness_score,status) VALUES
('Central Library','Central Zone',8.40,'active'),
('North Community Hall','North Zone',4.20,'active'),
('West Public Restroom','West Zone',2.80,'maintenance'),
('Riverside Park','East Zone',6.70,'active'),
('City Bus Terminal','Central Zone',3.50,'active');

INSERT INTO inspections (facility_id,inspector_id,inspection_date,cleanliness_score,odor_score,waste_level,notes) VALUES
(1,1,'2026-10-01',8.50,1,'low','Good overall condition.'),
(1,2,'2026-10-15',8.20,2,'low','Minor litter near the entrance.'),
(2,1,'2026-10-04',4.10,3,'high','Several bins require servicing.'),
(2,2,'2026-10-18',3.90,4,'critical','Follow-up maintenance required.'),
(3,1,'2026-10-05',2.70,5,'critical','Urgent sanitation work needed.'),
(4,2,'2026-10-12',6.80,2,'medium','Acceptable, improve bin collection.'),
(5,1,'2026-10-20',3.60,4,'high','High footfall; cleaning frequency insufficient.');

INSERT INTO complaints (facility_id,user_id,title,description,priority,status) VALUES
(2,3,'Overflowing bins','Bins near the main entrance are overflowing.','high','open'),
(3,4,'Strong odor','Persistent odor around the public restroom.','critical','in_progress'),
(5,3,'Unclean waiting area','Waiting benches and floor need cleaning.','medium','open'),
(1,4,'Damaged waste bin','One bin lid is broken.','low','resolved'),
(2,4,'Missed cleaning','Scheduled cleaning appears to have been missed.','high','open');
