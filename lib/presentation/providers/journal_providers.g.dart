// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(skinJournalRepository)
final skinJournalRepositoryProvider = SkinJournalRepositoryProvider._();

final class SkinJournalRepositoryProvider
    extends
        $FunctionalProvider<
          SkinJournalRepository,
          SkinJournalRepository,
          SkinJournalRepository
        >
    with $Provider<SkinJournalRepository> {
  SkinJournalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skinJournalRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skinJournalRepositoryHash();

  @$internal
  @override
  $ProviderElement<SkinJournalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SkinJournalRepository create(Ref ref) {
    return skinJournalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SkinJournalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SkinJournalRepository>(value),
    );
  }
}

String _$skinJournalRepositoryHash() =>
    r'058ebff2e012742b0aef775b075858da535a2d5f';

@ProviderFor(JournalEntries)
final journalEntriesProvider = JournalEntriesProvider._();

final class JournalEntriesProvider
    extends $AsyncNotifierProvider<JournalEntries, List<SkinJournalEntry>> {
  JournalEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalEntriesHash();

  @$internal
  @override
  JournalEntries create() => JournalEntries();
}

String _$journalEntriesHash() => r'9366780eca782e0abdcc539307b0fb12701d40c9';

abstract class _$JournalEntries extends $AsyncNotifier<List<SkinJournalEntry>> {
  FutureOr<List<SkinJournalEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SkinJournalEntry>>, List<SkinJournalEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SkinJournalEntry>>,
                List<SkinJournalEntry>
              >,
              AsyncValue<List<SkinJournalEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(journalEntryById)
final journalEntryByIdProvider = JournalEntryByIdFamily._();

final class JournalEntryByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<SkinJournalEntry?>,
          SkinJournalEntry?,
          FutureOr<SkinJournalEntry?>
        >
    with
        $FutureModifier<SkinJournalEntry?>,
        $FutureProvider<SkinJournalEntry?> {
  JournalEntryByIdProvider._({
    required JournalEntryByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'journalEntryByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$journalEntryByIdHash();

  @override
  String toString() {
    return r'journalEntryByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SkinJournalEntry?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SkinJournalEntry?> create(Ref ref) {
    final argument = this.argument as int;
    return journalEntryById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntryByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journalEntryByIdHash() => r'18cc9064c097729c8f456e3845bc9c0dc204ddfc';

final class JournalEntryByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SkinJournalEntry?>, int> {
  JournalEntryByIdFamily._()
    : super(
        retry: null,
        name: r'journalEntryByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JournalEntryByIdProvider call(int id) =>
      JournalEntryByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'journalEntryByIdProvider';
}

@ProviderFor(journalEntriesForMonth)
final journalEntriesForMonthProvider = JournalEntriesForMonthFamily._();

final class JournalEntriesForMonthProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SkinJournalEntry>>,
          List<SkinJournalEntry>,
          FutureOr<List<SkinJournalEntry>>
        >
    with
        $FutureModifier<List<SkinJournalEntry>>,
        $FutureProvider<List<SkinJournalEntry>> {
  JournalEntriesForMonthProvider._({
    required JournalEntriesForMonthFamily super.from,
    required ({int month, int year}) super.argument,
  }) : super(
         retry: null,
         name: r'journalEntriesForMonthProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$journalEntriesForMonthHash();

  @override
  String toString() {
    return r'journalEntriesForMonthProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SkinJournalEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SkinJournalEntry>> create(Ref ref) {
    final argument = this.argument as ({int month, int year});
    return journalEntriesForMonth(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntriesForMonthProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journalEntriesForMonthHash() =>
    r'3050f950094126d2b4c76aa26a2bf6a946caffba';

final class JournalEntriesForMonthFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SkinJournalEntry>>,
          ({int month, int year})
        > {
  JournalEntriesForMonthFamily._()
    : super(
        retry: null,
        name: r'journalEntriesForMonthProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JournalEntriesForMonthProvider call(({int month, int year}) period) =>
      JournalEntriesForMonthProvider._(argument: period, from: this);

  @override
  String toString() => r'journalEntriesForMonthProvider';
}
