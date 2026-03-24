// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileNotifier)
final profileProvider = ProfileNotifierProvider._();

final class ProfileNotifierProvider
    extends
        $AsyncNotifierProvider<
          ProfileNotifier,
          ({String firstName, String lastName, bool onboardingComplete})
        > {
  ProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileNotifierHash();

  @$internal
  @override
  ProfileNotifier create() => ProfileNotifier();
}

String _$profileNotifierHash() => r'f4e5a436fe6a22462c2dd2639d10c920d75aef54';

abstract class _$ProfileNotifier
    extends
        $AsyncNotifier<
          ({String firstName, String lastName, bool onboardingComplete})
        > {
  FutureOr<({String firstName, String lastName, bool onboardingComplete})>
  build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<
                ({String firstName, String lastName, bool onboardingComplete})
              >,
              ({String firstName, String lastName, bool onboardingComplete})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<
                  ({String firstName, String lastName, bool onboardingComplete})
                >,
                ({String firstName, String lastName, bool onboardingComplete})
              >,
              AsyncValue<
                ({String firstName, String lastName, bool onboardingComplete})
              >,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
