import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_skin_routine/presentation/providers/settings_providers.dart';
import 'package:my_skin_routine/presentation/providers/export_import_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          _LanguageSection(ref),
          _ThemeSection(ref),
          if (Platform.isAndroid) _DynamicColorSection(ref),
          _DataSection(ref),
          _AboutSection(),
        ],
      ),
    );
  }
}

class _LanguageSection extends ConsumerWidget {
  final WidgetRef ref;

  const _LanguageSection(this.ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeProvider);

    return localeAsync.when(
      data: (locale) {
        final selectedValue = locale?.languageCode ?? 'system';
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Langue', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(label: Text('Français'), value: 'fr'),
                  ButtonSegment(label: Text('English'), value: 'en'),
                ],
                selected: {selectedValue},
                onSelectionChanged: (Set<String> newSelection) {
                  final value = newSelection.first;
                  if (value == 'system') {
                    ref.read(localeProvider.notifier).setLocale(null);
                  } else {
                    ref
                        .read(localeProvider.notifier)
                        .setLocale(Locale(value));
                  }
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _ThemeSection extends ConsumerWidget {
  final WidgetRef ref;

  const _ThemeSection(this.ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);

    return themeAsync.when(
      data: (themeMode) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thème', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 12),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(label: Text('Auto'), value: ThemeMode.system),
                  ButtonSegment(label: Text('Clair'), value: ThemeMode.light),
                  ButtonSegment(label: Text('Sombre'), value: ThemeMode.dark),
                ],
                selected: {themeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) {
                  ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(newSelection.first);
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _DynamicColorSection extends ConsumerWidget {
  final WidgetRef ref;

  const _DynamicColorSection(this.ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dynamicColorAsync =
        ref.watch(dynamicColorEnabledProvider);

    return dynamicColorAsync.when(
      data: (enabled) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SwitchListTile(
            title: const Text('Couleur dynamique'),
            subtitle: const Text('Utiliser les couleurs du système'),
            value: enabled,
            onChanged: (value) {
              ref
                  .read(dynamicColorEnabledProvider.notifier)
                  .setDynamicColorEnabled(value);
            },
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _DataSection extends ConsumerWidget {
  final WidgetRef ref;

  const _DataSection(this.ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text('Données', style: Theme.of(context).textTheme.labelLarge),
        ),
        ListTile(
          leading: const Icon(Icons.upload_rounded),
          title: const Text('Exporter mes données'),
          onTap: () => _handleExport(context, ref),
        )
            .animate()
            .fadeIn(
              delay: 100.ms,
              duration: 300.ms,
            )
            .slideX(
              begin: 0.05,
              delay: 100.ms,
              duration: 300.ms,
            ),
        ListTile(
          leading: const Icon(Icons.download_rounded),
          title: const Text('Importer des données'),
          onTap: () => _handleImportDialog(context, ref),
        )
            .animate()
            .fadeIn(
              delay: 150.ms,
              duration: 300.ms,
            )
            .slideX(
              begin: 0.05,
              delay: 150.ms,
              duration: 300.ms,
            ),
      ],
    );
  }

  Future<void> _handleExport(BuildContext context, WidgetRef ref) async {
    try {
      final repository = ref.read(exportImportRepositoryProvider);
      final zipPath = await repository.exportData();

      final files = [XFile(zipPath)];
      await Share.shareXFiles(files, text: 'Mes données de routine');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export réussi ✓')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  Future<void> _handleImportDialog(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Importer des données'),
          content: const Text(
            'Ceci remplacera toutes vos données actuelles. Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _handleImport(context, ref);
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleImport(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.first.path;
        if (filePath != null) {
          final repository = ref.read(exportImportRepositoryProvider);
          await repository.importData(filePath);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Import réussi ✓')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child:
              Text('À propos', style: Theme.of(context).textTheme.labelLarge),
        ),
        ListTile(
          title: const Text('Version'),
          subtitle: const Text('1.0.0'),
        ),
        ListTile(
          title: const Text('Licences open source'),
          onTap: () => showLicensePage(context: context),
        ),
      ],
    );
  }
}
