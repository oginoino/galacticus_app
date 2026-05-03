import 'http_request.dart';
import 'http_response.dart';
import 'http_service_interface.dart';
import 'http_status.dart';

class HttpService implements HttpServiceInterface {
  @override
  Future<HttpResponse> get(HttpRequest request) async {
    return const HttpResponse(
      statusCode: HttpStatus.notImplemented,
      body: {
        'message': 'Camada HTTP pronta para integração futura.',
      },
    );
  }

  @override
  Future<HttpResponse> post(HttpRequest request) async {
    return const HttpResponse(
      statusCode: HttpStatus.notImplemented,
      body: {
        'message': 'Camada HTTP pronta para integração futura.',
      },
    );
  }
}
