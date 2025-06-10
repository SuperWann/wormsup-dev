import 'package:flutter/material.dart';
import 'package:wormsup_dev/models/notifikasi.dart';
import 'package:wormsup_dev/services/firebase_user_service.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final UserService _userService = UserService();
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
          child: StreamBuilder<List<NotifikasiModel>>(
            stream: _userService.streamNotifikasi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Belum ada riwayat penyiraman.'));
              }

              final dataRiwayat = snapshot.data!;

              return ListView.builder(
                itemCount: dataRiwayat.length,
                itemBuilder: (context, index) {
                  final log = dataRiwayat[index];
                  return Dismissible(
                    key: Key(log.docId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onDismissed: (direction) {
                      _userService.deleteRiwayatPenyiraman(log.docId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Notifikasi berhasil dihapus')),
                      );
                    },
                    child: Card(
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
                              log.deskripsi,
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
                                log.waktu
                                    .toString(), // Format tanggal bisa ditambahkan
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
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
