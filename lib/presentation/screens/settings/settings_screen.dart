import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/presentation/providers/settings_providers.dart';
import 'package:my_skin_routine/presentation/providers/export_import_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsTitle),
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
              Text(context.l10n.settingsLanguage, style: Theme.of(context).textTheme.labelLarge),
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
              Text(context.l10n.settingsTheme, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 12),
              SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(label: Text(context.l10n.settingsThemeAuto), value: ThemeMode.system),
                  ButtonSegment(label: Text(context.l10n.settingsThemeLight), value: ThemeMode.light),
                  ButtonSegment(label: Text(context.l10n.settingsThemeDark), value: ThemeMode.dark),
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
          title: Text(context.l10n.settingsDynamicColor),
          subtitle:
              Text(context.l10n.settingsDynamicColorSubtitle),
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
              Text(context.l10n.settingsTitle, style: Theme.of(context).textTheme.labelLarge),
        ),
        ListTile(
          leading: const Icon(Icons.upload_rounded),
          title: Text(context.l10n.settingsExport),
          onTap: () => _handleExport(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.download_rounded),
          title: Text(context.l10n.settingsImport),
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
              Text(context.l10n.settingsAbout, style: Theme.of(context).textTheme.labelLarge),
        ),
        ListTile(
          title: Text(context.l10n.settingsVersion),
          subtitle: const Text('1.0.0'),
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
          SnackBar(content: Text(context.l10n.exportSuccess)),
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
        title: Text(context.l10n.settingsImport),
        content: Text(context.l10n.settingsImportWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(context.l10n.commonConfirm),
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
              SnackBar(content: Text(context.l10n.importSuccess)),
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
