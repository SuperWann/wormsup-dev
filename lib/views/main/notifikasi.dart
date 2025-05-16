import 'package:flutter/material.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final List<Map<String, dynamic>> logs = [
    {
      'pesan':
          'Kelembapan tanah berada dibawah 15%. Segera hidupkan mesin penyiraman otomatis!',
      'waktu': 'Sekarang',
    },
    {
      'pesan': 'pH tanah dalam kondisi yang stabil yaitu 6.50',
      'waktu': '30 menit yang lalu',
    },
    {
      'pesan': 'Kelembapan tanah sudah mencapai titik stabil yaitu 25%',
      'waktu': '1 jam yang lalu',
    },
    {
      'pesan':
          'Mesin penyiram otomatis sedang menyiram tanah yang kurang lembap.',
      'waktu': '2 jam yang lalu',
    },
    {
      'pesan': 'Kelembapan tanah berada dibawah 15%',
      'waktu': '4 jam yang lalu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black12),
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
