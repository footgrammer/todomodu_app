import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/notice/data/datasources/notice_data_source.dart';
import 'package:todomodu_app/features/notice/data/models/notice_dto.dart';
import 'package:todomodu_app/features/user/data/models/user_dto.dart';
import 'package:todomodu_app/shared/types/result.dart';

class NoticeDataSourceImpl implements NoticeDatasource {
  final FirebaseFirestore _firestore;

  NoticeDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<Result<List<NoticeDto>>> getNoticesByProjectIds(
    List<String> ids,
  ) async {
    try {
      final List<NoticeDto> allNotices = [];
      final futures = ids.map((projectId) async {
        final snapshot =
            await _firestore
                .collection('projects')
                .doc(projectId)
                .collection('notices')
                .get();

        final notices = snapshot.docs.map((doc) {
          final data = doc.data()..['id'] = doc.id;
          return NoticeDto.fromJson(data);
        });
        allNotices.addAll(notices);
      });

      await Future.wait(futures);
      return Result.ok(allNotices);
    } catch (e) {
      return Result.error(Exception('Failed to fetch notices: $e'));
    }
  }

  @override
  Future<Result<NoticeDto>> getNoticeById({
    required String projectId,
    required String noticeId,
  }) async {
    try {
      final doc =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('notices')
              .doc(noticeId)
              .get();

      if (!doc.exists) return Result.error(Exception('Notice not found'));
      final dto = NoticeDto.fromJson(doc.data()!..['id'] = doc.id);
      return Result.ok(dto);
    } catch (e) {
      return Result.error(Exception('Failed to fetch notice: $e'));
    }
  }

  @override
  Future<Result<NoticeDto>> createNotice(NoticeDto notice) async {
    try {
      final docRef =
          _firestore
              .collection('projects')
              .doc(notice.projectId)
              .collection('notices')
              .doc();

      final noticeWithId = notice.copyWith(id: docRef.id);
      await docRef.set(noticeWithId.toJson());
      return Result.ok(noticeWithId);
    } catch (e) {
      return Result.error(Exception('Failed to create notice: $e'));
    }
  }

  @override
  Future<Result<NoticeDto>> updateNotice(NoticeDto noticeDto) async {
    try {
      final docRef = _firestore
          .collection('projects')
          .doc(noticeDto.projectId)
          .collection('notices')
          .doc(noticeDto.id);

      await docRef.set(noticeDto.toJson(), SetOptions(merge: true));
      return Result.ok(noticeDto);
    } catch (e) {
      return Result.error(Exception('Failed to update notice: $e'));
    }
  }

  @override
  Future<Result<NoticeDto>> markNoticeAsRead({
    required NoticeDto noticeDto,
    required UserDto userDto,
  }) async {
    try {
      final updatedCheckedUsers = List<String>.from(noticeDto.checkedUsers);
      if (!updatedCheckedUsers.contains(userDto.userId)) {
        updatedCheckedUsers.add(userDto.userId);
      } else {
        return Result.ok(noticeDto);
      }

      final updatedDto = noticeDto.copyWith(checkedUsers: updatedCheckedUsers);
      final docRef = _firestore
          .collection('projects')
          .doc(updatedDto.projectId)
          .collection('notices')
          .doc(updatedDto.id);

      await docRef.set(updatedDto.toJson(), SetOptions(merge: true));
      return Result.ok(updatedDto);
    } catch (e) {
      return Result.error(Exception('Failed to mark notice as read: $e'));
    }
  }

  @override
  Stream<Result<List<NoticeDto>>> watchNoticesByProjectIds(
    List<String> projectIds,
  ) {
    if (projectIds.isEmpty) {
      return Stream.value(Result.ok([]));
    }

    if (projectIds.length > 10) {
      return Stream.value(
        Result.error(Exception('Firestore whereIn은 최대 10개까지 지원됩니다.')),
      );
    }

    final query = _firestore
        .collectionGroup('notices')
        .where('projectId', whereIn: projectIds);

    return query.snapshots().map((snapshot) {
      try {
        final dtos =
            snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return NoticeDto.fromJson({...data, 'id': doc.id});
            }).toList();
        return Result.ok(dtos);
      } catch (e) {
        return Result.error(Exception('NoticeDto 변환 중 오류: $e'));
      }
    });
  }

  @override
  Stream<Result<List<NoticeDto>>> watchNoticesByProjectId(String projectId) {
    final query = _firestore
        .collection('projects')
        .doc(projectId)
        .collection('notices');

    return query.snapshots().map<Result<List<NoticeDto>>>((snapshot) {
      try {
        final dtos =
            snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return NoticeDto.fromJson({...data, 'id': doc.id});
            }).toList();
        return Result.ok(dtos);
      } catch (e) {
        return Result.error(Exception('NoticeDto 변환 오류: $e'));
      }
    });
  }
}
