import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/features/user/data/datasources/user_data_source.dart';
import 'package:todomodu_app/shared/types/result.dart';

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
  Future<Result<List<UserDto>>> getUsersByIds(List<String> ids) async {
    try {
      if (ids.isEmpty) return Result.ok([]); // 빈 리스트 방어

      // Firestore는 whereIn에 최대 10개 제한이 있음
      if (ids.length > 10) {
        // 필요하다면 여기에 배치 처리 로직을 넣을 수도 있음
        return Result.error(
          Exception(
            'Too many IDs. Firestore "whereIn" supports max 10 elements.',
          ),
        );
      }

      final snapshot =
          await _firestore
              .collection('users')
              .where(FieldPath.documentId, whereIn: ids)
              .get();

      final users =
          snapshot.docs.map((doc) {
            final data = doc.data()..['userId'] = doc.id;
            return UserDto.fromJson(data);
          }).toList();

      return Result.ok(users);
    } catch (e) {
      return Result.error(Exception('Failed to fetch users by ids: $e'));
    }
  }

  @override
  Stream<UserDto?> getUserByUserId(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserDto.fromJson(doc.data()!);
    });
  }
}
