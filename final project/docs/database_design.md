# Database Design Documentation

## 1. Database Requirements Analysis

### Business Requirements
- Track patient information and medical history
- Manage counselor profiles and specializations
- Schedule and track appointments
- Record therapy session details
- Generate reports and analytics

### Functional Requirements
- CRUD operations for all entities
- Search and filter capabilities
- Appointment status management
- Session documentation
- Analytics and reporting

## 2. Entity-Relationship Model

### Entities

#### Patient
- **Attributes**: PatientID (PK), Name, Age, Email, Phone, RegistrationDate, MedicalHistory
- **Business Rules**: 
  - Email must be unique
  - Age must be between 1-149
  - Registration date defaults to current date

#### Counselor
- **Attributes**: CounselorID (PK), Name, Specialization, Email, Phone, Availability, YearsOfExperience
- **Business Rules**:
  - Email must be unique
  - Years of experience defaults to 0

#### Appointment
- **Attributes**: AppointmentID (PK), PatientID (FK), CounselorID (FK), AppointmentDate, AppointmentTime, Status, CreatedAt
- **Business Rules**:
  - Status must be Scheduled, Completed, or Cancelled
  - Created timestamp defaults to current time

#### Session
- **Attributes**: SessionID (PK), AppointmentID (FK), Duration, Notes, Feedback, SessionDate
- **Business Rules**:
  - Duration must be between 1-300 minutes
  - Session date defaults to current date

### Relationships

1. **Patient → Appointment** (1:N)
   - One patient can have multiple appointments
   - Cascade delete: When patient is deleted, all appointments are deleted

2. **Counselor → Appointment** (1:N)
   - One counselor can have multiple appointments
   - Cascade delete: When counselor is deleted, all appointments are deleted

3. **Appointment → Session** (1:1)
   - One appointment can have at most one session
   - Cascade delete: When appointment is deleted, session is deleted

## 3. Normalization

### First Normal Form (1NF)
✅ All tables have atomic values
✅ No repeating groups
✅ All columns contain single values

### Second Normal Form (2NF)
✅ All tables are in 1NF
✅ No partial dependencies
✅ All non-key attributes depend on entire primary key

### Third Normal Form (3NF)
✅ All tables are in 2NF
✅ No transitive dependencies
✅ All non-key attributes depend only on primary key

## 4. Indexing Strategy

### Primary Indexes
- Automatic B-tree indexes on all primary keys

### Secondary Indexes
```sql
-- Email lookup optimization
CREATE INDEX idx_patient_email ON Patients(Email);
CREATE INDEX idx_counselor_email ON Counselors(Email);

-- Date-based queries
CREATE INDEX idx_appointment_date ON Appointments(AppointmentDate);
CREATE INDEX idx_session_date ON Sessions(SessionDate);

-- Status filtering
CREATE INDEX idx_appointment_status ON Appointments(Status);

-- Join optimization
CREATE INDEX idx_patient_counselor ON Appointments(PatientID, CounselorID);

-- Specialization search
CREATE INDEX idx_counselor_specialization ON Counselors(Specialization);
```

## 5. Constraints

### Entity Integrity
- PRIMARY KEY constraints on all tables

### Referential Integrity
- FOREIGN KEY constraints with CASCADE delete

### Domain Integrity
- CHECK constraints for valid ranges
- NOT NULL constraints for required fields
- UNIQUE constraints for emails

### Business Rules
- Appointment status validation
- Age range validation
- Session duration limits

## 6. Query Optimization Techniques

1. **Use of Indexes**: All frequently queried columns are indexed
2. **Join Optimization**: Composite indexes on foreign key pairs
3. **Query Limiting**: LIMIT clauses for large result sets
4. **Lazy Loading**: Relationships loaded only when needed
5. **Query Planning**: Analyzed with EXPLAIN ANALYZE

## 7. Security Measures

- SQL injection prevention through ORM
- Input validation on application layer
- Safe query execution limits
- Parameterized queries only
