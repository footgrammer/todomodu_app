import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/form_fields/project_date_box.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project/project_label.dart';

class ProjectDateRangeField extends ConsumerWidget {
  final StateProvider<DateTime?> startDateProvider;
  final StateProvider<DateTime?> endDateProvider;

  const ProjectDateRangeField({
    super.key,
    required this.startDateProvider,
    required this.endDateProvider,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectLabel(text: "시작일"),
              SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  await getStartDate(context, startDate, endDate, ref);
                },
                child: ProjectDateBox(startDate),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectLabel(text: "종료일"),
              SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  await getEndDate(context, endDate, startDate, ref);
                },
                child: ProjectDateBox(endDate),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getStartDate(
    BuildContext context,
    DateTime? startDate,
    DateTime? endDate,
    WidgetRef ref,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: endDate ?? DateTime(2100),
    );
    if (pickedDate != null) {
      ref.read(startDateProvider.notifier).state = pickedDate;
    }
  }

  Future<void> getEndDate(
    BuildContext context,
    DateTime? endDate,
    DateTime? startDate,
    WidgetRef ref,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? (startDate ?? DateTime.now()),
      firstDate: startDate ?? DateTime.now(), // 시작일 혹은 지금보다 이른 날짜 선택 금지
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      // ✅ 조건 만족 시만 저장
      ref.read(endDateProvider.notifier).state = pickedDate;
    }
  }
}
