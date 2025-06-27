

import 'package:flutter/material.dart';

class MemberSearchInput extends StatelessWidget {
  final List<String> selectedMemberNames;
  final void Function(String) onMemberRemove;
  final TextEditingController controller;

  const MemberSearchInput({
    super.key,
    required this.selectedMemberNames,
    required this.onMemberRemove,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        prefix: selectedMemberNames.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: selectedMemberNames.map((name) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEAFF),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: const Color(0xFFF4F4F4),
                            child: Text(
                              name.characters.first,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(name, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => onMemberRemove(name),
                            child: const Icon(Icons.close, size: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
        hintText: '닉네임을 입력하세요',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
    );
  }
}
