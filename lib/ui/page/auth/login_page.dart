import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di/di.dart';
import '../../../domain/auth_overview.dart';
import '../../../provider/auth_form_validators.dart';
import '../../../provider/auth_provider.dart';
import '../../../route/routes/routes.dart';
import '../../../util/const/app_constants.dart';
import '../../components/app_footer_prompt.dart';
import '../../components/app_labeled_divider.dart';
import '../../components/app_primary_button.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final overview = provider.overview;

    return Scaffold(
      backgroundColor: AppPalette.background,
      body: ContentStateView(
        isLoading: provider.isLoading && overview == null,
        errorMessage:
            provider.errorMessage != null && overview == null ? provider.errorMessage : null,
        onRetry: provider.loadOverview,
        retryLabel: sl<AppConstants>().retryLabel,
        child: overview == null
            ? const SizedBox.shrink()
            : _buildForm(context, overview, provider),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    AuthOverview overview,
    AuthProvider provider,
  ) {
    final validators = AuthFormValidators(overview.validation);
    final isSubmitting =
        provider.loginStatus == AuthSubmissionStatus.submitting;

    return SafeArea(
      child: AutofillGroup(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.page,
            vertical: AppSpacing.section,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.section),
                AuthBrandHeader(
                  brandName: overview.brandName,
                  tagline: overview.brandTagline,
                ),
                const SizedBox(height: AppSpacing.section),
                Text(
                  overview.login.title,
                  style: AppTextStyles.heading(context),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  overview.login.subtitle,
                  style: AppTextStyles.bodyLargeSecondary(context),
                ),
                const SizedBox(height: AppSpacing.sectionLg),
                AuthTextField(
                  controller: _emailController,
                  label: overview.login.emailLabel,
                  hint: overview.login.emailPlaceholder,
                  icon: Icons.alternate_email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  enabled: !isSubmitting,
                  validator: validators.validateEmail,
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthTextField(
                  controller: _passwordController,
                  label: overview.login.passwordLabel,
                  hint: overview.login.passwordPlaceholder,
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  allowVisibilityToggle: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  enabled: !isSubmitting,
                  validator: (value) =>
                      validators.validatePassword(value, checkLength: false),
                  onSubmitted: (_) => _submit(context, overview, provider),
                ),
                const SizedBox(height: AppSpacing.md),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () => context.push(Routes.passwordRecovery),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                    ),
                    child: Text(
                      overview.login.forgotLabel,
                      style: AppTextStyles.linkSecondary(context),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppPrimaryButton(
                  label: overview.login.submitLabel,
                  isLoading: isSubmitting,
                  onPressed: () => _submit(context, overview, provider),
                ),
                const SizedBox(height: AppSpacing.sectionLg),
                AppLabeledDivider(label: overview.login.socialDividerLabel),
                const SizedBox(height: AppSpacing.lg),
                ...overview.socialProviders.map(
                  (item) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AuthSocialButton(
                      provider: item,
                      onTap: isSubmitting
                          ? () {}
                          : () => _showSnack(
                                context,
                                overview.messages.socialAction,
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.section),
                AppFooterPrompt(
                  prompt: overview.login.registerPromptLabel,
                  actionLabel: overview.login.registerActionLabel,
                  onActionTap: isSubmitting
                      ? () {}
                      : () => context.push(Routes.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
    AuthOverview overview,
    AuthProvider provider,
  ) async {
    if (provider.loginStatus == AuthSubmissionStatus.submitting) return;
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final ok = await provider.submitLogin(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (ok) {
      _showSnack(context, overview.messages.loginSuccessMessage);
      provider.resetSubmissionStatus();
      context.go(Routes.home);
    } else {
      _showSnack(context, overview.messages.submitErrorMessage);
      provider.resetSubmissionStatus();
    }
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
