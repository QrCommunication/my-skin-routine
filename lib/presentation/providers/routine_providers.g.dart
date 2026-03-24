// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routineRepository)
final routineRepositoryProvider = RoutineRepositoryProvider._();

final class RoutineRepositoryProvider
    extends
        $FunctionalProvider<
          RoutineRepository,
          RoutineRepository,
          RoutineRepository
        >
    with $Provider<RoutineRepository> {
  RoutineRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutineRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutineRepository create(Ref ref) {
    return routineRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutineRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutineRepository>(value),
    );
  }
}

String _$routineRepositoryHash() => r'e85be18954e85463a2724c43457b3dfe0c1c566c';

@ProviderFor(RoutineList)
final routineListProvider = RoutineListProvider._();

final class RoutineListProvider
    extends $AsyncNotifierProvider<RoutineList, List<Routine>> {
  RoutineListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routineListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routineListHash();

  @$internal
  @override
  RoutineList create() => RoutineList();
}

String _$routineListHash() => r'f1d3a13474c64dc7a2b5d9ff31d6cf4db7e5d78b';

abstract class _$RoutineList extends $AsyncNotifier<List<Routine>> {
  FutureOr<List<Routine>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Routine>>, List<Routine>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Routine>>, List<Routine>>,
              AsyncValue<List<Routine>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(activeRoutines)
final activeRoutinesProvider = ActiveRoutinesProvider._();

final class ActiveRoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          Stream<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $StreamProvider<List<Routine>> {
  ActiveRoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeRoutinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeRoutinesHash();

  @$internal
  @override
  $StreamProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Routine>> create(Ref ref) {
    return activeRoutines(ref);
  }
}

String _$activeRoutinesHash() => r'67c9d3c866c6c41694d87888377e34a9fee6f457';

@ProviderFor(routineById)
final routineByIdProvider = RoutineByIdFamily._();

final class RoutineByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Routine?>, Routine?, FutureOr<Routine?>>
    with $FutureModifier<Routine?>, $FutureProvider<Routine?> {
  RoutineByIdProvider._({
    required RoutineByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routineByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routineByIdHash();

  @override
  String toString() {
    return r'routineByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Routine?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Routine?> create(Ref ref) {
    final argument = this.argument as int;
    return routineById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routineByIdHash() => r'46bb649327bde18d90dcd56edae5f54eafae0890';

final class RoutineByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Routine?>, int> {
  RoutineByIdFamily._()
    : super(
        retry: null,
        name: r'routineByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutineByIdProvider call(int id) =>
      RoutineByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'routineByIdProvider';
}

@ProviderFor(routineActions)
final routineActionsProvider = RoutineActionsFamily._();

final class RoutineActionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RoutineAction>>,
          List<RoutineAction>,
          Stream<List<RoutineAction>>
        >
    with
        $FutureModifier<List<RoutineAction>>,
        $StreamProvider<List<RoutineAction>> {
  RoutineActionsProvider._({
    required RoutineActionsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routineActionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routineActionsHash();

  @override
  String toString() {
    return r'routineActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<RoutineAction>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RoutineAction>> create(Ref ref) {
    final argument = this.argument as int;
    return routineActions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routineActionsHash() => r'01388e65aac6fd1f17392469f5caa59de6277b02';

final class RoutineActionsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<RoutineAction>>, int> {
  RoutineActionsFamily._()
    : super(
        retry: null,
        name: r'routineActionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutineActionsProvider call(int routineId) =>
      RoutineActionsProvider._(argument: routineId, from: this);

  @override
  String toString() => r'routineActionsProvider';
}

@ProviderFor(completionsForDate)
final completionsForDateProvider = CompletionsForDateFamily._();

final class CompletionsForDateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActionCompletion>>,
          List<ActionCompletion>,
          Stream<List<ActionCompletion>>
        >
    with
        $FutureModifier<List<ActionCompletion>>,
        $StreamProvider<List<ActionCompletion>> {
  CompletionsForDateProvider._({
    required CompletionsForDateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'completionsForDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$completionsForDateHash();

  @override
  String toString() {
    return r'completionsForDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ActionCompletion>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ActionCompletion>> create(Ref ref) {
    final argument = this.argument as String;
    return completionsForDate(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CompletionsForDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$completionsForDateHash() =>
    r'f5b76349dbbbcc1250c4a47feaf792c030925ec0';

final class CompletionsForDateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ActionCompletion>>, String> {
  CompletionsForDateFamily._()
    : super(
        retry: null,
        name: r'completionsForDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CompletionsForDateProvider call(String date) =>
      CompletionsForDateProvider._(argument: date, from: this);

  @override
  String toString() => r'completionsForDateProvider';
}
