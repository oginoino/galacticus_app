import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../di/di.dart';
import '../repository/communities_repository.dart';
import '../repository/feed_repository.dart';
import '../repository/home_repository.dart';
import '../repository/notifications_repository.dart';
import '../repository/profile_repository.dart';
import '../service/localization/localization_service.dart';
import '../service/persistence/persistence_service.dart';
import 'communities_provider.dart';
import 'feed_provider.dart';
import 'home_provider.dart';
import 'locale_provider.dart';
import 'notifications_provider.dart';
import 'profile_provider.dart';
import 'theme_provider.dart';

final List<SingleChildWidget> registerProviders = [
  ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(
      sl<PersistenceService>(),
    ),
  ),
  ChangeNotifierProvider<LocaleProvider>(
    create: (_) => LocaleProvider(
      sl<PersistenceService>(),
      sl<LocalizationService>(),
    ),
  ),
  ChangeNotifierProvider<HomeProvider>(
    create: (_) => HomeProvider(
      sl<HomeRepository>(),
    )..loadDashboard(),
  ),
  ChangeNotifierProvider<FeedProvider>(
    create: (_) => FeedProvider(
      sl<FeedRepository>(),
    )..loadFeed(),
  ),
  ChangeNotifierProvider<CommunitiesProvider>(
    create: (_) => CommunitiesProvider(
      sl<CommunitiesRepository>(),
    )..loadCommunities(),
  ),
  ChangeNotifierProvider<NotificationsProvider>(
    create: (_) => NotificationsProvider(
      sl<NotificationsRepository>(),
    )..loadNotifications(),
  ),
  ChangeNotifierProvider<ProfileProvider>(
    create: (_) => ProfileProvider(
      sl<ProfileRepository>(),
    )..loadProfile(),
  ),
];
