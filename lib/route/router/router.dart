import 'package:go_router/go_router.dart';

import '../../ui/page/booking/booking_page.dart';
import '../../ui/page/communities/communities_page.dart';
import '../../ui/page/feed/feed_page.dart';
import '../../ui/page/home/home_page.dart';
import '../../ui/page/notifications/notifications_page.dart';
import '../../ui/page/profile/profile_page.dart';
import '../app_route.dart';
import '../handle/handle_redirect.dart';
import '../routes/routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home,
  redirect: HandleRedirect.redirect,
  routes: [
    AppRoute(
      name: RouteNames.home,
      path: Routes.home,
      builder: (_, __) => const HomePage(),
    ).toGoRoute(),
    AppRoute(
      name: RouteNames.feed,
      path: Routes.feed,
      builder: (_, __) => const FeedPage(),
    ).toGoRoute(),
    AppRoute(
      name: RouteNames.booking,
      path: Routes.booking,
      builder: (_, __) => const BookingPage(),
    ).toGoRoute(),
    AppRoute(
      name: RouteNames.communities,
      path: Routes.communities,
      builder: (_, __) => const CommunitiesPage(),
    ).toGoRoute(),
    AppRoute(
      name: RouteNames.notifications,
      path: Routes.notifications,
      builder: (_, __) => const NotificationsPage(),
    ).toGoRoute(),
    AppRoute(
      name: RouteNames.profile,
      path: Routes.profile,
      builder: (_, __) => const ProfilePage(),
    ).toGoRoute(),
  ],
);
