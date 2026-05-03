import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../provider/assistant_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/content_state_view.dart';
import 'widgets/assistant_content.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AssistantProvider>();
    final overview = provider.overview;

    return Scaffold(
      body: ContentStateView(
        isLoading: provider.isLoading && overview == null,
        errorMessage:
            provider.errorMessage != null && overview == null ? provider.errorMessage : null,
        onRetry: provider.loadAssistant,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : AssistantContent(
                overview: overview,
                onBackTap: () {
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }

                  context.go(Routes.home);
                },
                onPromptTap: () =>
                    _showSnack(context, overview.messages.promptAction),
                onSendTap: () =>
                    _showSnack(context, overview.messages.sendAction),
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
