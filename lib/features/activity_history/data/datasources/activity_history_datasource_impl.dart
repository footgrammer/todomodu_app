import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource.dart';
import 'package:todomodu_app/features/activity_history/data/models/activity_history_dto.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ActivityHistoryDatasourceImpl implements ActivityHistoryDatasource {
  final FirebaseFirestore _firestore;

  ActivityHistoryDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<Result<void>> save(ActivityHistory activity) async {
    try {
      final dto = ActivityHistoryDto.fromEntity(activity);

      final projectRef = _firestore
          .collection('projects')
          .doc(activity.projectId);
      final activityCollection = projectRef.collection('activity_histories');

      final json = dto.toJson()..['createdAt'] = FieldValue.serverTimestamp();

      await activityCollection.add(json); // 🔧 자동 ID로 저장

      return const Ok(null);
    } catch (e, st) {
      return Error(Exception('Failed to save activity: $e\n$st'));
    }
  }

  @override
  Future<Result<List<ActivityHistory>>> fetchByProjectId(
    String projectId,
  ) async {
    try {
      final snapshot =
          await _firestore
              .collection('projects')
              .doc(projectId)
              .collection('activity_histories')
              .orderBy('createdAt', descending: true)
              .get();

      final activities =
          snapshot.docs.map((doc) {
            final dto = ActivityHistoryDto.fromJson(doc.data(), doc.id);
            return dto.toEntity();
          }).toList();

      return Ok(activities);
    } catch (e, st) {
      return Error(Exception('Failed to fetch activities: $e\n$st'));
    }
  }

  @override
  Stream<List<ActivityHistory>> subscribe(String projectId) {
    return _firestore
        .collection('projects')
        .doc(projectId)
        .collection('activityHistories')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                return ActivityHistoryDto.fromJson(
                  doc.data(),
                  doc.id,
                ).toEntity();
              }).toList(),
        );
  }
}
