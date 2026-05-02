abstract final class Environment {
  static const appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Galácticos Club',
  );
  static const appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );
  static const appTitle = String.fromEnvironment(
    'APP_TITLE',
    defaultValue: 'Galácticos Club',
  );
  static const appDescription = String.fromEnvironment(
    'APP_DESCRIPTION',
    defaultValue: 'Social sports hub com reservas, ranking e comunidade.',
  );
  static const authBaseUrl = String.fromEnvironment(
    'AUTH_BASE_URL',
    defaultValue: 'https://auth.example.com',
  );
  static const coreApiBaseUrl = String.fromEnvironment(
    'CORE_API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );
}
