import '../domain/notifications_overview.dart';
import '../dto/notifications_dto.dart';
import '../service/notifications/notifications_service_interface.dart';

class NotificationsRepository {
  NotificationsRepository(this._service);

  final NotificationsServiceInterface _service;

  Future<NotificationsOverview> getNotifications() async {
    final json = await _service.fetchNotifications();
    return NotificationsDto.fromJson(json).toDomain();
  }
}
