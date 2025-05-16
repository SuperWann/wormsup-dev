import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wormsup_dev/models/riwayatPenyiraman.dart';

class RiwayatPenyiramanService {
  final CollectionReference _riwayatPenyiramanRef = FirebaseFirestore.instance
      .collection('riwayat_penyiraman');


  //FUNCTION YANG TIDAK REALTIME

  // Future<List<RiwayatPenyiraman>> getRiwayatPenyiraman() async {
  //   final snapshot =
  //       await _riwayatPenyiramanRef.orderBy('waktu', descending: true).get();
  //   return snapshot.docs
  //       .map(
  //         (doc) => RiwayatPenyiraman.fromFirestore(
  //           doc.id,
  //           doc.data() as Map<String, dynamic>,
  //         ),
  //       )
  //       .toList();
  // }

  Stream<List<RiwayatPenyiraman>> streamRiwayatPenyiraman() {
  return _riwayatPenyiramanRef
      .orderBy('waktu', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
            (doc) => RiwayatPenyiraman.fromFirestore(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          ).toList());
}

}
