-- Sample Data for Mental Health Counseling Database

-- Insert Sample Counselors
INSERT INTO "Counselors" ("Name", "Specialization", "Email", "Phone", "Availability", "YearsOfExperience") VALUES
('Dr. Sarah Johnson', 'Anxiety & Depression', 'sarah.j@clinic.com', '+996 555 123 456', 'Mon-Fri 9AM-6PM', 8),
('Dr. Michael Chen', 'PTSD & Trauma', 'michael.c@clinic.com', '+996 555 234 567', 'Tue-Sat 10AM-7PM', 12),
('Dr. Emily Rodriguez', 'Family Therapy', 'emily.r@clinic.com', '+996 555 345 678', 'Mon-Wed-Fri 8AM-4PM', 6),
('Dr. James Wilson', 'Cognitive Behavioral Therapy', 'james.w@clinic.com', '+996 555 456 789', 'Mon-Thu 9AM-5PM', 10);

-- Insert Sample Patients
INSERT INTO "Patients" ("Name", "Age", "Email", "Phone", "MedicalHistory") VALUES
('John Smith', 32, 'john.smith@email.com', '+996 777 111 222', 'History of anxiety, prescribed medication: Sertraline 50mg'),
('Maria Garcia', 28, 'maria.g@email.com', '+996 777 222 333', 'Depression treatment, no current medication'),
('David Lee', 45, 'david.lee@email.com', '+996 777 333 444', 'PTSD symptoms following accident, therapy ongoing'),
('Anna Petrova', 35, 'anna.p@email.com', '+996 777 444 555', 'Stress management, work-related anxiety'),
('Tom Anderson', 52, 'tom.a@email.com', '+996 777 555 666', 'Family counseling needed');

-- Insert Sample Appointments
INSERT INTO "Appointments" ("PatientID", "CounselorID", "AppointmentDate", "AppointmentTime", "Status") VALUES
(1, 1, '2024-12-15', '10:00:00', 'Scheduled'),
(2, 2, '2024-12-16', '14:00:00', 'Scheduled'),
(3, 3, '2024-12-17', '09:30:00', 'Scheduled'),
(1, 1, '2024-12-10', '10:00:00', 'Completed'),
(2, 1, '2024-12-11', '15:00:00', 'Completed'),
(4, 4, '2024-12-18', '11:00:00', 'Scheduled'),
(5, 3, '2024-12-19', '13:00:00', 'Scheduled');

-- Insert Sample Sessions
INSERT INTO "Sessions" ("AppointmentID", "Duration", "Notes", "Feedback", "SessionDate") VALUES
(4, 60, 'Patient showed good progress with anxiety management techniques. Discussed coping strategies for workplace stress. Homework assigned: daily breathing exercises.', 'Patient reported feeling more confident. Positive response to CBT techniques.', '2024-12-10'),
(5, 45, 'Initial assessment completed. Patient experiencing mild to moderate depression. Established treatment goals. Discussed medication options with psychiatrist.', 'Patient engaged well during session. Open to trying recommended strategies.', '2024-12-11');
