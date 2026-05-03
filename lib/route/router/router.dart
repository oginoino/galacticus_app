import 'package:go_router/go_router.dart';

import '../../ui/page/feed/feed_page.dart';
import '../../ui/page/home/home_page.dart';
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
  ],
);
