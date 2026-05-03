import '../domain/profile_overview.dart';
import '../dto/profile_dto.dart';
import '../service/profile/profile_service_interface.dart';

class ProfileRepository {
  ProfileRepository(this._profileService);

  final ProfileServiceInterface _profileService;

  Future<ProfileOverview> getProfile() async {
    final json = await _profileService.fetchProfile();
    return ProfileDto.fromJson(json).toDomain();
  }
}
