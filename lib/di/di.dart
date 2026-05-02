import 'package:get_it/get_it.dart';

import '../repository/home_repository.dart';
import '../service/api/api_service_factory.dart';
import '../service/home/home_mock_service.dart';
import '../service/home/home_service_interface.dart';
import '../service/http/http_service.dart';
import '../service/http/http_service_interface.dart';
import '../service/localization/localization_service.dart';
import '../service/persistence/persistence_service.dart';
import '../util/const/app_constants.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> register() async {
    if (sl.isRegistered<AppConstants>()) {
      return;
    }

    final persistenceService = PersistenceService();
    await persistenceService.init();

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
      ..registerLazySingleton<HomeServiceInterface>(HomeMockService.new)
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepository(sl<HomeServiceInterface>()),
      );
  }

  static Future<void> reset() async {
    await sl.reset();
  }
}
