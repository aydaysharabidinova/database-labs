-- Database Schema for Counseling Service Application

-- Drop existing tables if they exist
DROP TABLE IF EXISTS "Sessions" CASCADE;
DROP TABLE IF EXISTS "Appointments" CASCADE;
DROP TABLE IF EXISTS "Counselors" CASCADE;
DROP TABLE IF EXISTS "Patients" CASCADE;

-- Create Patients table
CREATE TABLE "Patients" (
    "PatientID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "Age" INTEGER CHECK ("Age" > 0 AND "Age" < 150),
    "Email" VARCHAR(255) UNIQUE NOT NULL,
    "Phone" VARCHAR(255),
    "RegistrationDate" DATE DEFAULT CURRENT_DATE,
    "MedicalHistory" TEXT
);

-- Create Counselors table
CREATE TABLE "Counselors" (
    "CounselorID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "Specialization" VARCHAR(255),
    "Email" VARCHAR(255) UNIQUE NOT NULL,
    "Phone" VARCHAR(255),
    "Availability" VARCHAR(255),
    "YearsOfExperience" INTEGER DEFAULT 0
);

-- Create Appointments table
CREATE TABLE "Appointments" (
    "AppointmentID" SERIAL PRIMARY KEY,
    "PatientID" INTEGER NOT NULL,
    "CounselorID" INTEGER NOT NULL,
    "AppointmentDate" DATE NOT NULL,
    "AppointmentTime" TIME NOT NULL,
    "Status" VARCHAR(50) DEFAULT 'Scheduled' 
        CHECK ("Status" IN ('Scheduled', 'Completed', 'Cancelled')),
    "CreatedAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("PatientID") REFERENCES "Patients"("PatientID") ON DELETE CASCADE,
    FOREIGN KEY ("CounselorID") REFERENCES "Counselors"("CounselorID") ON DELETE CASCADE
);

-- Create Sessions table
CREATE TABLE "Sessions" (
    "SessionID" SERIAL PRIMARY KEY,
    "AppointmentID" INTEGER NOT NULL,
    "Duration" INTEGER CHECK ("Duration" > 0 AND "Duration" <= 300),
    "Notes" TEXT,
    "Feedback" TEXT,
    "SessionDate" DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY ("AppointmentID") REFERENCES "Appointments"("AppointmentID") ON DELETE CASCADE
);

-- Create Indexes for Performance
CREATE INDEX "idx_patient_email" ON "Patients"("Email");
CREATE INDEX "idx_patient_registration_date" ON "Patients"("RegistrationDate");
CREATE INDEX "idx_counselor_specialization" ON "Counselors"("Specialization");
CREATE INDEX "idx_counselor_email" ON "Counselors"("Email");
CREATE INDEX "idx_appointment_date" ON "Appointments"("AppointmentDate");
CREATE INDEX "idx_appointment_status" ON "Appointments"("Status");
CREATE INDEX "idx_patient_counselor" ON "Appointments"("PatientID", "CounselorID");
CREATE INDEX "idx_session_date" ON "Sessions"("SessionDate");

-- Comments for documentation
COMMENT ON TABLE "Patients" IS 'Stores patient information and medical history';
COMMENT ON TABLE "Counselors" IS 'Manages counselor profiles and specializations';
COMMENT ON TABLE "Appointments" IS 'Tracks scheduled appointments between patients and counselors';
COMMENT ON TABLE "Sessions" IS 'Records completed therapy sessions with notes and feedback';
