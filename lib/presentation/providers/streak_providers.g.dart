// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(streakForRoutine)
final streakForRoutineProvider = StreakForRoutineFamily._();

final class StreakForRoutineProvider
    extends
        $FunctionalProvider<
          AsyncValue<StreakInfo?>,
          StreakInfo?,
          FutureOr<StreakInfo?>
        >
    with $FutureModifier<StreakInfo?>, $FutureProvider<StreakInfo?> {
  StreakForRoutineProvider._({
    required StreakForRoutineFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'streakForRoutineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$streakForRoutineHash();

  @override
  String toString() {
    return r'streakForRoutineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<StreakInfo?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StreakInfo?> create(Ref ref) {
    final argument = this.argument as int;
    return streakForRoutine(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StreakForRoutineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$streakForRoutineHash() => r'bee2a178ca596ecb819779fb6ef8fe927fdeb1f9';

final class StreakForRoutineFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<StreakInfo?>, int> {
  StreakForRoutineFamily._()
    : super(
        retry: null,
        name: r'streakForRoutineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StreakForRoutineProvider call(int routineId) =>
      StreakForRoutineProvider._(argument: routineId, from: this);

  @override
  String toString() => r'streakForRoutineProvider';
}
