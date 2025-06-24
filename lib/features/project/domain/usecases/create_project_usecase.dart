class CreateProjectUsecase {
  final ProjectRepository repository;
  CreateProjectUsecase(this.repository);

  Future<void> execute(ProjectCreateState state) async {
    final entity = ProjectEntity.fromState(state); // 변환 로직 필요
    await repository.createProject(entity);
  }
}
