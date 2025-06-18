import 'package:flutter/material.dart';

class SubtaskList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final void Function(int) onRemove;

  const SubtaskList({
    super.key,
    required this.controllers,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(controllers.length, (index) {
        final controller = controllers[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controller,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          hintText: '세부 할 일',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => onRemove(index),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${controller.text.length}/50',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
