import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDevices {
  final CollectionReference devices =
      FirebaseFirestore.instance.collection('devices');

  Future<void> addDevice(String device) {
    return devices.add({
      'device': device,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getDevices() {
    final getDevices =
        devices.orderBy('timestamp', descending: true).snapshots();
    return getDevices;
  }

  Future<void> updateDevice(String deviceID, String newDevice) {
    return devices.doc(deviceID).update({
      'device': newDevice,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteDevice(String deviceID) {
    return devices.doc(deviceID).delete();
  }
}
