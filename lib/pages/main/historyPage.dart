import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/main/notifikasi.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> logs = [
    {
      'pesan':
          'Kelembapan kurang dari 15%, penyiraman secara otomatis dijalankan!',
      'waktu': 'Hari ini',
    },
    {
      'pesan':
          'Kelembapan kurang dari 15%, penyiraman secara otomatis dijalankan!',
      'waktu': '22 April 2025',
    },
    {
      'pesan':
          'Kelembapan kurang dari 15%, penyiraman secara otomatis dijalankan!',
      'waktu': '20 April 2025',
    },
    {
      'pesan':
          'Kelembapan kurang dari 15%, penyiraman secara otomatis dijalankan!',
      'waktu': '18 April 2025',
    },
    {
      'pesan':
          'Kelembapan kurang dari 15%, penyiraman secara otomatis dijalankan!',
      'waktu': '16 April 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'History',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(Icons.notifications_none_outlined, size: 30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotifikasiPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black12, width: 0.5),
                ),
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log['pesan']!,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          log['waktu']!,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
