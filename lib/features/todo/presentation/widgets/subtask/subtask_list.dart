import 'package:flutter/material.dart';

class SubtaskList extends StatelessWidget{
  final List<TextEditingController> controllers;
  final void Function(int) onRemove;
  
  const SubtaskList({
    required this.controllers,
    required this.onRemove,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
                children: List.generate(controllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                                hintText: '세부 할일',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14)),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () => onRemove(index),
                            icon: const Icon(Icons.remove_circle_outline)),
                      ],
                    ),
                  );
                }),
              );
  }
}