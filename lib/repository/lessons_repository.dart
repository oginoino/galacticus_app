import '../domain/lessons_overview.dart';
import '../dto/lessons_dto.dart';
import '../service/lessons/lessons_service_interface.dart';

class LessonsRepository {
  LessonsRepository(this._service);

  final LessonsServiceInterface _service;

  Future<LessonsOverview> getLessons() async {
    final json = await _service.fetchLessons();
    return LessonsDto.fromJson(json).toDomain();
  }
}
