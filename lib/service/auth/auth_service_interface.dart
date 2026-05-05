abstract interface class AuthServiceInterface {
  Future<Map<String, dynamic>> fetchOverview();

  Future<void> submitLogin({
    required String email,
    required String password,
  });

  Future<void> submitRegister({
    required String name,
    required String email,
    required String password,
  });

  Future<void> submitPasswordRecovery({required String email});
}
