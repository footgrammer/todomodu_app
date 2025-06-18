import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class NoticeCheckButton extends StatefulWidget {
  NoticeCheckButton({required this.isChecked, super.key});
  bool isChecked;

  @override
  State<NoticeCheckButton> createState() => _NoticeCheckButtonState();
}

class _NoticeCheckButtonState extends State<NoticeCheckButton> {
  final beforecheckedText = '확인했나요?';
  final checkedText = '확인했습니다!';
  String buttonText = '';
  @override
  void initState() {
    super.initState();
    buttonText = widget.isChecked ? checkedText : beforecheckedText;
  }

  void onCheckedChange() {
    setState(() {
      widget.isChecked = !widget.isChecked;
      buttonText = widget.isChecked ? checkedText : beforecheckedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.isChecked ? checkedText : beforecheckedText);
        onCheckedChange();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey600),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            CustomIcon(name: 'Circle_Check', color: AppColors.grey600,),
            SizedBox(width: 4,),
            Text(
              buttonText,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
      ),
    );
  }
}
