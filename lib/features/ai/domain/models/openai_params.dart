class OpenaiParams {
  final String projectTitle;
  final DateTime projectStartDate;
  final DateTime projectEndDate;
  final String prompt;

  OpenaiParams({
    required this.projectTitle,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.prompt,
  });
}