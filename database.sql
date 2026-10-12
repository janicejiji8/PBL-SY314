-- CareSync Master MySQL Database Schema (Sprint 2 Complete)
CREATE DATABASE caresync;
USE caresync;

-- ==========================================
-- 1. CORE USER PROFILES
-- ==========================================
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    blood_group VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    experience_years INT,
    consultation_fee DECIMAL(10,2),
    availability_status BOOLEAN DEFAULT TRUE
);

-- ==========================================
-- 2. SMART SCHEDULING & APPOINTMENTS
-- ==========================================
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_datetime DATETIME NOT NULL,
    symptoms_description TEXT,
    ai_priority_score DECIMAL(3,2),     -- Sprint 3 AI Integration
    ai_predicted_wait_time INT,         -- In minutes
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- ==========================================
-- 3. DIGITAL HEALTH RECORDS MODULE
-- ==========================================
CREATE TABLE HealthRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    prescription_details TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- ==========================================
-- 4. EMERGENCY & AMBULANCE MODULE
-- ==========================================
CREATE TABLE AmbulanceRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    pickup_latitude DECIMAL(10, 8),     -- For GPS Tracking
    pickup_longitude DECIMAL(10, 8),
    dispatch_status VARCHAR(50) DEFAULT 'Searching for Ambulance',
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- ==========================================
-- 5. PHARMACY MODULE
-- ==========================================
CREATE TABLE PharmacyOrders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    prescription_image_url VARCHAR(255),
    delivery_address TEXT,
    order_status VARCHAR(50) DEFAULT 'Pending Verification',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- ==========================================
-- 6. PAYMENT GATEWAY INTEGRATION
-- ==========================================
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_type VARCHAR(50),           -- 'Consultation' or 'Pharmacy'
    transaction_status VARCHAR(20) DEFAULT 'Success',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
