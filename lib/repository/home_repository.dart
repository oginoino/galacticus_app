import '../domain/dashboard_overview.dart';
import '../dto/dashboard_dto.dart';
import 'base_repository.dart';

class HomeRepository extends BaseRepository {
  Future<DashboardOverview> getDashboard() async {
    final json = await loadJsonObject(assetPath('home_feed.json'));
    return DashboardDto.fromJson(json).toDomain();
  }
}
