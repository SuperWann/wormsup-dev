import 'package:cloud_firestore/cloud_firestore.dart';

class NotifikasiModel{
  final String docId;
  final String deskripsi;
  final DateTime waktu;

  NotifikasiModel({required this.docId, required this.deskripsi, required this.waktu});

  factory NotifikasiModel.fromFirestore(String id, Map<String, dynamic> data) {
    return NotifikasiModel(
      docId: id,
      deskripsi: data['deskripsi'] ?? 0,
      waktu: (data['waktu'] as Timestamp).toDate(),
    );
  }
}