import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/portfolio_data.dart';

/// ─────────────────────────────────────────────────────────────
/// ContactForm — name / email / message → mailto link.
/// (Replace with a real API endpoint like Formspree for prod.)
/// ─────────────────────────────────────────────────────────────
class ContactForm extends StatefulWidget {
  const ContactForm({super.key, required this.isDark});
  final bool isDark;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl     = TextEditingController();

  bool _sending = false;
  bool _sent    = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _sending = true);

    // Compose mailto body (works without a backend on Flutter Web)
    final body = '''
Name: ${_nameCtrl.text}
Email: ${_emailCtrl.text}

${_msgCtrl.text}
''';

    await UrlLauncherUtils.sendEmail(
      PortfolioData.email,
      subject: _subjectCtrl.text.isNotEmpty
          ? _subjectCtrl.text
          : 'Portfolio Contact — ${_nameCtrl.text}',
      body: body,
    );

    setState(() {
      _sending = false;
      _sent    = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) return _SuccessState(isDark: widget.isDark);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: AppTypography.h5.copyWith(
              color: widget.isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 24),

          // Name + Email side-by-side on wider screens
          LayoutBuilder(builder: (_, constraints) {
            final wide = constraints.maxWidth > 420;
            final nameField = _Field(
              controller: _nameCtrl,
              label: 'Your Name',
              hint: 'John Doe',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name required' : null,
            );
            final emailField = _Field(
              controller: _emailCtrl,
              label: 'Your Email',
              hint: 'john@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            );

            if (wide) {
              return Row(
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 14),
                  Expanded(child: emailField),
                ],
              );
            }
            return Column(children: [nameField, const SizedBox(height: 14), emailField]);
          }),

          const SizedBox(height: 14),

          _Field(
            controller: _subjectCtrl,
            label: 'Subject',
            hint: 'Project inquiry, collaboration…',
          ),

          const SizedBox(height: 14),

          _Field(
            controller: _msgCtrl,
            label: 'Message',
            hint: 'Tell me about your project or idea…',
            maxLines: 5,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Message required' : null,
          ),

          const SizedBox(height: 24),

          CustomButton(
            label: _sending ? 'Opening email client…' : 'Send Message',
            icon: Icons.send_rounded,
            variant: BtnVariant.primary,
            fullWidth: true,
            isLoading: _sending,
            onPressed: _submit,
          ),

          const SizedBox(height: 12),
          Text(
            'This will open your default email client.',
            style: AppTypography.caption.copyWith(
              color: widget.isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable form field ──────────────────────────────────────
class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }
}

// ── Success state ────────────────────────────────────────────
class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.emerald.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.emerald.withOpacity(0.22)),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline_rounded,
              size: 48, color: AppColors.emerald),
          const SizedBox(height: 16),
          Text(
            'Email client opened!',
            style: AppTypography.h5.copyWith(
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Complete sending from your email app.',
            style: AppTypography.bodySm.copyWith(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
