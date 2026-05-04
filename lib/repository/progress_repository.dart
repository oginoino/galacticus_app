import '../domain/progress_overview.dart';
import '../dto/progress_dto.dart';
import '../service/progress/progress_service_interface.dart';

class ProgressRepository {
  ProgressRepository(this._service);

  final ProgressServiceInterface _service;

  Future<ProgressOverview> getProgress() async {
    final json = await _service.fetchProgress();
    return ProgressDto.fromJson(json).toDomain();
  }
}
