import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/auth_social_provider.dart';
import '../../../../util/const/app_assets.dart';
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
        Image.asset(
          AppAssets.logoGalacticos,
          width: AppSize.authBrandLogo,
          height: AppSize.authBrandLogo,
        ),
        const SizedBox(height: AppSpacing.giant),
        Text(
          brandName,
          textAlign: TextAlign.center,
          style: AppTextStyles.brandTitle(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          tagline,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMediumSecondary(context),
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
          style: AppTextStyles.formLabel(context),
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
          style: AppTextStyles.inputText(context),
          cursorColor: AppPalette.primary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.inputHint(context),
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
            errorStyle: AppTextStyles.errorText(context),
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
          style: AppTextStyles.buttonSocial(context),
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
                    style: AppTextStyles.bodyMediumSecondary(context),
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
              style: AppTextStyles.errorText(context),
            ),
          ),
        ],
      ],
    );
  }
}
