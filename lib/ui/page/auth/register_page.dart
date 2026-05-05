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
import '../../components/app_primary_button.dart';
import '../../components/app_sliver_scaffold.dart';
import '../../components/content_state_view.dart';
import '../../theme/app_theme.dart';
import 'widgets/auth_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _termsAccepted = false;
  bool _termsTouched = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.register.title ?? '',
      fallbackRoute: Routes.login,
      slivers: [
        SliverToBoxAdapter(
          child: ContentStateView(
            isLoading: provider.isLoading && overview == null,
            errorMessage: provider.errorMessage != null && overview == null
                ? provider.errorMessage
                : null,
            onRetry: provider.loadOverview,
            retryLabel: sl<AppConstants>().retryLabel,
            child: overview == null
                ? const SizedBox.shrink()
                : _buildForm(context, overview, provider),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(
    BuildContext context,
    AuthOverview overview,
    AuthProvider provider,
  ) {
    final validators = AuthFormValidators(overview.validation);
    final isSubmitting =
        provider.registerStatus == AuthSubmissionStatus.submitting;
    final termsError = _termsTouched && !_termsAccepted
        ? overview.validation.termsRequired
        : null;

    return AutofillGroup(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                overview.register.subtitle,
                style: AppTextStyles.bodyLargeSecondary(context),
              ),
              const SizedBox(height: AppSpacing.sectionLg),
              AuthTextField(
                controller: _nameController,
                label: overview.register.nameLabel,
                hint: overview.register.namePlaceholder,
                icon: Icons.person_outline_rounded,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                enabled: !isSubmitting,
                validator: validators.validateName,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                controller: _emailController,
                label: overview.register.emailLabel,
                hint: overview.register.emailPlaceholder,
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
                label: overview.register.passwordLabel,
                hint: overview.register.passwordPlaceholder,
                icon: Icons.lock_outline_rounded,
                obscureText: true,
                allowVisibilityToggle: true,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                enabled: !isSubmitting,
                validator: validators.validatePassword,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                controller: _confirmController,
                label: overview.register.confirmPasswordLabel,
                hint: overview.register.confirmPasswordPlaceholder,
                icon: Icons.lock_outline_rounded,
                obscureText: true,
                allowVisibilityToggle: true,
                textInputAction: TextInputAction.done,
                enabled: !isSubmitting,
                validator: (value) => validators.validatePasswordMatch(
                  value,
                  _passwordController.text,
                ),
                onSubmitted: (_) => _submit(context, overview, provider),
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTermsCheckbox(
                label: overview.register.termsLabel,
                value: _termsAccepted,
                errorMessage: termsError,
                onChanged: isSubmitting
                    ? (_) {}
                    : (value) {
                        setState(() {
                          _termsAccepted = value;
                          _termsTouched = true;
                        });
                      },
              ),
              const SizedBox(height: AppSpacing.section),
              AppPrimaryButton(
                label: overview.register.submitLabel,
                isLoading: isSubmitting,
                onPressed: () => _submit(context, overview, provider),
              ),
              const SizedBox(height: AppSpacing.section),
              AppFooterPrompt(
                prompt: overview.register.loginPromptLabel,
                actionLabel: overview.register.loginActionLabel,
                onActionTap: isSubmitting
                    ? () {}
                    : () {
                        if (context.canPop()) {
                          context.pop();
                          return;
                        }
                        context.go(Routes.login);
                      },
              ),
            ],
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
    if (provider.registerStatus == AuthSubmissionStatus.submitting) return;
    final form = _formKey.currentState;
    setState(() => _termsTouched = true);
    if (form == null || !form.validate() || !_termsAccepted) {
      return;
    }

    final ok = await provider.submitRegister(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (ok) {
      _showSnack(context, overview.messages.registerSuccessMessage);
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
