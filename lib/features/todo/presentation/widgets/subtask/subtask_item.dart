//add_subtask_list.dart, edit_subtask_list.dart에서 반복되는 블록
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/user_search_bottom_sheet.dart';


class SubtaskItem extends StatefulWidget {
  final Subtask subtask;
  final void Function(Subtask updated) onChanged;
  final VoidCallback onDelete;
  final List<UserEntity> projectMembers;

  const SubtaskItem({
    super.key,
    required this.subtask,
    required this.onChanged,
    required this.onDelete,
    required this.projectMembers,
  });

  @override
  State<SubtaskItem> createState() => _SubtaskItemState();
}

class _SubtaskItemState extends State<SubtaskItem> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.subtask.title);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onChanged(widget.subtask.copyWith(title: _controller.text));
  }

Future<void> _onTapAssigneeEdit() async {
  final selected = await showModalBottomSheet<List<UserEntity>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (bottomSheetContext) => UserSearchBottomSheet(
      members: widget.projectMembers,
      selectedUsers: widget.subtask.assignee != null
          ? [widget.subtask.assignee!]
          : [],
      onConfirm: (List<UserEntity> _) {},
    ),
  );

    if (selected != null && selected.isNotEmpty) {
      widget.onChanged(widget.subtask.copyWith(assignee: selected.first));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final length = _controller.text.characters.length;
    final assignee = widget.subtask.assignee;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 60, bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    border: Border.all(color: AppColors.grey200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: '세부 할 일을 입력하세요',
                      border: InputBorder.none,
                      hintStyle: AppTextStyles.body2.copyWith(color: AppColors.grey400),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      counterText: '',
                    ),
                    style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
                  ),
                ),
                // 글자수
                Positioned(
                  right: 16,
                  bottom: 8,
                  child: Text(
                    '$length/50',
                    style: const TextStyle(fontSize: 12, color: AppColors.grey400),
                  ),
                ),
                // 담당자 아이콘
                Positioned(
                  right: 16,
                  top: 8,
                  child: GestureDetector(
                    onTap: _onTapAssigneeEdit,
                    child: assignee == null
                        ? const Icon(Icons.person_add_alt, size: 20, color: AppColors.grey400)
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: assignee.profileImageUrl.isNotEmpty
                                ? NetworkImage(assignee.profileImageUrl)
                                : null,
                            child: assignee.profileImageUrl.isEmpty
                                ? Text(
                                    assignee.name.characters.first,
                                    style: const TextStyle(fontSize: 10, color: Colors.white),
                                  )
                                : null,
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
