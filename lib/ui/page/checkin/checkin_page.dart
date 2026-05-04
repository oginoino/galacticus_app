import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../provider/checkin_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/checkin_camera_view.dart';

class CheckinPage extends StatelessWidget {
  const CheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckinProvider>();
    final overview = provider.overview;

    return Scaffold(
      backgroundColor: AppPalette.black,
      body: ContentStateView(
        isLoading: provider.isLoading && overview == null,
        errorMessage:
            provider.errorMessage != null && overview == null ? provider.errorMessage : null,
        onRetry: provider.loadCheckin,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : CheckinCameraView(
                overview: overview,
                onBackTap: () {
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }

                  context.go(Routes.home);
                },
                onMessage: (message) => _showSnack(context, message),
              ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
