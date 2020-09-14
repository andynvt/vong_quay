import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseService _sInstance;
  static FirebaseMessaging _messaging;
  static FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseService._();

  factory FirebaseService.shared() {
    if (_sInstance == null) {
      _sInstance = FirebaseService._();
    }
    return _sInstance;
  }

  static Future init() async {
    await FirebaseService.shared()._init();
  }

  void logScreen(String name, {String className = 'Flutter'}) {
    _analytics.setCurrentScreen(screenName: name, screenClassOverride: className);
  }

  Future _init() async {
    _messaging = FirebaseMessaging();
    if (Platform.isIOS) {
      await _requestIOSPermission();
    }
    _fireBaseListeners();
  }

  void _fireBaseListeners() {
    _messaging.getToken().then((token) {
      print('---> fcmToken: $token');
    });
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('---> on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('---> on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('---> on launch $message');
      },
    );
  }

  Future _requestIOSPermission() async {
    await _messaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _messaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("---> Settings registered: $settings");
    });
  }
}
