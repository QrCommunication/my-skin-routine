import 'package:flutter/material.dart';
import 'package:my_skin_routine/l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  /// Returns the current color scheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the current localizations (AppLocalizations).
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
