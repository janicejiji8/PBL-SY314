// server.js - CareSync API Gateway
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// ==========================================
// PATIENT WEB PORTAL ROUTES
// ==========================================

// Interactive 2D Symptom Mapper & Booking
app.post('/api/appointments/book', (req, res) => {
    const { patient_id, symptoms_mapped_data } = req.body;
    res.status(201).json({ 
        success: true, 
        message: "Routed to appropriate specialist queue",
        ai_priority_score: 8.2,
        when_to_leave_alert: "Leave in 12 mins (Google Maps Traffic adjusted)"
    });
});

// Peer-to-Peer Queue Slot Swapping
app.post('/api/queue/swap-request', (req, res) => {
    const { current_appointment_id, target_appointment_id } = req.body;
    res.status(200).json({ 
        success: true, 
        message: "Web-push alert sent to next patient for swap approval." 
    });
});

// Companion Live Tracker Link Generation
app.get('/api/queue/companion-link/:appointmentId', (req, res) => {
    res.status(200).json({ 
        success: true, 
        shareable_url: "https://caresync.app/track/a8f93j2",
        check_in_status: "Consulting" // State Tracker Engine
    });
});

// Digital Health Records Self-Destructing Link
app.post('/api/records/secure-share', (req, res) => {
    res.status(201).json({ 
        success: true, 
        message: "Time-limited link generated for external second opinion",
        expiry: "24_hours"
    });
});

// ==========================================
// HOSPITAL & DOCTOR DASHBOARD ROUTES
// ==========================================

// Pre-Arrival Emergency Override (Queue Pause)
app.post('/api/admin/emergency-override', (req, res) => {
    const { patient_id, eta_minutes } = req.body;
    res.status(201).json({ 
        success: true, 
        message: "ER Dashboard Alerted. Clinical Queue Paused. Delay alerts pushed to routine OPD." 
    });
});

// Unified Dashboard Sync (Phygital Queue, Kiosk, & Re-routing)
app.get('/api/admin/dashboard-sync', (req, res) => {
    res.status(200).json({ 
        phygital_queue: [], // Merges SQL 'Online' and 'Walk-In' ENUMs
        assisted_workflow_reroute: "Dr. Sharma delayed by 45 mins. Click to re-route 3 patients.",
        smart_tv_kiosk_data: "High-contrast token list formatted for waiting room screens"
    });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`CareSync Microservices running on port ${PORT}`);
});
