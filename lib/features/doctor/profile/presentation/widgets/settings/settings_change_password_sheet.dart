import 'package:flutter/material.dart';
import 'package:rojeta_doctor/core/utils/extensions/context_extensions.dart';
import 'package:rojeta_doctor/shared/widgets/custom_elevated_button.dart';
import 'package:rojeta_doctor/shared/widgets/custom_textfield.dart';

class SettingsChangePasswordSheet extends StatefulWidget {
  const SettingsChangePasswordSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsChangePasswordSheet(),
    );
  }

  @override
  State<SettingsChangePasswordSheet> createState() =>
      _SettingsChangePasswordSheetState();
}

class _SettingsChangePasswordSheetState
    extends State<SettingsChangePasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.strings.scheduleSavedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.strings.changePassword,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _currentPasswordController,
                  label: context.strings.password,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return context.strings.invalidPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _newPasswordController,
                  label: context.strings.newPassword,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.length < 6) {
                      return context.strings.invalidPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: context.strings.confirmPassword,
                  obscureText: true,
                  validator: (val) {
                    if (val != _newPasswordController.text) {
                      return context.strings.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  text: context.strings.save,
                  isLoading: _isLoading,
                  onPressed: _handleSubmit,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
