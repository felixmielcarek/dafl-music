import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print('A new onMessage event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken(
        vapidKey:
            "BOxfduRivQnT8TS1h9WRGEk4gV2IOzJpTCcoKxVTMgVWjxi6TUcQBng2mqM7fUfNy51esFrRGE68coa0XZaKdHc");
  }
}
