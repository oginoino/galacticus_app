import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef AppRouteWidgetBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

class AppRoute {
  const AppRoute({
    required this.name,
    required this.path,
    required this.builder,
  });

  final String name;
  final String path;
  final AppRouteWidgetBuilder builder;

  GoRoute toGoRoute() {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: builder(context, state),
        );
      },
    );
  }
}
