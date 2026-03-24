import 'package:flutter/material.dart';
import 'package:my_skin_routine/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/presentation/router/app_router.dart';
import 'package:my_skin_routine/presentation/theme/app_theme.dart';

class MySkinRoutineApp extends ConsumerWidget {
  const MySkinRoutineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use our brand lavender palette by default — no dynamic color
    // Dynamic color can be enabled later in settings
    return MaterialApp.router(
      title: 'My Skin Routine',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      locale: const Locale('fr'),
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: appRouter,
    );
  }
}
