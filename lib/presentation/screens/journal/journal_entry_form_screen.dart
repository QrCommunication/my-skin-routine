import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/presentation/providers/journal_providers.dart';
import 'package:my_skin_routine/presentation/widgets/photo_picker_sheet.dart';
import 'package:my_skin_routine/presentation/widgets/skin_feeling_selector.dart';

class JournalEntryFormScreen extends ConsumerStatefulWidget {
  final int? id;

  const JournalEntryFormScreen({super.key, this.id});

  @override
  ConsumerState<JournalEntryFormScreen> createState() =>
      _JournalEntryFormScreenState();
}

class _JournalEntryFormScreenState extends ConsumerState<JournalEntryFormScreen> {
  late TextEditingController _notesController;
  late DateTime _selectedDate;
  int? _selectedFeeling;
  String? _photoPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);

    if (widget.id != null) {
      _loadEntry();
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _loadEntry() {
    final entryAsync = ref.read(journalEntryByIdProvider(widget.id!));
    entryAsync.when(
      data: (entry) {
        if (entry != null && mounted) {
          setState(() {
            _selectedDate = DateTime.parse(entry.date);
            _notesController.text = entry.notes;
            _selectedFeeling = entry.skinFeeling;
            _photoPath = entry.photoPath;
          });
        }
      },
      loading: () {},
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.commonErrorWithDetails(error.toString()))),
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickPhoto() async {
    final source = await showPhotoPickerSheet(context);
    if (source != null) {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null && mounted) {
        setState(() {
          _photoPath = pickedFile.path;
        });
      }
    }
  }

  void _removePhoto() {
    setState(() {
      _photoPath = null;
    });
  }

  Future<void> _saveEntry() async {
    if (_notesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.journalValidationNotesRequired)),
      );
      return;
    }

    if (_selectedFeeling == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.journalValidationFeelingRequired)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dateStr = _selectedDate.toIso8601String().substring(0, 10);
      final repository = ref.read(skinJournalRepositoryProvider);

      if (widget.id == null) {
        await repository.createEntry(
          date: dateStr,
          photoPath: _photoPath,
          notes: _notesController.text.trim(),
          skinFeeling: _selectedFeeling!,
        );
      } else {
        final entryAsync =
            await ref.read(journalEntryByIdProvider(widget.id!).future);
        if (entryAsync != null) {
          final updatedEntry = entryAsync.copyWith(
            date: dateStr,
            photoPath: _photoPath,
            notes: _notesController.text.trim(),
            skinFeeling: _selectedFeeling!,
          );
          await repository.updateEntry(updatedEntry);
        }
      }

      await ref.read(journalEntriesProvider.notifier).refresh();

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.commonErrorWithDetails(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final title =
        isEditing ? context.l10n.journalEditTitle : context.l10n.journalNewTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.journalDate,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate.toIso8601String().substring(0, 10)),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.journalPhoto,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (_photoPath != null) ...[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      _photoPath!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      .animate()
                      .fadeIn(
                        duration: 300.ms,
                      ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FloatingActionButton.small(
                      onPressed: _removePhoto,
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: _pickPhoto,
                icon: const Icon(Icons.image),
                label: Text(context.l10n.journalAddPhoto),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              context.l10n.journalFeeling,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            SkinFeelingSelector(
              selectedFeeling: _selectedFeeling,
              onChanged: (feeling) {
                setState(() {
                  _selectedFeeling = feeling;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.journalNotes,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesController,
              maxLines: 6,
              maxLength: 1000,
              minLines: 4,
              decoration: InputDecoration(
                hintText: context.l10n.journalNotesHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: '${_notesController.text.length}/1000',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _saveEntry,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(context.l10n.commonSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
