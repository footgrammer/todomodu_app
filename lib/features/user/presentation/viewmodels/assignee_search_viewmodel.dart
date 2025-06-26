import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class AssigneeSearchViewModel extends StateNotifier<List<UserEntity>> {
  final List<UserEntity> _allMembers;

  AssigneeSearchViewModel(this._allMembers) : super(_allMembers);

  void search(String keyword) {
    if (keyword.isEmpty) {
      state = _allMembers;
    } else {
      state = _allMembers
          .where((user) => user.name.contains(keyword))
          .toList();
    }
  }

  void clear() {
    state = _allMembers;
  }
}
