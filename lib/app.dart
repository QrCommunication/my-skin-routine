import 'package:flutter/material.dart';
import 'package:my_skin_routine/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/presentation/providers/settings_providers.dart';
import 'package:my_skin_routine/presentation/router/app_router.dart';
import 'package:my_skin_routine/presentation/theme/app_theme.dart';

class MySkinRoutineApp extends ConsumerWidget {
  const MySkinRoutineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch settings providers for reactive theme/locale changes
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;
    final locale = ref.watch(localeProvider).value;

    return MaterialApp.router(
      title: 'My Skin Routine',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      locale: locale ?? const Locale('fr'),
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: appRouter,
    );
  }
}
