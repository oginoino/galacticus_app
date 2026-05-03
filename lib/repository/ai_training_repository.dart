import '../domain/ai_training_overview.dart';
import '../dto/ai_training_dto.dart';
import '../service/ai_training/ai_training_service_interface.dart';

class AiTrainingRepository {
  AiTrainingRepository(this._service);

  final AiTrainingServiceInterface _service;

  Future<AiTrainingOverview> getAiTraining() async {
    final json = await _service.fetchAiTraining();
    return AiTrainingDto.fromJson(json).toDomain();
  }
}
