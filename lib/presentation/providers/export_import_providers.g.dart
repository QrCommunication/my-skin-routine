// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_import_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exportImportRepository)
final exportImportRepositoryProvider = ExportImportRepositoryProvider._();

final class ExportImportRepositoryProvider
    extends
        $FunctionalProvider<
          ExportImportRepository,
          ExportImportRepository,
          ExportImportRepository
        >
    with $Provider<ExportImportRepository> {
  ExportImportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportImportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportImportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExportImportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExportImportRepository create(Ref ref) {
    return exportImportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportImportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportImportRepository>(value),
    );
  }
}

String _$exportImportRepositoryHash() =>
    r'3fcacab89e3b3955f79361cbf005e7d42b36100d';
