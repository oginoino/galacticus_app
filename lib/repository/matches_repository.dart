import '../domain/match_overview.dart';
import '../dto/matches_dto.dart';
import '../service/matches/matches_service_interface.dart';

class MatchesRepository {
  MatchesRepository(this._service);

  final MatchesServiceInterface _service;

  Future<MatchOverview> getMatches() async {
    final json = await _service.fetchMatches();
    return MatchesDto.fromJson(json).toDomain();
  }
}
