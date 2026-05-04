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
    required this.bookingLoadErrorMessage,
    required this.assistantLoadErrorMessage,
    required this.checkinLoadErrorMessage,
    required this.lessonsLoadErrorMessage,
    required this.agendaLoadErrorMessage,
    required this.aiTrainingLoadErrorMessage,
    required this.profileLoadErrorMessage,
    required this.rankingLoadErrorMessage,
    required this.progressLoadErrorMessage,
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
  final String bookingLoadErrorMessage;
  final String assistantLoadErrorMessage;
  final String checkinLoadErrorMessage;
  final String lessonsLoadErrorMessage;
  final String agendaLoadErrorMessage;
  final String aiTrainingLoadErrorMessage;
  final String profileLoadErrorMessage;
  final String rankingLoadErrorMessage;
  final String progressLoadErrorMessage;
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
    bookingLoadErrorMessage: 'Não foi possível carregar a reserva agora.',
    assistantLoadErrorMessage: 'Não foi possível carregar o assistente agora.',
    checkinLoadErrorMessage: 'Não foi possível carregar o check-in agora.',
    lessonsLoadErrorMessage: 'Não foi possível carregar as aulas agora.',
    agendaLoadErrorMessage: 'Não foi possível carregar as agendas agora.',
    aiTrainingLoadErrorMessage: 'Não foi possível carregar o treino com IA agora.',
    profileLoadErrorMessage: 'Não foi possível carregar o perfil agora.',
    rankingLoadErrorMessage: 'Não foi possível carregar o ranking agora.',
    progressLoadErrorMessage: 'Não foi possível carregar o progresso agora.',
    navigationUnavailableMessage: 'Área disponível na próxima etapa.',
    retryLabel: 'Tentar novamente',
  );
}
