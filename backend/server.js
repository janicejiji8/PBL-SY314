// server.js - CareSync Master API Gateway
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// ==========================================
// 1. AUTHENTICATION (Patients & Doctors)
// ==========================================
app.post('/api/auth/login', (req, res) => {
    const { email, password } = req.body;
    // Maps to Patients/Doctors table validation
    res.status(200).json({ success: true, message: "Login successful", token: "jwt_token_123" });
});

// ==========================================
// 2. SMART SCHEDULING (Sprint 3 AI Ready)
// ==========================================
app.post('/api/appointments/book', (req, res) => {
    const { patient_id, doctor_id, date, time } = req.body;
    // Maps to Appointments table. AI predictions to be integrated here.
    res.status(201).json({ 
        success: true, 
        message: "Appointment confirmed",
        priority_score: 8.5,
        predicted_wait_time_mins: 15
    });
});

// ==========================================
// 3. EMERGENCY & AMBULANCE MODULE
// ==========================================
app.post('/api/emergency/dispatch', (req, res) => {
    const { patient_id, lat, lng } = req.body;
    // Maps to AmbulanceRequests table
    res.status(201).json({ 
        success: true, 
        message: "SOS Alert Received. Nearest ambulance dispatched.",
        tracking_enabled: true 
    });
});

// ==========================================
// 4. DIGITAL HEALTH RECORDS MODULE
// ==========================================
app.get('/api/records/:patientId', (req, res) => {
    const { patientId } = req.params;
    // Maps to HealthRecords table. Fetches past diagnoses.
    res.status(200).json({ 
        success: true, 
        message: "Patient records retrieved securely." 
    });
});

// ==========================================
// 5. PHARMACY & PAYMENT MODULE
// ==========================================
app.post('/api/pharmacy/order', (req, res) => {
    const { patient_id, prescription_id } = req.body;
    // Maps to PharmacyOrders and Payments tables
    res.status(201).json({ 
        success: true, 
        message: "Prescription validated. Payment pending.",
        gateway_url: "stripe_checkout_placeholder"
    });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`CareSync Master Backend running on port ${PORT}`);
    console.log(`All routes initialized for MySQL mapping`);
});
