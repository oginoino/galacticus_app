import '../domain/checkin_overview.dart';
import '../dto/checkin_dto.dart';
import '../service/checkin/checkin_service_interface.dart';

class CheckinRepository {
  CheckinRepository(this._service);

  final CheckinServiceInterface _service;

  Future<CheckinOverview> getCheckin() async {
    final json = await _service.fetchCheckin();
    return CheckinDto.fromJson(json).toDomain();
  }
}
