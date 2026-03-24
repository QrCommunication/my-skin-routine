import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:my_skin_routine/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/presentation/router/app_router.dart';
import 'package:my_skin_routine/presentation/theme/app_theme.dart';

class MySkinRoutineApp extends ConsumerWidget {
  const MySkinRoutineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp.router(
          title: 'My Skin Routine',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme(dynamicScheme: lightDynamic),
          darkTheme: AppTheme.darkTheme(dynamicScheme: darkDynamic),
          locale: const Locale('fr'),
          supportedLocales: const [
            Locale('fr'),
            Locale('en'),
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: appRouter,
        );
      },
    );
  }
}
