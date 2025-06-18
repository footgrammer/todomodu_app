import 'package:flutter/material.dart';
import '../../../domain/entities/subtask.dart';

class EditTodoSubtaskList extends StatelessWidget {
  final List<Subtask> subtasks;
  final void Function(int index, String value) onTitleChange;
  final void Function(int index) onRemove;

  const EditTodoSubtaskList({
    super.key,
    required this.subtasks,
    required this.onTitleChange,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(subtasks.length, (index) {
        final subtask = subtasks[index];
        final controller = TextEditingController.fromValue(
          TextEditingValue(
            text: subtask.title,
            selection: TextSelection.collapsed(offset: subtask.title.length),
          ),
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 60, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controller,
                        maxLength: 50,
                        onChanged: (value) => onTitleChange(index, value),
                        decoration: const InputDecoration(
                          hintText: '세부 할 일',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          counterText: '',
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 8,
                      child: Text(
                        '${controller.text.length}/50',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => onRemove(index),
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        );
      }),
    );
  }
}
