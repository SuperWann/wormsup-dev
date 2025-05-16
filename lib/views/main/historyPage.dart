import 'package:flutter/material.dart';
import 'package:wormsup_dev/models/riwayatPenyiraman.dart';
import 'package:wormsup_dev/services/firebase_riwayatPenyiraman_service.dart';
import 'package:wormsup_dev/views/main/notifikasi.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final RiwayatPenyiramanService _service = RiwayatPenyiramanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 80,
        ),
        child: StreamBuilder<List<RiwayatPenyiraman>>(
          stream: _service.streamRiwayatPenyiraman(),
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
                          "Kelembapan tanah berada di ${log.kelembapan}%, penyiraman otomatis dilakukan!",
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
