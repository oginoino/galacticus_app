import '../domain/shooting_messages.dart';
import '../domain/shooting_overview.dart';
import '../domain/shot_item.dart';

class ShootingDto {
  ShootingDto({required this.payload});

  factory ShootingDto.fromJson(Map<String, dynamic> json) {
    return ShootingDto(payload: json);
  }

  final Map<String, dynamic> payload;

  ShootingOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;
    return ShootingOverview(
      title: payload['title'] as String,
      subtitle: payload['subtitle'] as String,
      modeLabel: payload['modeLabel'] as String,
      modeEnabledByDefault: payload['modeEnabledByDefault'] as bool? ?? true,
      helpTitle: payload['helpTitle'] as String,
      helpText: payload['helpText'] as String,
      galleryTitle: payload['galleryTitle'] as String,
      items: (payload['items'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => ShotItem(
              id: item['id'] as String,
              dateLabel: item['dateLabel'] as String,
              sportIcon: item['sportIcon'] as String,
              sportLabel: item['sportLabel'] as String,
              courtLabel: item['courtLabel'] as String,
              imageAsset: item['imageAsset'] as String,
              durationLabel: item['durationLabel'] as String?,
            ),
          )
          .toList(growable: false),
      messages: ShootingMessages(
        toggleAction: messages['toggleAction'] as String,
        itemAction: messages['itemAction'] as String,
        loadErrorMessage: messages['loadErrorMessage'] as String,
      ),
    );
  }
}
