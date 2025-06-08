import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wormsup_dev/models/riwayatPenyiraman.dart';

class UserService {
  final CollectionReference _riwayatPenyiramanRef = FirebaseFirestore.instance
      .collection('riwayat_penyiraman');
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection(
    'users',
  );

  Stream<List<RiwayatPenyiraman>> streamRiwayatPenyiraman() {
    return _riwayatPenyiramanRef
        .orderBy('waktu', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => RiwayatPenyiraman.fromFirestore(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
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
