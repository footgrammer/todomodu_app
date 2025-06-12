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
  Future<Result<List<NoticeDto>>> getNoticesByProjectIds(List<String> ids) {
    throw UnimplementedError();
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

      if (!doc.exists) {
        return Result.error(Exception('Notice not found'));
      }

      final dto = NoticeDto.fromJson(doc.data()!..['id'] = doc.id);
      return Result.ok(dto);
    } catch (e) {
      return Result.error(Exception('Failed to fetch notice: $e'));
    }
  }

  @override
  Future<Result<NoticeDto>> createNotice(NoticeDto notice) async {
    print('projectId: ${notice.projectId}');
    try {
      final docRef =
          _firestore
              .collection('projects')
              .doc(notice.projectId)
              .collection('notices')
              .doc(); // <- 여기 인자를 넣지 않으면 Firestore가 자동 ID 생성

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
        // 이미 체크되어 있으면 그대로 반환
        return Result.ok(noticeDto);
      }

      final updatedDto = NoticeDto(
        id: noticeDto.id,
        projectId: noticeDto.projectId,
        title: noticeDto.title,
        content: noticeDto.content,
        checkedUsers: updatedCheckedUsers,
        createdAt: noticeDto.createdAt,
      );

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
}
