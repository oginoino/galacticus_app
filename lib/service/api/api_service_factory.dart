import '../http/http_service_interface.dart';

class ApiServiceFactory {
  ApiServiceFactory(this._httpService);

  final HttpServiceInterface _httpService;

  HttpServiceInterface createPublicService() => _httpService;

  HttpServiceInterface createAuthenticatedService() => _httpService;

  HttpServiceInterface createAuthService() => _httpService;
}
