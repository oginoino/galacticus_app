import '../domain/assistant_overview.dart';
import '../dto/assistant_dto.dart';
import '../service/assistant/assistant_service_interface.dart';

class AssistantRepository {
  AssistantRepository(this._service);

  final AssistantServiceInterface _service;

  Future<AssistantOverview> getAssistant() async {
    final json = await _service.fetchAssistant();
    return AssistantDto.fromJson(json).toDomain();
  }
}
