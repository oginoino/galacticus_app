import '../domain/shooting_overview.dart';
import '../dto/shooting_dto.dart';
import '../service/shooting/shooting_service_interface.dart';

class ShootingRepository {
  ShootingRepository(this._service);

  final ShootingServiceInterface _service;

  Future<ShootingOverview> getShooting() async {
    final json = await _service.fetchShooting();
    return ShootingDto.fromJson(json).toDomain();
  }
}
