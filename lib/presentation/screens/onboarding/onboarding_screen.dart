import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/presentation/providers/profile_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  String _firstName = '';
  String _lastName = '';
  bool _isFinishing = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) return;
    setState(() => _isFinishing = true);

    try {
      await ref.read(profileProvider.notifier).setProfile(
        firstName: _firstName,
        lastName: _lastName,
      );
      await ref.read(profileProvider.notifier).completeOnboarding();
    } catch (e) {
      debugPrint('Onboarding finish error: $e');
    }

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _WelcomePage(onNext: _nextPage),
              _ProfilePage(
                firstName: _firstName,
                lastName: _lastName,
                onFirstNameChanged: (value) => _firstName = value,
                onLastNameChanged: (value) => _lastName = value,
                onNext: _nextPage,
              ),
              _DonePage(
                firstName: _firstName,
                onFinish: _finishOnboarding,
                isLoading: _isFinishing,
              ),
            ],
          ),
          // Page indicator and navigation
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: _currentPage == index
                            ? context.colorScheme.primary
                            : context.colorScheme.outline.withAlpha(128),
                      ),
                    ),
                  ),
                ).animate(target: _currentPage.toDouble())
                  .fadeIn(duration: 300.ms),
                const SizedBox(height: 16),
                // Back button
                if (_currentPage > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: _previousPage,
                      child: Text(context.l10n.commonCancel),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const _WelcomePage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.spa,
                size: 120,
                color: context.colorScheme.primary,
              )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.8, 0.8), duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 32),
              Text(
                context.l10n.onboardingWelcomeTitle,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                context.l10n.onboardingWelcomeSubtitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: onNext,
                child: Text(context.l10n.onboardingStart),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final Function(String) onFirstNameChanged;
  final Function(String) onLastNameChanged;
  final VoidCallback onNext;

  const _ProfilePage({
    required this.firstName,
    required this.lastName,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onNext,
  });

  @override
  State<_ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<_ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      widget.onFirstNameChanged(_firstNameController.text);
      widget.onLastNameChanged(_lastNameController.text);
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.onboardingProfileTitle,
                  style: context.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: context.l10n.onboardingProfileFirstName,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.l10n.onboardingFirstNameRequired;
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: context.l10n.onboardingProfileLastName,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.l10n.onboardingLastNameRequired;
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                const SizedBox(height: 48),
                FilledButton.icon(
                  onPressed: _handleNext,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(context.l10n.onboardingContinue),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _DonePage extends StatelessWidget {
  final String firstName;
  final VoidCallback onFinish;
  final bool isLoading;

  const _DonePage({
    required this.firstName,
    required this.onFinish,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 80,
                color: context.colorScheme.primary,
              )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.5, 0.5), duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 32),
              Text(
                context.l10n.onboardingDoneTitle,
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                context.l10n.onboardingDoneWelcome(firstName),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: isLoading ? null : onFinish,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(context.l10n.onboardingDoneButton),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
