import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging _firebaseMessaging;

void initFcm() {
  if (_firebaseMessaging == null) {
    _firebaseMessaging = FirebaseMessaging();
  }

  _firebaseMessaging.getToken().then((token) {
    print("\n******\nFirebase Token $token\n******\n");
  });
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print('\n\n\n*** on message $message');
    },
    onResume: (Map<String, dynamic> message) async {
      print('\n\n\n*** on resume $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      print('\n\n\n*** on launch $message');
    },
  );

  if (Platform.isIOS) {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("iOS Push Settings: [$settings]");
    });
  }
}
