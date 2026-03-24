import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/presentation/providers/product_providers.dart';
import 'package:my_skin_routine/presentation/providers/profile_provider.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';

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
  String? _productName;
  String? _productBrand;
  ProductType? _productType;
  String? _routineName;
  BodyZone? _routineBodyZone;
  SkinGoal? _routineSkinGoal;

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
    if (_currentPage < 4) {
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
    // Save profile
    await ref.read(profileProvider.notifier).setProfile(
      firstName: _firstName,
      lastName: _lastName,
    );

    // Create product if provided
    if (_productName != null && _productName!.isNotEmpty) {
      final productRepository = ref.read(productRepositoryProvider);
      try {
        await productRepository.createProduct(
          name: _productName!,
          brand: _productBrand ?? '',
          type: (_productType ?? ProductType.cleanser).name,
          photoPath: null,
          notes: '',
        );
      } catch (e) {
        // Silently fail if product creation fails
      }
    }

    // Create routine if provided
    if (_routineName != null && _routineName!.isNotEmpty) {
      final routineRepository = ref.read(routineRepositoryProvider);
      try {
        await routineRepository.createRoutine(
          name: _routineName!,
          description: '',
          bodyZone: (_routineBodyZone ?? BodyZone.fullFace).name,
          skinGoal: (_routineSkinGoal ?? SkinGoal.hydration).name,
          isActive: true,
        );
      } catch (e) {
        // Silently fail if routine creation fails
      }
    }

    // Mark onboarding as complete
    await ref.read(profileProvider.notifier).completeOnboarding();

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
              _ProductPage(
                onProductNameChanged: (value) => _productName = value,
                onProductBrandChanged: (value) => _productBrand = value,
                onProductTypeChanged: (value) => _productType = value,
                onNext: _nextPage,
                onSkip: _nextPage,
              ),
              _RoutinePage(
                onRoutineNameChanged: (value) => _routineName = value,
                onBodyZoneChanged: (value) => _routineBodyZone = value,
                onSkinGoalChanged: (value) => _routineSkinGoal = value,
                onNext: _nextPage,
                onSkip: _nextPage,
              ),
              _DonePage(
                firstName: _firstName,
                onFinish: _finishOnboarding,
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
                    5,
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
                size: 80,
                color: context.colorScheme.primary,
              )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.8, 0.8), duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 32),
              Text(
                context.l10n.onboardingWelcomeTitle,
                style: context.textTheme.headlineLarge,
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
              FilledButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.arrow_forward),
                label: Text(context.l10n.onboardingStart),
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
                      return 'Le prénom est requis';
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
                      return 'Le nom est requis';
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

class _ProductPage extends StatefulWidget {
  final Function(String) onProductNameChanged;
  final Function(String) onProductBrandChanged;
  final Function(ProductType) onProductTypeChanged;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _ProductPage({
    required this.onProductNameChanged,
    required this.onProductBrandChanged,
    required this.onProductTypeChanged,
    required this.onNext,
    required this.onSkip,
  });

  @override
  State<_ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<_ProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  ProductType _selectedType = ProductType.cleanser;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _brandController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_nameController.text.isNotEmpty) {
      widget.onProductNameChanged(_nameController.text);
      widget.onProductBrandChanged(_brandController.text);
      widget.onProductTypeChanged(_selectedType);
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.onboardingProductTitle,
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 8),
              Text(
                context.l10n.onboardingProductSubtitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 100.ms, duration: 600.ms),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.productFormName,
                  border: const OutlineInputBorder(),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 16),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(
                  labelText: context.l10n.productFormBrand,
                  border: const OutlineInputBorder(),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
              const SizedBox(height: 16),
              DropdownButtonFormField<ProductType>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: context.l10n.productFormType,
                  border: const OutlineInputBorder(),
                ),
                items: ProductType.values
                    .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.labelFr),
                    ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: widget.onSkip,
                      child: Text(context.l10n.onboardingSkip),
                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _handleNext,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(context.l10n.onboardingContinue),
                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoutinePage extends StatefulWidget {
  final Function(String) onRoutineNameChanged;
  final Function(BodyZone) onBodyZoneChanged;
  final Function(SkinGoal) onSkinGoalChanged;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _RoutinePage({
    required this.onRoutineNameChanged,
    required this.onBodyZoneChanged,
    required this.onSkinGoalChanged,
    required this.onNext,
    required this.onSkip,
  });

  @override
  State<_RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<_RoutinePage> {
  late TextEditingController _nameController;
  BodyZone _selectedBodyZone = BodyZone.fullFace;
  SkinGoal _selectedSkinGoal = SkinGoal.hydration;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_nameController.text.isNotEmpty) {
      widget.onRoutineNameChanged(_nameController.text);
      widget.onBodyZoneChanged(_selectedBodyZone);
      widget.onSkinGoalChanged(_selectedSkinGoal);
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.onboardingRoutineTitle,
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 8),
              Text(
                context.l10n.onboardingRoutineSubtitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 100.ms, duration: 600.ms),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.routineFormName,
                  border: const OutlineInputBorder(),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 16),
              DropdownButtonFormField<BodyZone>(
                value: _selectedBodyZone,
                decoration: InputDecoration(
                  labelText: context.l10n.routineFormBodyZone,
                  border: const OutlineInputBorder(),
                ),
                items: BodyZone.values
                    .map((zone) => DropdownMenuItem(
                      value: zone,
                      child: Text(zone.labelFr),
                    ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedBodyZone = value);
                  }
                },
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
              const SizedBox(height: 16),
              DropdownButtonFormField<SkinGoal>(
                value: _selectedSkinGoal,
                decoration: InputDecoration(
                  labelText: context.l10n.routineFormSkinGoal,
                  border: const OutlineInputBorder(),
                ),
                items: SkinGoal.values
                    .map((goal) => DropdownMenuItem(
                      value: goal,
                      child: Text('${goal.emoji} ${goal.labelFr}'),
                    ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedSkinGoal = value);
                  }
                },
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: widget.onSkip,
                      child: Text(context.l10n.onboardingSkip),
                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _handleNext,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(context.l10n.onboardingContinue),
                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonePage extends StatelessWidget {
  final String firstName;
  final VoidCallback onFinish;

  const _DonePage({
    required this.firstName,
    required this.onFinish,
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
              FilledButton.icon(
                onPressed: onFinish,
                icon: const Icon(Icons.arrow_forward),
                label: Text(context.l10n.onboardingDoneButton),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
