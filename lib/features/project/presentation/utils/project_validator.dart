class ProjectValidator {
  static String? validateTitle(String title) {
    if (title.trim().isEmpty) return '프로젝트 이름을 입력해 주세요.';
    return null;
  }

  static String? validateDescription(String desc) {
    if (desc.trim().isEmpty) return '프로젝트 설명을 입력해 주세요.';
    return null;
  }

  static String? validateDates(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '시작일과 종료일을 선택해 주세요.';
    return null;
  }
}
