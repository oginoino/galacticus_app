import '../domain/dashboard_overview.dart';
import '../dto/dashboard_dto.dart';
import '../service/home/home_service_interface.dart';

class HomeRepository {
  HomeRepository(this._homeService);

  final HomeServiceInterface _homeService;

  Future<DashboardOverview> getDashboard() async {
    final json = await _homeService.fetchHomeFeed();
    return DashboardDto.fromJson(json).toDomain();
  }
}
