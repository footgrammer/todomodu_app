import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';

class WatchNoticesBySimpleProjectsUsecase {
  final NoticeRepository _repository;

  WatchNoticesBySimpleProjectsUsecase({required NoticeRepository repository})
      : _repository = repository;

  Stream<List<Notice>> execute({required List<SimpleProjectInfo> projects}) {
    final projectIds = projects.map((p) => p.id).toList();
    return _repository.watchNoticesByProjectIds(projectIds);
  }
}
