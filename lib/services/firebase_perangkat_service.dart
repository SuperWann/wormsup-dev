import 'package:cloud_firestore/cloud_firestore.dart';

class PerangkatService {
  // FirebaseFirestore.instance
  //                                           .collection('perangkat')
  //                                           .doc('esp32_1')
  //                                           .snapshots()
  final CollectionReference _perangkatRef = FirebaseFirestore.instance
      .collection('status_perangkat');
  final CollectionReference _sensorRef = FirebaseFirestore.instance.collection('perangkat');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> streamStatusPerangkat() {
    return _perangkatRef.doc('status_perangkat').snapshots();
  }

  Stream<DocumentSnapshot> streamDataSensor(){
    return _sensorRef.doc('esp32_1').snapshots();
  }

  Future<void> updateStatusPerangkat(bool statusPerangkat) async {
    await _firestore
        .collection('status_perangkat')
        .doc('status_perangkat')
        .update({'status': !statusPerangkat});
  }
}
