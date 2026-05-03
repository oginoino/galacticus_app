import '../domain/feed_overview.dart';
import '../dto/feed_dto.dart';
import '../service/feed/feed_service_interface.dart';

class FeedRepository {
  FeedRepository(this._feedService);

  final FeedServiceInterface _feedService;

  Future<FeedOverview> getFeed() async {
    final json = await _feedService.fetchFeed();
    return FeedDto.fromJson(json).toDomain();
  }
}
