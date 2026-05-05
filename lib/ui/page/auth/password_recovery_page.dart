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

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final overview = provider.overview;

    return AppSliverScaffold(
      title: overview?.passwordRecovery.title ?? '',
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
        provider.recoveryStatus == AuthSubmissionStatus.submitting;

    return AutofillGroup(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                overview.passwordRecovery.subtitle,
                style: AppTextStyles.bodyLargeSecondary(context),
              ),
              const SizedBox(height: AppSpacing.sectionLg),
              AuthTextField(
                controller: _emailController,
                label: overview.passwordRecovery.emailLabel,
                hint: overview.passwordRecovery.emailPlaceholder,
                icon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                enabled: !isSubmitting,
                validator: validators.validateEmail,
                onSubmitted: (_) => _submit(context, overview, provider),
              ),
              const SizedBox(height: AppSpacing.section),
              AppPrimaryButton(
                label: overview.passwordRecovery.submitLabel,
                isLoading: isSubmitting,
                onPressed: () => _submit(context, overview, provider),
              ),
              const SizedBox(height: AppSpacing.section),
              AppFooterPrompt(
                prompt: overview.passwordRecovery.loginPromptLabel,
                actionLabel: overview.passwordRecovery.loginActionLabel,
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
    if (provider.recoveryStatus == AuthSubmissionStatus.submitting) return;
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final ok = await provider.submitPasswordRecovery(
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    if (ok) {
      _showSnack(context, overview.messages.recoverySuccessMessage);
      provider.resetSubmissionStatus();
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(Routes.login);
      }
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
