import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../repository/auth_repository.dart';
import '../repository/communities_repository.dart';
import '../repository/feed_repository.dart';
import '../repository/home_repository.dart';
import '../repository/booking_repository.dart';
import '../repository/assistant_repository.dart';
import '../repository/agenda_repository.dart';
import '../repository/ai_training_repository.dart';
import '../repository/checkin_repository.dart';
import '../repository/notifications_repository.dart';
import '../repository/lessons_repository.dart';
import '../repository/profile_repository.dart';
import '../repository/progress_repository.dart';
import '../repository/ranking_repository.dart';
import '../service/api/api_service_factory.dart';
import '../service/auth/auth_mock_service.dart';
import '../service/auth/auth_service_interface.dart';
import '../service/agenda/agenda_mock_service.dart';
import '../service/agenda/agenda_service_interface.dart';
import '../service/ai_training/ai_training_mock_service.dart';
import '../service/ai_training/ai_training_service_interface.dart';
import '../service/assistant/assistant_mock_service.dart';
import '../service/assistant/assistant_service_interface.dart';
import '../service/checkin/checkin_mock_service.dart';
import '../service/checkin/checkin_service_interface.dart';
import '../service/booking/booking_mock_service.dart';
import '../service/booking/booking_service_interface.dart';
import '../service/communities/communities_mock_service.dart';
import '../service/communities/communities_service_interface.dart';
import '../service/feed/feed_mock_service.dart';
import '../service/feed/feed_service_interface.dart';
import '../service/home/home_mock_service.dart';
import '../service/home/home_service_interface.dart';
import '../service/http/http_service.dart';
import '../service/http/http_service_interface.dart';
import '../service/localization/localization_service.dart';
import '../service/notifications/notifications_mock_service.dart';
import '../service/notifications/notifications_service_interface.dart';
import '../service/persistence/persistence_service.dart';
import '../service/profile/profile_mock_service.dart';
import '../service/profile/profile_service_interface.dart';
import '../service/progress/progress_mock_service.dart';
import '../service/progress/progress_service_interface.dart';
import '../service/ranking/ranking_mock_service.dart';
import '../service/ranking/ranking_service_interface.dart';
import '../service/lessons/lessons_mock_service.dart';
import '../service/lessons/lessons_service_interface.dart';
import '../util/const/app_constants.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> register() async {
    if (sl.isRegistered<AppConstants>()) {
      return;
    }

    final persistenceService = PersistenceService();
    try {
      await persistenceService.init();
    } catch (error, stackTrace) {
      debugPrint(
        'Falha ao inicializar PersistenceService. O app seguirá sem persistência local.\n$error\n$stackTrace',
      );
    }

    sl
      ..registerSingleton<AppConstants>(AppConstants.instance)
      ..registerSingleton<PersistenceService>(persistenceService)
      ..registerSingleton<LocalizationService>(
        LocalizationService(initialLocaleCode: persistenceService.localeCode),
      )
      ..registerLazySingleton<HttpServiceInterface>(HttpService.new)
      ..registerLazySingleton<ApiServiceFactory>(
        () => ApiServiceFactory(sl<HttpServiceInterface>()),
      )
      ..registerLazySingleton<CommunitiesServiceInterface>(
        CommunitiesMockService.new,
      )
      ..registerLazySingleton<CommunitiesRepository>(
        () => CommunitiesRepository(sl<CommunitiesServiceInterface>()),
      )
      ..registerLazySingleton<AssistantServiceInterface>(
        AssistantMockService.new,
      )
      ..registerLazySingleton<AssistantRepository>(
        () => AssistantRepository(sl<AssistantServiceInterface>()),
      )
      ..registerLazySingleton<AgendaServiceInterface>(
        AgendaMockService.new,
      )
      ..registerLazySingleton<AgendaRepository>(
        () => AgendaRepository(sl<AgendaServiceInterface>()),
      )
      ..registerLazySingleton<AiTrainingServiceInterface>(
        AiTrainingMockService.new,
      )
      ..registerLazySingleton<AiTrainingRepository>(
        () => AiTrainingRepository(sl<AiTrainingServiceInterface>()),
      )
      ..registerLazySingleton<CheckinServiceInterface>(
        CheckinMockService.new,
      )
      ..registerLazySingleton<CheckinRepository>(
        () => CheckinRepository(sl<CheckinServiceInterface>()),
      )
      ..registerLazySingleton<BookingServiceInterface>(
        BookingMockService.new,
      )
      ..registerLazySingleton<BookingRepository>(
        () => BookingRepository(sl<BookingServiceInterface>()),
      )
      ..registerLazySingleton<FeedServiceInterface>(FeedMockService.new)
      ..registerLazySingleton<FeedRepository>(
        () => FeedRepository(sl<FeedServiceInterface>()),
      )
      ..registerLazySingleton<HomeServiceInterface>(HomeMockService.new)
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepository(sl<HomeServiceInterface>()),
      )
      ..registerLazySingleton<LessonsServiceInterface>(
        LessonsMockService.new,
      )
      ..registerLazySingleton<LessonsRepository>(
        () => LessonsRepository(sl<LessonsServiceInterface>()),
      )
      ..registerLazySingleton<NotificationsServiceInterface>(
        NotificationsMockService.new,
      )
      ..registerLazySingleton<NotificationsRepository>(
        () => NotificationsRepository(sl<NotificationsServiceInterface>()),
      )
      ..registerLazySingleton<ProfileServiceInterface>(
        ProfileMockService.new,
      )
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepository(sl<ProfileServiceInterface>()),
      )
      ..registerLazySingleton<RankingServiceInterface>(
        RankingMockService.new,
      )
      ..registerLazySingleton<RankingRepository>(
        () => RankingRepository(sl<RankingServiceInterface>()),
      )
      ..registerLazySingleton<ProgressServiceInterface>(
        ProgressMockService.new,
      )
      ..registerLazySingleton<ProgressRepository>(
        () => ProgressRepository(sl<ProgressServiceInterface>()),
      )
      ..registerLazySingleton<AuthServiceInterface>(
        AuthMockService.new,
      )
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepository(sl<AuthServiceInterface>()),
      );
  }

  static Future<void> reset() async {
    await sl.reset();
  }
}
