part of 'project_detail_page.dart';

Widget buildFab({
  required int tabIndex,
  required BuildContext context,
  required String projectId,
  required List<UserEntity> projectMembers, // 정확한 타입으로 변경 가능
  required WidgetRef ref,
}) {
  final noticeVm = ref.read(noticeListViewModelProvider.notifier);
  final currentUser = ref.read(userProvider).asData?.value;

  switch (tabIndex) {
    case 0: // 할 일
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          height: 48,
          width: 129,
          child: FloatingActionButton.extended(
            heroTag: 'fab-todo',
            backgroundColor: AppColors.primary500,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => AddTodoPage(
                        projectId: projectId,
                        projectMembers: projectMembers,
                      ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text('할 일 추가', style: AppTextStyles.subtitle1),
          ),
        ),
      );

    case 1: // 공지
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          height: 48,
          width: 129,
          child: FloatingActionButton.extended(
            heroTag: 'fab-notice',
            backgroundColor: AppColors.primary500,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoticeCreatePage(projectId: projectId),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text('공지 작성', style: AppTextStyles.subtitle1),
          ),
        ),
      );

    default:
      return const SizedBox.shrink();
  }
}
