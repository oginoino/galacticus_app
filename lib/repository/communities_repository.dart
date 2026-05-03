import '../domain/communities_overview.dart';
import '../dto/communities_dto.dart';
import '../service/communities/communities_service_interface.dart';

class CommunitiesRepository {
  CommunitiesRepository(this._communitiesService);

  final CommunitiesServiceInterface _communitiesService;

  Future<CommunitiesOverview> getCommunities() async {
    final json = await _communitiesService.fetchCommunities();
    return CommunitiesDto.fromJson(json).toDomain();
  }
}
