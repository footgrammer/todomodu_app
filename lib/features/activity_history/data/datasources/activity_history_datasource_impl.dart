import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todomodu_app/features/activity_history/data/datasources/activity_history_datasource.dart';
import 'package:todomodu_app/features/activity_history/data/models/activity_history_dto.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ActivityHistoryDatasourceImpl implements ActivityHistoryDatasource {
  final FirebaseFirestore _firestore;

  ActivityHistoryDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('activities');

  @override
  Future<Result<void>> save(ActivityHistory activity) async {
    try {
      final dto = ActivityHistoryDto.fromEntity(activity);

      final json =
          dto.toJson()
            ..['createdAt'] = FieldValue.serverTimestamp(); // 서버 타임 강제 삽입

      await _collection.doc(activity.id).set(json);
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
          await _collection
              .where('projectId', isEqualTo: projectId)
              .orderBy('createdAt', descending: true)
              .get();

      final activities =
          snapshot.docs.map((doc) {
            final data = doc.data();
            final dto = ActivityHistoryDto.fromJson(data, doc.id);
            return dto.toEntity();
          }).toList();

      return Ok(activities);
    } catch (e, st) {
      return Error(Exception('Failed to fetch activities: $e\n$st'));
    }
  }
}
