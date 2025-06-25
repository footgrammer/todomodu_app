import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/member_search_input.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/features/user/presentation/providers/assignee_search_provider.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class UserSearchBottomSheet extends ConsumerStatefulWidget {
  final List<UserEntity> members;
  final List<UserEntity> selectedUsers;
  final void Function(List<UserEntity>) onConfirm;

  const UserSearchBottomSheet({
    super.key,
    required this.members,
    required this.selectedUsers,
    required this.onConfirm,
  });

  @override
  ConsumerState<UserSearchBottomSheet> createState() => _UserSearchBottomSheetState();
}

class _UserSearchBottomSheetState extends ConsumerState<UserSearchBottomSheet> {
  late TextEditingController _searchController;
  late List<UserEntity> _selected;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selected = [...widget.selectedUsers];

    _searchController.addListener(() {
      ref
          .read(assigneeSearchProvider(widget.members).notifier)
          .search(_searchController.text.trim());
    });
  }

  void _toggleUser(UserEntity user) {
    setState(() {
      if (_selected.any((u) => u.userId == user.userId)) {
        _selected.removeWhere((u) => u.userId == user.userId);
      } else {
        _selected.add(user);
      }
    });
  }

void _removeByName(String name) {
  final target = _selected.where((u) => u.name == name).cast<UserEntity?>().firstOrNull;
  if (target != null) {
    _toggleUser(target);
  }
}

  @override
  Widget build(BuildContext context) {
    final filtered = ref.watch(assigneeSearchProvider(widget.members));

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('할 일 담당자 선택',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 검색창 + 선택 유저
              MemberSearchInput(
                controller: _searchController,
                selectedMemberNames: _selected.map((u) => u.name).toList(),
                onMemberRemove: _removeByName,
              ),

              const SizedBox(height: 16),

              // 멤버 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final user = filtered[index];
                    final isSelected = _selected.any((u) => u.userId == user.userId);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage: user.profileImageUrl.isNotEmpty
                            ? NetworkImage(user.profileImageUrl)
                            : null,
                        child: user.profileImageUrl.isEmpty
                            ? Text(user.name.characters.first)
                            : null,
                      ),
                      title: Text(user.name),
                      trailing: Icon(
                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isSelected ? AppColors.primary500 : AppColors.grey400,
                      ),
                      onTap: () => _toggleUser(user),
                    );
                  },
                ),
              ),

              // 확인 버튼
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 58),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      widget.onConfirm(_selected);
                      Navigator.pop(context);
                    },
                    child: Text(
                      '확인',
                      style: AppTextStyles.subtitle1.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
