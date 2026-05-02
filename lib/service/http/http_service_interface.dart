import 'http_request.dart';
import 'http_response.dart';

abstract interface class HttpServiceInterface {
  Future<HttpResponse> get(HttpRequest request);

  Future<HttpResponse> post(HttpRequest request);
}
