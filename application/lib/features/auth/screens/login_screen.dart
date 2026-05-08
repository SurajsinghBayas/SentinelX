// ============================================================
// SentinelX — Login Screen
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/sx_button.dart';
import '../../../shared/widgets/sx_text_field.dart';
import '../../../shared/widgets/sx_snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authProvider.notifier)
        .login(_emailCtrl.text.trim(), _passwordCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (prev, next) {
      if (next.status == AuthStatus.error && next.error != null) {
        SxSnackbar.showError(context, next.error!);
        ref.read(authProvider.notifier).clearError();
      }
    });

    final isLoading =
        ref.watch(authProvider).status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(60),
              // Logo
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      color: AppTheme.primary,
                      size: 28,
                    ),
                  ),
                  const Gap(12),
                  const Text(
                    'SentinelX',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms),
              const Gap(48),
              const Text(
                'Welcome back',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ).animate(delay: 100.ms).fadeIn().slideX(begin: -0.1),
              const Gap(6),
              const Text(
                'Sign in to your security console',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 15,
                ),
              ).animate(delay: 150.ms).fadeIn(),
              const Gap(40),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SxTextField(
                      controller: _emailCtrl,
                      label: 'Email',
                      hint: 'operator@example.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                    const Gap(16),
                    SxTextField(
                      controller: _passwordCtrl,
                      label: 'Password',
                      hint: '••••••••',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password is required';
                        return null;
                      },
                    ).animate(delay: 250.ms).fadeIn().slideY(begin: 0.1),
                    const Gap(32),
                    SxButton(
                      label: 'Sign In',
                      isLoading: isLoading,
                      onPressed: _login,
                      icon: Icons.login_rounded,
                    ).animate(delay: 300.ms).fadeIn(),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.register),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ).animate(delay: 350.ms).fadeIn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
