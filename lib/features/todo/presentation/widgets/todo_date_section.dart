import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/date_picker_box.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

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
                        child: Text(
                          '시작일',
                          style:
                              AppTextStyles.body3.copyWith(
                                color: AppColors.grey500,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          '종료일',
                          style:
                              AppTextStyles.body3.copyWith(
                                color: AppColors.grey500,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerBox(
                          date: startDate,
                          onTap: onStartTap,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                          child: DatePickerBox(
                              date: endDate, onTap: onEndTap))
                    ],
                  ),
                ],
              );
  }
}