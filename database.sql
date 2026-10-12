-- CareSync Phygital Queue & Infrastructure Engine
CREATE DATABASE caresync;
USE caresync;

-- CORE PROFILES
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    availability_status BOOLEAN DEFAULT TRUE
);

-- THE UNIFIED "PHYGITAL" QUEUE & DESK CHECK-IN ENGINE
CREATE TABLE QueueAppointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    booking_type ENUM('Online', 'Walk-In') DEFAULT 'Online',
    symptoms_mapped TEXT,               -- Payload from 2D Symptom Mapper
    appointment_datetime DATETIME NOT NULL,
    ai_priority_score DECIMAL(3,2),     
    predicted_wait_time_mins INT,       -- Scikit-learn microservice update target
    check_in_status ENUM('Pending', 'Checked-In', 'Consulting', 'Completed') DEFAULT 'Pending',
    swap_requested_with_id INT NULL,    -- Peer-to-Peer Queue Slot Swapping
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (swap_requested_with_id) REFERENCES QueueAppointments(appointment_id)
);

-- COMPANION LIVE TRACKER LINKS
CREATE TABLE CompanionTrackers (
    tracker_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    secure_hash VARCHAR(255) UNIQUE NOT NULL, -- Zero-authentication URL hash
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES QueueAppointments(appointment_id)
);

-- PRE-ARRIVAL EMERGENCY OVERRIDES
CREATE TABLE EmergencyOverrides (
    override_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    eta_minutes INT,
    medical_profile_summary TEXT,
    queue_paused BOOLEAN DEFAULT TRUE,  -- Triggers 'Clinical Queue Pause' alerts
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- DIGITAL HEALTH RECORDS & SECURE SHARING
CREATE TABLE HealthRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    prescription_pdf_url VARCHAR(255),  -- Digital Prescription Generation
    secure_share_link VARCHAR(255),     -- Self-destructing link
    link_expiry_datetime DATETIME,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
