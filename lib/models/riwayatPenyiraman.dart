import 'package:cloud_firestore/cloud_firestore.dart';

class RiwayatPenyiraman {
  final String docId;
  final int kelembapan;
  final DateTime waktu;

  RiwayatPenyiraman({required this.docId, required this.kelembapan, required this.waktu});

  factory RiwayatPenyiraman.fromFirestore(String id, Map<String, dynamic> data) {
    return RiwayatPenyiraman(
      docId: id,
      kelembapan: data['kelembapan'] ?? 0,
      waktu: (data['waktu'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'kelembapan': kelembapan,
    'waktu': waktu,
  };
}
