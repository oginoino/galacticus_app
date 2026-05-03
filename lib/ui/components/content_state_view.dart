import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ContentStateView extends StatelessWidget {
  const ContentStateView({
    super.key,
    required this.isLoading,
    required this.child,
    this.errorMessage,
    this.onRetry,
    this.retryLabel,
  });

  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xxxl),
                FilledButton(
                  onPressed: onRetry,
                  child: Text(retryLabel ?? ''),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return child;
  }
}
