import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/auth_social_provider.dart';
import '../../../theme/app_theme.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({
    super.key,
    required this.brandName,
    required this.tagline,
  });

  final String brandName;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppSize.authBrandLogo,
          height: AppSize.authBrandLogo,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppPalette.primary, AppPalette.primaryStrong],
            ),
            boxShadow: [
              BoxShadow(
                color: AppPalette.primary.withValues(alpha: AppOpacity.quarter),
                blurRadius: AppShadow.cardBlur,
                offset: const Offset(0, AppShadow.cardOffsetY),
              ),
            ],
          ),
          child: const Image.asset(
            AppAssets.logoGalacticos,
            height: AppSize.authBrandLogo,
          ),
        ),
        const SizedBox(height: AppSpacing.giant),
        Text(
          brandName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: AppLetterSpacing.tightLg,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          tagline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppPalette.textSecondary,
            fontSize: AppFontSize.bodyLg,
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.allowVisibilityToggle = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.validator,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool obscureText;
  final bool allowVisibilityToggle;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final AutovalidateMode autovalidateMode;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscured = true;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppPalette.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.labelLg,
            letterSpacing: AppLetterSpacing.wideSm,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscured && widget.obscureText,
          autofillHints: widget.autofillHints,
          enabled: widget.enabled,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onSubmitted,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppPalette.white,
            fontSize: AppFontSize.titleSm,
          ),
          cursorColor: AppPalette.primary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppPalette.textHint,
              fontSize: AppFontSize.titleSm,
            ),
            filled: true,
            fillColor: AppPalette.surfaceAlt,
            isDense: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.giant,
              vertical: AppSpacing.xl,
            ),
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.xl,
                      right: AppSpacing.md,
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppPalette.textHint,
                      size: AppIconSize.lg,
                    ),
                  ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: widget.allowVisibilityToggle
                ? IconButton(
                    onPressed: () => setState(() => _obscured = !_obscured),
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppPalette.textHint,
                      size: AppIconSize.lg,
                    ),
                    splashRadius: AppIconSize.giant,
                  )
                : null,
            border: _border(AppPalette.white.withValues(alpha: AppOpacity.xxs)),
            enabledBorder: _border(
              AppPalette.white.withValues(alpha: AppOpacity.xxs),
            ),
            focusedBorder: _border(AppPalette.primary, width: AppStroke.thick),
            errorBorder: _border(AppPalette.danger),
            focusedErrorBorder: _border(
              AppPalette.danger,
              width: AppStroke.thick,
            ),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppPalette.danger,
              fontSize: AppFontSize.labelLg,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = AppStroke.hairline}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppPalette.black,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFontSize.titleLg,
                ),
              ),
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final lineColor = AppPalette.white.withValues(alpha: AppOpacity.xxs);

    return Row(
      children: [
        Expanded(
          child: Divider(color: lineColor, height: AppStroke.hairline),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppPalette.textHint,
              fontWeight: FontWeight.w500,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: lineColor, height: AppStroke.hairline),
        ),
      ],
    );
  }
}

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.provider,
    required this.onTap,
  });

  final AuthSocialProvider provider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.buttonHeight,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          _iconFor(provider.icon),
          size: AppIconSize.lg,
          color: AppPalette.white,
        ),
        label: Text(
          provider.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppPalette.white,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.titleSm,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppPalette.surfaceAlt,
          side: BorderSide(
            color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            width: AppStroke.hairline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'google':
        return Icons.g_mobiledata_rounded;
      case 'apple':
        return Icons.apple_rounded;
      case 'facebook':
        return Icons.facebook_rounded;
      default:
        return Icons.login_rounded;
    }
  }
}

class AuthFooterPrompt extends StatelessWidget {
  const AuthFooterPrompt({
    super.key,
    required this.prompt,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          Text(
            prompt,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppPalette.textSecondary,
              fontSize: AppFontSize.bodyLg,
            ),
          ),
          GestureDetector(
            onTap: onActionTap,
            behavior: HitTestBehavior.opaque,
            child: Text(
              actionLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppPalette.primary,
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.bodyLg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthTermsCheckbox extends StatelessWidget {
  const AuthTermsCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.errorMessage,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final error = errorMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppIconSize.xxxl,
                  height: AppIconSize.xxxl,
                  margin: const EdgeInsets.only(top: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: value ? AppPalette.primary : AppPalette.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: value
                          ? AppPalette.primary
                          : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                      width: AppStroke.hairline,
                    ),
                  ),
                  child: value
                      ? const Icon(
                          Icons.check_rounded,
                          size: AppIconSize.md,
                          color: AppPalette.black,
                        )
                      : null,
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppPalette.textSecondary,
                      fontSize: AppFontSize.bodyLg,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.giant),
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppPalette.danger,
                fontSize: AppFontSize.labelLg,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
