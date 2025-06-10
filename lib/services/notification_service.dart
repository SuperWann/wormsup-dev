// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final localNotificationPlugin = FlutterLocalNotificationsPlugin();

//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   // Inisialisasi local notification
//   Future<void> initNotification() async {
//     if (_isInitialized) return;

//     const initSettingsAndroid = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );

//     const initSettings = InitializationSettings(android: initSettingsAndroid);

//     await localNotificationPlugin.initialize(initSettings);
//   }

//   //Notification detail
//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         channelDescription: 'channel_description',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//   }

//   static const int cooldownMinutes = 30; // Cooldown 30 menit

//   // Menyimpan waktu terakhir notifikasi dikirim
//   DateTime? _lastHumidityNotification;
//   DateTime? _lastPhLowNotification;
//   DateTime? _lastPhHighNotification;

//   // Status kondisi sebelumnya untuk deteksi perubahan
//   bool _lastHumidityStatus = false; // false = normal, true = bermasalah
//   bool _lastPhLowStatus = false;
//   bool _lastPhHighStatus = false;

//   void checkAndSendNotification(double humidity, double ph) {
//     DateTime now = DateTime.now();

//     // Cek kelembaban
//     _checkHumidityNotification(humidity, now);

//     // Cek pH
//     _checkPhNotification(ph, now);
//   }

//   void _checkHumidityNotification(double humidity, DateTime now) {
//     bool currentHumidityProblem = humidity > 70.0;

//     // Kirim notifikasi jika:
//     // 1. Ada perubahan dari normal ke bermasalah
//     // 2. Atau sudah melewati cooldown period dan masih bermasalah
//     if (currentHumidityProblem &&
//         (!_lastHumidityStatus ||
//             _isCooldownExpired(_lastHumidityNotification, now))) {
//       _sendHumidityNotification(humidity);
//       _lastHumidityNotification = now;
//     }

//     _lastHumidityStatus = currentHumidityProblem;
//   }

//   void _checkPhNotification(double ph, DateTime now) {
//     bool currentPhLowProblem = ph < 6.0;
//     bool currentPhHighProblem = ph > 7.5;

//     // Cek pH rendah
//     if (currentPhLowProblem &&
//         (!_lastPhLowStatus ||
//             _isCooldownExpired(_lastPhLowNotification, now))) {
//       _sendPhLowNotification(ph);
//       _lastPhLowNotification = now;
//     }

//     // Cek pH tinggi
//     if (currentPhHighProblem &&
//         (!_lastPhHighStatus ||
//             _isCooldownExpired(_lastPhHighNotification, now))) {
//       _sendPhHighNotification(ph);
//       _lastPhHighNotification = now;
//     }

//     _lastPhLowStatus = currentPhLowProblem;
//     _lastPhHighStatus = currentPhHighProblem;
//   }

//   bool _isCooldownExpired(DateTime? lastNotification, DateTime now) {
//     if (lastNotification == null) return true;

//     return now.difference(lastNotification).inMinutes >= cooldownMinutes;
//   }

//   void _sendHumidityNotification(double humidity) {
//     // Implementasi pengiriman notifikasi kelembaban
//     _showLocalNotification(
//       title: "⚠️ Kelembaban Tinggi",
//       body: "Kelembaban tanah ${humidity.toStringAsFixed(1)}% (Normal: <70%)",
//       payload: "humidity_high",
//     );
//   }

//   void _sendPhLowNotification(double ph) {
//     _showLocalNotification(
//       title: "⚠️ pH Tanah Rendah",
//       body: "pH tanah ${ph.toStringAsFixed(1)} (Normal: 6.0-7.5)",
//       payload: "ph_low",
//     );
//   }

//   void _sendPhHighNotification(double ph) {
//     _showLocalNotification(
//       title: "⚠️ pH Tanah Tinggi",
//       body: "pH tanah ${ph.toStringAsFixed(1)} (Normal: 6.0-7.5)",
//       payload: "ph_high",
//     );
//   }

//   Future<void> _showLocalNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     return localNotificationPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails(),
//     );
//   }
// }
