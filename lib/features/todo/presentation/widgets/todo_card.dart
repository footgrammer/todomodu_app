import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> subTasks;

  const TodoCard({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.subTasks,
    });

  @override
  Widget build(BuildContext context) {
    final dateRange = 
    '${startDate.year}.${startDate.month.toString().padLeft(2, '0')}.${startDate.day.toString().padLeft(2, '0')}'
    ' ~ '
    '${endDate.year}.${endDate.month.toString().padLeft(2, '0')}.${endDate.day.toString().padLeft(2, '0')}';


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(dateRange, style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 12,),
            ...subTasks.map((subTaskTitle) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle_outlined, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(subTaskTitle)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}