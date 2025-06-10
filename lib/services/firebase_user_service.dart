import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wormsup_dev/models/notifikasi.dart';
import 'package:wormsup_dev/models/riwayatPenyiraman.dart';

class UserService {
  final CollectionReference _riwayatPenyiramanRef = FirebaseFirestore.instance
      .collection('riwayat_penyiraman');
  final CollectionReference _notifikasiRef = FirebaseFirestore.instance
      .collection('notifikasi');
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection(
    'users',
  );

  Stream<List<RiwayatPenyiramanModel>> streamRiwayatPenyiraman() {
    return _riwayatPenyiramanRef
        .orderBy('waktu', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => RiwayatPenyiramanModel.fromFirestore(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  Stream<List<NotifikasiModel>> streamNotifikasi() {
    return _notifikasiRef
        .orderBy('waktu', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => NotifikasiModel.fromFirestore(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  Future<void> deleteNotifikasi(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifikasi')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> deleteAllNotifikasi() async {
    try {
      await _notifikasiRef.get().then((snapshot) async {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> deleteRiwayatPenyiraman(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('riwayat_penyiraman')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Stream<DocumentSnapshot> streamUser(String uid) {
    return _usersRef.doc(uid).snapshots();
  }
}
