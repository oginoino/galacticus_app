import '../domain/assistant_messages.dart';
import '../domain/assistant_overview.dart';
import '../domain/assistant_prompt_option.dart';

class AssistantDto {
  AssistantDto({
    required this.payload,
  });

  factory AssistantDto.fromJson(Map<String, dynamic> json) {
    return AssistantDto(payload: json);
  }

  final Map<String, dynamic> payload;

  AssistantOverview toDomain() {
    final messages = payload['messages'] as Map<String, dynamic>;

    return AssistantOverview(
      greeting: payload['greeting'] as String,
      subtitlePrefix: payload['subtitlePrefix'] as String,
      highlightText: payload['highlightText'] as String,
      subtitleSuffix: payload['subtitleSuffix'] as String,
      inputPlaceholder: payload['inputPlaceholder'] as String,
      onlineLabel: payload['onlineLabel'] as String,
      logoAsset: payload['logoAsset'] as String,
      promptOptions: (payload['promptOptions'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (item) => AssistantPromptOption(
              label: item['label'] as String,
            ),
          )
          .toList(growable: false),
      messages: AssistantMessages(
        quickAction: messages['quickAction'] as String,
        promptAction: messages['promptAction'] as String,
        sendAction: messages['sendAction'] as String,
      ),
    );
  }
}
