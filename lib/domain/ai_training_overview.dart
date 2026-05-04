import 'ai_training_messages.dart';
import 'ai_training_metric.dart';
import 'ai_training_reference.dart';

class AiTrainingOverview {
  const AiTrainingOverview({
    required this.eyebrow,
    required this.title,
    required this.closeSemantics,
    required this.referenceModes,
    required this.references,
    required this.metrics,
    required this.instructionTitle,
    required this.instructionBody,
    required this.startButtonLabel,
    required this.nextButtonLabel,
    required this.progressTitle,
    required this.progressSubtitle,
    required this.previewLabel,
    required this.referenceSectionTitle,
    required this.modeSectionTitle,
    required this.assistantLogoAsset,
    required this.backgroundAsset,
    required this.watermarkAsset,
    required this.previewAsset,
    required this.messages,
  });

  final String eyebrow;
  final String title;
  final String closeSemantics;
  final List<String> referenceModes;
  final List<AiTrainingReference> references;
  final List<AiTrainingMetric> metrics;
  final String instructionTitle;
  final String instructionBody;
  final String startButtonLabel;
  final String nextButtonLabel;
  final String progressTitle;
  final String progressSubtitle;
  final String previewLabel;
  final String referenceSectionTitle;
  final String modeSectionTitle;
  final String assistantLogoAsset;
  final String backgroundAsset;
  final String watermarkAsset;
  final String previewAsset;
  final AiTrainingMessages messages;
}
