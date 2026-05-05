import '../domain/post_detail_overview.dart';
import '../dto/post_detail_dto.dart';
import '../service/post_detail/post_detail_service_interface.dart';

class PostDetailRepository {
  PostDetailRepository(this._service);

  final PostDetailServiceInterface _service;

  Future<PostDetailOverview> getPostDetail({String? id}) async {
    final json = await _service.fetchPostDetail();
    return PostDetailDto.fromJson(json).toDomain();
  }
}
