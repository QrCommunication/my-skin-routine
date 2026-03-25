import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/core/utils/notification_utils.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';

class RoutineFormScreen extends ConsumerStatefulWidget {
  final int? id;

  const RoutineFormScreen({super.key, this.id});

  @override
  ConsumerState<RoutineFormScreen> createState() => _RoutineFormScreenState();
}

class _RoutineFormScreenState extends ConsumerState<RoutineFormScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController();
  late final _descriptionController = TextEditingController();

  late BodyZone _selectedBodyZone;
  late SkinGoal _selectedSkinGoal;
  TimeOfDay? _selectedReminderTime;
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedBodyZone = BodyZone.fullFace;
    _selectedSkinGoal = SkinGoal.hydration;
    _loadRoutineIfEditing();
  }

  void _loadRoutineIfEditing() {
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final routine = await ref.read(routineByIdProvider(widget.id!).future);
        if (routine != null && mounted) {
          setState(() {
            _nameController.text = routine.name;
            _descriptionController.text = routine.description ?? '';
            _selectedBodyZone = routine.bodyZone;
            _selectedSkinGoal = routine.skinGoal;
            _isActive = routine.isActive;
            if (routine.reminderTime != null) {
              final parts = routine.reminderTime!.split(':');
              if (parts.length == 2) {
                _selectedReminderTime = TimeOfDay(
                  hour: int.tryParse(parts[0]) ?? 0,
                  minute: int.tryParse(parts[1]) ?? 0,
                );
              }
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final title = isEditing ? context.l10n.routineEdit : context.l10n.routineNew;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.routineFormName,
                  hintText: context.l10n.routineFormNameHint,
                  helperText: context.l10n.routineFormNameHelperText,
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.routineFormNameRequired;
                  }
                  if (value.length > 100) {
                    return context.l10n.routineFormNameMaxLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: context.l10n.routineFormDescription,
                  hintText: context.l10n.routineFormDescriptionHint,
                  helperText: context.l10n.routineFormDescriptionHelperText,
                  alignLabelWithHint: true,
                ),
                maxLength: 500,
                maxLines: 4,
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return context.l10n.routineFormDescriptionMaxLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.routineFormBodyZone,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: BodyZone.values.map((zone) {
                  final isSelected = _selectedBodyZone == zone;
                  return ChoiceChip(
                    label: Text(zone.localizedLabel(locale.languageCode)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) _selectedBodyZone = zone;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.routineFormSkinGoal,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SkinGoal.values.map((goal) {
                  final isSelected = _selectedSkinGoal == goal;
                  return ChoiceChip(
                    avatar: Text(goal.emoji),
                    label: Text(goal.localizedLabel(locale.languageCode)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) _selectedSkinGoal = goal;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(context.l10n.routineFormReminder),
                subtitle: _selectedReminderTime != null
                    ? Text(_selectedReminderTime!.format(context))
                    : Text(context.l10n.routineFormReminderNotSet),
                trailing: IconButton(
                  icon: const Icon(Icons.schedule),
                  onPressed: () => _pickReminderTime(context),
                ),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(context.l10n.routineFormActive),
                subtitle: Text(context.l10n.routineFormActiveSubtitle),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _saveRoutine,
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Text(isEditing ? context.l10n.routineFormUpdate : context.l10n.commonSave),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickReminderTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedReminderTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedReminderTime = time;
      });
    }
  }

  Future<void> _saveRoutine() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repository = ref.read(routineRepositoryProvider);
      final reminderTimeStr = _selectedReminderTime != null
          ? '${_selectedReminderTime!.hour.toString().padLeft(2, '0')}:${_selectedReminderTime!.minute.toString().padLeft(2, '0')}'
          : null;

      if (widget.id != null) {
        final routine = await ref.read(routineByIdProvider(widget.id!).future);
        if (routine != null) {
          final updated = routine.copyWith(
            name: _nameController.text,
            description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
            bodyZone: _selectedBodyZone,
            skinGoal: _selectedSkinGoal,
            reminderTime: reminderTimeStr,
            isActive: _isActive,
          );
          await repository.updateRoutine(updated);

          // Schedule or cancel notification
          if (_selectedReminderTime != null && _isActive) {
            await NotificationService().scheduleRoutineReminder(
              routineId: widget.id!,
              routineName: _nameController.text,
              hour: _selectedReminderTime!.hour,
              minute: _selectedReminderTime!.minute,
              actionCount: updated.actions.length,
            );
          } else {
            await NotificationService().cancelRoutineReminder(widget.id!);
          }
        }
      } else {
        final newId = await repository.createRoutine(
          name: _nameController.text,
          description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
          bodyZone: _selectedBodyZone.name,
          skinGoal: _selectedSkinGoal.name,
          reminderTime: reminderTimeStr,
          isActive: _isActive,
        );

        // Schedule notification for new routine
        if (_selectedReminderTime != null && _isActive) {
          await NotificationService().scheduleRoutineReminder(
            routineId: newId,
            routineName: _nameController.text,
            hour: _selectedReminderTime!.hour,
            minute: _selectedReminderTime!.minute,
            actionCount: 0,
          );
        }

        ref.invalidate(routineListProvider);
        ref.invalidate(routineByIdProvider);

        if (mounted) {
          context.go('/routines/$newId');
        }
        return;
      }

      ref.invalidate(routineListProvider);
      ref.invalidate(routineByIdProvider);

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
        setState(() => _isLoading = false);
      }
    }
  }
}
