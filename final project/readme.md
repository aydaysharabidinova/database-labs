# Mental Health Counseling Service - Database Management System

A comprehensive database management system for mental health counseling services, built with Flask and PostgreSQL. This project demonstrates advanced database concepts including complex queries, joins, aggregations, indexes, and constraints.

## 🎯 Project Overview

This system manages the complete workflow of a mental health counseling service, including:
- Patient registration and management
- Counselor profiles and availability
- Appointment scheduling and tracking
- Therapy session documentation
- Advanced analytics and reporting

## 📊 Database Schema

### Tables

1. **Patients** - Stores patient information
2. **Counselors** - Manages counselor profiles and specializations
3. **Appointments** - Tracks scheduled appointments
4. **Sessions** - Records completed therapy sessions


### Key Relationships
- One Patient can have many Appointments (1:N)
- One Counselor can have many Appointments (1:N)
- One Appointment can have one Session (1:1)

## 🔑 Database Features Implemented

### 1. **Constraints**
- **PRIMARY KEY**: Unique identifiers for all tables
- **FOREIGN KEY**: Referential integrity with CASCADE delete
- **UNIQUE**: Email uniqueness for patients and counselors
- **CHECK**: Data validation (age range, appointment status, session duration)
- **NOT NULL**: Required fields enforcement

### 2. **Indexes**
```sql
-- Performance optimization indexes
CREATE INDEX idx_patient_email ON Patients(Email);
CREATE INDEX idx_appointment_date ON Appointments(AppointmentDate);
CREATE INDEX idx_appointment_status ON Appointments(Status);
CREATE INDEX idx_patient_counselor ON Appointments(PatientID, CounselorID);
```

### 3. **Advanced SQL Queries**

#### GROUP BY with Aggregations
```sql
-- Counselor workload analysis
SELECT 
    C.Name,
    COUNT(A.AppointmentID) as TotalAppointments,
    COUNT(CASE WHEN A.Status = 'Completed' THEN 1 END) as Completed
FROM Counselors C
LEFT JOIN Appointments A ON C.CounselorID = A.CounselorID
GROUP BY C.CounselorID;
```

#### Multiple JOINs
```sql
-- Session details with patient and counselor info
SELECT 
    S.SessionID,
    P.Name as PatientName,
    C.Name as CounselorName,
    S.Duration,
    S.SessionDate
FROM Sessions S
JOIN Appointments A ON S.AppointmentID = A.AppointmentID
JOIN Patients P ON A.PatientID = P.PatientID
JOIN Counselors C ON A.CounselorID = C.CounselorID;
```

#### Date Functions and Extraction
```sql
-- Monthly appointment trends
SELECT 
    EXTRACT(YEAR FROM AppointmentDate) as Year,
    EXTRACT(MONTH FROM AppointmentDate) as Month,
    COUNT(*) as AppointmentCount
FROM Appointments
GROUP BY Year, Month
ORDER BY Year, Month;
```

#### HAVING Clause
```sql
-- Active patients (more than 2 appointments)
SELECT 
    P.Name,
    COUNT(A.AppointmentID) as AppointmentCount
FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
GROUP BY P.PatientID
HAVING COUNT(A.AppointmentID) > 2;
```

#### Subqueries
```sql
-- Counselors with above-average appointments
SELECT Name, 
    (SELECT COUNT(*) FROM Appointments WHERE CounselorID = C.CounselorID) as AppointmentCount
FROM Counselors C
WHERE (SELECT COUNT(*) FROM Appointments WHERE CounselorID = C.CounselorID) > 
    (SELECT AVG(cnt) FROM (SELECT COUNT(*) as cnt FROM Appointments GROUP BY CounselorID) sub);
```

## 🚀 Features

### Core Functionality
- ✅ **Patient Management**: Register, view, and track patient information
- ✅ **Counselor Management**: Add counselors with specializations
- ✅ **Appointment Scheduling**: Book and manage appointments
- ✅ **Session Recording**: Document therapy sessions with notes and feedback
- ✅ **Status Tracking**: Monitor appointment status (Scheduled/Completed/Cancelled)

### Advanced Features
- 📊 **Reports & Analytics**
  - Counselor workload analysis
  - Monthly appointment trends
  - Patient activity tracking
  - Specialization demand analysis
  - Peak appointment time analysis
  
- 💻 **SQL Query Tool**: Execute custom SELECT queries for testing
- 🔍 **Search & Filter**: Search patients, filter appointments by status
- 📈 **Data Visualization**: Visual representation of statistics

## 🛠️ Technology Stack

- **Backend**: Python 3.12, Flask 3.0
- **Database**: PostgreSQL 16
- **ORM**: SQLAlchemy 2.0
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Design**: Custom gradient-based responsive UI

## 📦 Installation

### Prerequisites
- Python 3.8+
- PostgreSQL 12+
- pip package manager

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/aydaysharabidinova/database-labs.git
cd mental_health_db
```

2. **Install dependencies**
```bash
pip install -r requirements.txt
```

3. **Create database schema**
```bash
psql -U postgres -d mental_health_db -f database/schema.sql
```

4. **Load sample data (optional)**
```bash
psql -U postgres -d mental_health_db -f database/sample_data.sql
```

5. **Run the application**
```bash
python app.py
```

6. **Access the application**
Open your browser and navigate to: `http://127.0.0.1:5000`


## 📚 Database Concepts Demonstrated

| Concept | Implementation |
|---------|---------------|
| **DDL** | CREATE TABLE, ALTER TABLE, CREATE INDEX |
| **DML** | INSERT, UPDATE, DELETE, SELECT |
| **Constraints** | PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, NOT NULL |
| **Relationships** | 1:1, 1:N with CASCADE operations |
| **Joins** | INNER JOIN, LEFT JOIN, multiple table joins |
| **Aggregations** | COUNT, AVG, MAX, MIN, SUM |
| **Grouping** | GROUP BY, HAVING |
| **Functions** | Date functions (EXTRACT), String functions |
| **Subqueries** | Nested SELECT statements |
| **Indexes** | B-tree indexes for query optimization |
| **Transactions** | ACID properties through SQLAlchemy |

## 🔐 Security Features

- Input validation on all forms
- SQL injection prevention through ORM
- Email uniqueness enforcement
- Age and duration validation through CHECK constraints
- Safe query execution (SELECT only) in SQL tool

## 📈 Performance Optimizations

- Indexed foreign keys for faster joins
- Composite indexes on frequently queried columns
- Lazy loading for relationships
- Query result limiting for large datasets

## 🎓 Learning Outcomes

This project demonstrates understanding of:
1. Relational database design and normalization
2. Complex SQL query construction
3. Database constraints and integrity
4. Performance optimization with indexes
5. ORM usage and query building
6. Full-stack web application development
7. User interface design principles

## 🤝 Contributing

This is an academic project for Database Course. Feedback and suggestions are welcome!


## 📄 License

This project is created for educational purposes.

**Note**: This project was developed as part of the Database Management Systems course final project.

