import '../domain/agenda_overview.dart';
import '../dto/agenda_dto.dart';
import '../service/agenda/agenda_service_interface.dart';

class AgendaRepository {
  AgendaRepository(this._service);

  final AgendaServiceInterface _service;

  Future<AgendaOverview> getAgenda() async {
    final json = await _service.fetchAgenda();
    return AgendaDto.fromJson(json).toDomain();
  }
}
