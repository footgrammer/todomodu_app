import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todomodu_app/features/notification/data/datasources/fcm_data_source.dart';

class FcmDataSourceImpl implements FcmDataSource {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;
  bool _isListening = false;

  FcmDataSourceImpl({
    required FirebaseMessaging messaging,
    required FirebaseFirestore firestore,
  }) : _messaging = messaging,
       _firestore = firestore;

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  void listenTokenRefresh(String userId) {
    if (_isListening) return;
    _isListening = true;

    _messaging.onTokenRefresh.listen((newToken) async {
      try {
        await _firestore.collection('users').doc(userId).update({
          'fcmToken': newToken,
        });
      } catch (e) {
        print('FCM 토큰 갱신 실패: $e');
      }
    });
  }
}
