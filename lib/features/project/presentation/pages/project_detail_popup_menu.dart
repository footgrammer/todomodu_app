part of 'project_detail_page.dart';

Widget buildPopupMenu() {
  return Row(
    children: [
      PopupMenuButton<String>(
        menuPadding: const EdgeInsets.symmetric(horizontal: 9),
        icon: const Icon(Icons.more_vert),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        offset: const Offset(-10, 40),
        color: Colors.white,
        onSelected: (value) {
          if (value == 'edit') {
            // TODO: 프로젝트 수정 로직
          } else if (value == 'leave') {
            // TODO: 프로젝트 나가기 로직
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            padding: EdgeInsets.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '프로젝트 정보 수정하기',
                style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'leave',
            padding: EdgeInsets.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '프로젝트 나가기',
                style: AppTextStyles.body2.copyWith(color: AppColors.grey800),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(width: 14),
    ],
  );
}
