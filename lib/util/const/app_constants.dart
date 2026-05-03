import 'environment/environment.dart';

class AppConstants {
  const AppConstants({
    required this.appName,
    required this.appVersion,
    required this.appTitle,
    required this.appDescription,
    required this.authBaseUrl,
    required this.coreApiBaseUrl,
    required this.homeLoadErrorMessage,
    required this.feedLoadErrorMessage,
    required this.communitiesLoadErrorMessage,
    required this.notificationsLoadErrorMessage,
    required this.profileLoadErrorMessage,
    required this.navigationUnavailableMessage,
    required this.retryLabel,
  });

  final String appName;
  final String appVersion;
  final String appTitle;
  final String appDescription;
  final String authBaseUrl;
  final String coreApiBaseUrl;
  final String homeLoadErrorMessage;
  final String feedLoadErrorMessage;
  final String communitiesLoadErrorMessage;
  final String notificationsLoadErrorMessage;
  final String profileLoadErrorMessage;
  final String navigationUnavailableMessage;
  final String retryLabel;

  static const instance = AppConstants(
    appName: Environment.appName,
    appVersion: Environment.appVersion,
    appTitle: Environment.appTitle,
    appDescription: Environment.appDescription,
    authBaseUrl: Environment.authBaseUrl,
    coreApiBaseUrl: Environment.coreApiBaseUrl,
    homeLoadErrorMessage: 'Não foi possível carregar o dashboard agora.',
    feedLoadErrorMessage: 'Não foi possível carregar o feed agora.',
    communitiesLoadErrorMessage: 'Não foi possível carregar os clubes agora.',
    notificationsLoadErrorMessage: 'Não foi possível carregar as notificações agora.',
    profileLoadErrorMessage: 'Não foi possível carregar o perfil agora.',
    navigationUnavailableMessage: 'Área disponível na próxima etapa.',
    retryLabel: 'Tentar novamente',
  );
}
