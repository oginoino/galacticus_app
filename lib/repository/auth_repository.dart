import '../domain/auth_overview.dart';
import '../dto/auth_dto.dart';
import '../service/auth/auth_service_interface.dart';

class AuthRepository {
  AuthRepository(this._service);

  final AuthServiceInterface _service;

  Future<AuthOverview> getOverview() async {
    final json = await _service.fetchOverview();
    return AuthDto.fromJson(json).toDomain();
  }

  Future<void> submitLogin({
    required String email,
    required String password,
  }) {
    return _service.submitLogin(email: email, password: password);
  }

  Future<void> submitRegister({
    required String name,
    required String email,
    required String password,
  }) {
    return _service.submitRegister(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<void> submitPasswordRecovery({required String email}) {
    return _service.submitPasswordRecovery(email: email);
  }
}
