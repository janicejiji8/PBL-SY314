import 'package:flutter/material.dart';

void main() {
  runApp(const CareSyncWebPortal());
}

class CareSyncWebPortal extends StatelessWidget {
  const CareSyncWebPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareSync Patient Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)), 
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('CareSync Portal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_active, color: Colors.red), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ER Notified. Sending ETA & Pausing Clinic Queue.'), 
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        },
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.warning, color: Colors.white),
        label: const Text('SOS Emergency Override', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade400),
              ),
              child: const Row(
                children: [
                  Icon(Icons.traffic, color: Colors.deepOrange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('When-to-Leave Predictive Alert', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Traffic is heavy. Leave in 12 mins to arrive precisely for your dynamic queue slot.', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Patient Portal Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildPortalCard(Icons.accessibility_new, '2D Symptom\nMapper', Colors.blue),
                _buildPortalCard(Icons.swap_horiz, 'Peer-to-Peer\nSlot Swap', Colors.purple),
                _buildPortalCard(Icons.share_location, 'Companion\nLive Tracker', Colors.green),
                _buildPortalCard(Icons.lock_clock, 'Share Health\nRecords', Colors.teal),
              ],
            ),
            
            const SizedBox(height: 24),
            const Text('Desk Check-In Status Engine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dr. Anjali Deshmukh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Chip(label: const Text('State: Pending', style: TextStyle(color: Colors.blue)), backgroundColor: Colors.blue.shade50, side: BorderSide.none),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AI Priority Score:', style: TextStyle(color: Colors.grey)),
                        Text('8.5 (High)', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dynamic Wait Time:', style: TextStyle(color: Colors.grey)),
                        Text('14 Mins', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80), 
          ],
        ),
      ),
    );
  }

  Widget _buildPortalCard(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 4, spreadRadius: 1)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2)),
        ],
      ),
    );
  }
}
