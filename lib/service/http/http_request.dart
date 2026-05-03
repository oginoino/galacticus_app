class HttpRequest {
  const HttpRequest({
    required this.path,
    this.headers = const {},
    this.queryParameters = const {},
    this.body,
    this.timeout = const Duration(seconds: 20),
  });

  final String path;
  final Map<String, String> headers;
  final Map<String, dynamic> queryParameters;
  final Object? body;
  final Duration timeout;
}
