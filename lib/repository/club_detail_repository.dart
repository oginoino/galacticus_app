import '../domain/club_detail_overview.dart';
import '../dto/club_detail_dto.dart';
import '../service/club_detail/club_detail_service_interface.dart';

class ClubDetailRepository {
  ClubDetailRepository(this._service);

  final ClubDetailServiceInterface _service;

  Future<ClubDetailOverview> getClub({String? slug}) async {
    final json = await _service.fetchClubDetail();
    return ClubDetailDto.fromJson(json).toDomain(slug: slug);
  }
}
