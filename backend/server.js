// server.js - CareSync API Gateway
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// FR-1.1: Patient Authentication Endpoint
app.post('/api/auth/login', (req, res) => {
    const { email, password } = req.body;
    res.status(200).json({ 
        success: true, 
        message: "Login successful", 
        token: "jwt_token_placeholder" 
    });
});

// FR-1.2 & FR-1.3: Doctor Search and Appointment Booking
app.post('/api/appointments/book', (req, res) => {
    const { patient_id, doctor_id, date, time } = req.body;
    
    // AI Priority Score placeholder (Sprint 3 integration)
    res.status(201).json({ 
        success: true, 
        message: "Appointment confirmed via CareSync Engine",
        priority_score: 8.5,
        queue_status: "Wait time approx 15 mins"
    });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`CareSync Backend running on port ${PORT}`);
});
