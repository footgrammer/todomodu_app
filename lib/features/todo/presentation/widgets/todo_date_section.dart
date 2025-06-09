import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/date_picker_box.dart';

class TodoDateSection extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onStartTap;
  final VoidCallback onEndTap;

  const TodoDateSection({
    required this.startDate,
    required this.endDate,
    required this.onStartTap,
    required this.onEndTap,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          '시작일',
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: const Text(
                          '종료일',
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerBox(
                          date: startDate,
                          onTap: onStartTap,
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                          child: DatePickerBox(
                              date: endDate, onTap: onEndTap))
                    ],
                  ),
                ],
              );
  }
}