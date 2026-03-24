import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
          _buildLanguageSection(context, ref),
          _buildThemeSection(context, ref),
          if (Platform.isAndroid) _buildDynamicColorSection(context, ref),
          const Divider(indent: 16, endIndent: 16),
          _buildDataSection(context, ref),
          const Divider(indent: 16, endIndent: 16),
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeProvider);
    return localeAsync.when(
      data: (locale) {
        final selected = locale?.languageCode ?? 'fr';
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
                selected: {selected},
                onSelectionChanged: (newSelection) {
                  ref.read(localeProvider.notifier).setLocale(
                        Locale(newSelection.first),
                      );
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildThemeSection(BuildContext context, WidgetRef ref) {
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
                onSelectionChanged: (newSelection) {
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
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDynamicColorSection(BuildContext context, WidgetRef ref) {
    final dynamicAsync = ref.watch(dynamicColorEnabledProvider);
    return dynamicAsync.when(
      data: (enabled) {
        return SwitchListTile(
          title: const Text('Couleurs dynamiques'),
          subtitle:
              const Text('Utiliser les couleurs de votre fond d\'écran'),
          value: enabled,
          onChanged: (value) {
            ref
                .read(dynamicColorEnabledProvider.notifier)
                .setDynamicColorEnabled(value);
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDataSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child:
              Text('Données', style: Theme.of(context).textTheme.labelLarge),
        ),
        ListTile(
          leading: const Icon(Icons.upload_rounded),
          title: const Text('Exporter mes données'),
          onTap: () => _handleExport(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.download_rounded),
          title: const Text('Importer des données'),
          onTap: () => _handleImportDialog(context, ref),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child:
              Text('À propos', style: Theme.of(context).textTheme.labelLarge),
        ),
        const ListTile(
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
        ListTile(
          title: const Text('Licences open source'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => showLicensePage(
            context: context,
            applicationName: 'My Skin Routine',
            applicationVersion: '1.0.0',
          ),
        ),
      ],
    );
  }

  Future<void> _handleExport(BuildContext context, WidgetRef ref) async {
    try {
      final repository = ref.read(exportImportRepositoryProvider);
      final zipPath = await repository.exportData();
      await Share.shareXFiles([XFile(zipPath)],
          text: 'My Skin Routine backup');
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

  Future<void> _handleImportDialog(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Importer des données'),
        content: const Text(
          'Ceci remplacera toutes vos données actuelles. Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

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
