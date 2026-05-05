import '../domain/training_detail_overview.dart';
import '../dto/training_detail_dto.dart';
import '../service/training_detail/training_detail_service_interface.dart';

class TrainingDetailRepository {
  TrainingDetailRepository(this._service);

  final TrainingDetailServiceInterface _service;

  Future<TrainingDetailOverview> getTrainingDetail({String? id}) async {
    final json = await _service.fetchTrainingDetail();
    return TrainingDetailDto.fromJson(json).toDomain();
  }
}
