import 'package:cloud_firestore/cloud_firestore.dart';

class RiwayatPenyiramanModel {
  final String docId;
  final int kelembapan;
  final DateTime waktu;

  RiwayatPenyiramanModel({required this.docId, required this.kelembapan, required this.waktu});

  factory RiwayatPenyiramanModel.fromFirestore(String id, Map<String, dynamic> data) {
    return RiwayatPenyiramanModel(
      docId: id,
      kelembapan: data['kelembapan'] ?? 0,
      waktu: (data['waktu'] as Timestamp).toDate(),
    );
  }
}
