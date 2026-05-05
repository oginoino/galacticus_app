import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = isLoading || onPressed == null;

    return SizedBox(
      height: AppSize.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primary,
          disabledBackgroundColor: AppPalette.primary.withValues(
            alpha: AppOpacity.half,
          ),
          foregroundColor: AppPalette.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: AppIconSize.lg,
                height: AppIconSize.lg,
                child: CircularProgressIndicator(
                  strokeWidth: AppStroke.thick,
                  color: AppPalette.black,
                ),
              )
            : Text(
                label,
                style: AppTextStyles.buttonPrimary(context),
              ),
      ),
    );
  }
}
