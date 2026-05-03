import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../repository/communities_repository.dart';
import '../repository/feed_repository.dart';
import '../repository/home_repository.dart';
import '../repository/profile_repository.dart';
import '../service/api/api_service_factory.dart';
import '../service/communities/communities_mock_service.dart';
import '../service/communities/communities_service_interface.dart';
import '../service/feed/feed_mock_service.dart';
import '../service/feed/feed_service_interface.dart';
import '../service/home/home_mock_service.dart';
import '../service/home/home_service_interface.dart';
import '../service/http/http_service.dart';
import '../service/http/http_service_interface.dart';
import '../service/localization/localization_service.dart';
import '../service/persistence/persistence_service.dart';
import '../service/profile/profile_mock_service.dart';
import '../service/profile/profile_service_interface.dart';
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
      ..registerLazySingleton<FeedServiceInterface>(FeedMockService.new)
      ..registerLazySingleton<FeedRepository>(
        () => FeedRepository(sl<FeedServiceInterface>()),
      )
      ..registerLazySingleton<HomeServiceInterface>(HomeMockService.new)
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepository(sl<HomeServiceInterface>()),
      )
      ..registerLazySingleton<ProfileServiceInterface>(
        ProfileMockService.new,
      )
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepository(sl<ProfileServiceInterface>()),
      );
  }

  static Future<void> reset() async {
    await sl.reset();
  }
}
