import 'assistant_messages.dart';
import 'assistant_prompt_option.dart';

class AssistantOverview {
  const AssistantOverview({
    required this.greeting,
    required this.subtitlePrefix,
    required this.highlightText,
    required this.subtitleSuffix,
    required this.inputPlaceholder,
    required this.onlineLabel,
    required this.logoAsset,
    required this.promptOptions,
    required this.messages,
  });

  final String greeting;
  final String subtitlePrefix;
  final String highlightText;
  final String subtitleSuffix;
  final String inputPlaceholder;
  final String onlineLabel;
  final String logoAsset;
  final List<AssistantPromptOption> promptOptions;
  final AssistantMessages messages;
}
