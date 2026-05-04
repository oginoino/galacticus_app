import '../domain/ranking_overview.dart';
import '../dto/ranking_dto.dart';
import '../service/ranking/ranking_service_interface.dart';

class RankingRepository {
  RankingRepository(this._service);

  final RankingServiceInterface _service;

  Future<RankingOverview> getRanking() async {
    final json = await _service.fetchRanking();
    return RankingDto.fromJson(json).toDomain();
  }
}
