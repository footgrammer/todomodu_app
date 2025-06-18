import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Stream<UserDto?> getCurrentUser() {
    return _firebaseAuth.userChanges().asyncExpand((user) {
      if (user == null) {
        return Stream.value(null);
      } else {
        return _firestore.collection('users').doc(user.uid).snapshots().map((
          doc,
        ) {
          if (!doc.exists) return null;
          return UserDto.fromJson(doc.data()!);
        });
      }
    });
  }

  @override
  Stream<UserDto?> getUserByUserId(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserDto.fromJson(doc.data()!);
    });
  }
}
