
import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/domain/entities/subtask.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class SubtaskItem extends StatefulWidget {
  final Subtask subtask;
  final void Function(Subtask updated) onChanged;
  final VoidCallback onDelete;

  const SubtaskItem({
    required this.subtask,
    required this.onChanged,
    required this.onDelete,
    super.key,
  });

  @override
  _SubtaskItemState createState() => _SubtaskItemState();
}

class _SubtaskItemState extends State<SubtaskItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.subtask.title);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onChanged(widget.subtask.copyWith(title: _controller.text));
    setState(() {}); // counter 업데이트
  }

  @override
  void didUpdateWidget(covariant SubtaskItem old) {
    super.didUpdateWidget(old);
    if (old.subtask.title != widget.subtask.title) {
      _controller.text = widget.subtask.title;
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
                    decoration: const InputDecoration(
                      hintText: '세부 할 일을 입력하세요',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      counterText: '',
                    ),
                    style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 8,
                  child: Text(
                    '${_controller.text.length}/50',
                    style: const TextStyle(fontSize: 12, color: AppColors.grey400),
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
