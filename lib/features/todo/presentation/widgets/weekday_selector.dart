import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekdaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onSelect;

  const WeekdaySelector({
    super.key,
    required this.selectedDate,
    required this.onSelect,
  });

  List<DateTime> _generateWeekDates(DateTime reference) {
    final start = reference.subtract(Duration(days: reference.weekday % 7));
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _generateWeekDates(selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDates.map((date) {
        final isSelected = date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;

        return GestureDetector(
          onTap: () => onSelect(date),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF706FBF) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('E', 'en_US').format(date).toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
