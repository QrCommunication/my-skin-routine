import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _key = 'theme_mode';

  @override
  Future<ThemeMode> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final value = prefs.getString(_key) ?? 'system';
    return ThemeMode.values.byName(value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    await prefs.setString(_key, mode.name);
    state = AsyncValue.data(mode);
  }
}

@riverpod
class DynamicColorEnabledNotifier extends _$DynamicColorEnabledNotifier {
  static const _key = 'dynamic_color_enabled';

  @override
  Future<bool> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return prefs.getBool(_key) ?? true;
  }

  Future<void> setDynamicColorEnabled(bool enabled) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    await prefs.setBool(_key, enabled);
    state = AsyncValue.data(enabled);
  }
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  static const _key = 'locale';

  @override
  Future<Locale?> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final value = prefs.getString(_key);
    if (value == null) return null;

    final parts = value.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }

  Future<void> setLocale(Locale? locale) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      final value = locale.countryCode != null
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      await prefs.setString(_key, value);
    }
    state = AsyncValue.data(locale);
  }
}
