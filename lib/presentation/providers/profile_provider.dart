import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileNotifier extends _$ProfileNotifier {
  static const _firstNameKey = 'profile_first_name';
  static const _lastNameKey = 'profile_last_name';
  static const _onboardingCompleteKey = 'onboarding_complete';

  @override
  Future<({String firstName, String lastName, bool onboardingComplete})> build() async {
    final prefs = await SharedPreferences.getInstance();
    return (
      firstName: prefs.getString(_firstNameKey) ?? '',
      lastName: prefs.getString(_lastNameKey) ?? '',
      onboardingComplete: prefs.getBool(_onboardingCompleteKey) ?? false,
    );
  }

  Future<void> setProfile({required String firstName, required String lastName}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
    state = AsyncData((
      firstName: firstName,
      lastName: lastName,
      onboardingComplete: state.value?.onboardingComplete ?? false,
    ));
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
    final current = state.value;
    if (current != null) {
      state = AsyncData((
        firstName: current.firstName,
        lastName: current.lastName,
        onboardingComplete: true,
      ));
    }
  }
}
