import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/routine_action.dart';
import '../../providers/routine_providers.dart';
import '../../providers/product_providers.dart';

class ActionFormScreen extends ConsumerStatefulWidget {
  final int routineId;
  final int? actionId;

  const ActionFormScreen({
    required this.routineId,
    this.actionId,
  });

  @override
  ConsumerState<ActionFormScreen> createState() => _ActionFormScreenState();
}

class _ActionFormScreenState extends ConsumerState<ActionFormScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  RecurrenceType _recurrenceType = RecurrenceType.daily;
  int _recurrenceInterval = 2;
  DateTime _recurrenceStartDate = DateTime.now();
  int? _selectedProductId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.actionId != null) {
      _loadActionData();
    }
  }

  void _loadActionData() {
    final action = ref
        .read(routineActionsProvider(widget.routineId))
        .whenData((actions) => actions.firstWhere(
              (a) => a.id == widget.actionId,
              orElse: () => null as RoutineAction,
            ));

    action.whenData((a) {
      if (a != null) {
        _nameController.text = a.name;
        _descriptionController.text = a.description ?? '';
        _selectedProductId = a.productId;
        _recurrenceType = a.recurrenceType;
        _recurrenceInterval = a.recurrenceInterval;
        _recurrenceStartDate = DateTime.parse(a.recurrenceStartDate);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return date.toIso8601String().substring(0, 10);
  }

  String _getRecurrenceLabel() {
    if (_recurrenceType == RecurrenceType.daily) {
      return 'Quotidien';
    }
    if (_recurrenceInterval == 7) {
      return 'Hebdomadaire';
    }
    return 'Tous les $_recurrenceInterval jours';
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _recurrenceStartDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _recurrenceStartDate = picked;
      });
    }
  }

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un nom pour l\'action')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final routineRepository = ref.read(routineRepositoryProvider);

      if (widget.actionId == null) {
        // Create new action
        await routineRepository.createAction(
          routineId: widget.routineId,
          name: _nameController.text.trim(),
          description:
              _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          productId: _selectedProductId,
          recurrenceType: _recurrenceType.name,
          recurrenceInterval: _recurrenceInterval,
          recurrenceStartDate: _formatDate(_recurrenceStartDate),
        );
      } else {
        // Update existing action
        final action = RoutineAction(
          id: widget.actionId!,
          routineId: widget.routineId,
          productId: _selectedProductId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          sortOrder: 0,
          recurrenceType: _recurrenceType,
          recurrenceInterval: _recurrenceInterval,
          recurrenceStartDate: _formatDate(_recurrenceStartDate),
          createdAt: DateTime.now(),
        );
        await routineRepository.updateAction(action);
      }

      ref.invalidate(routineByIdProvider(widget.routineId));
      ref.invalidate(routineActionsProvider(widget.routineId));

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.actionId != null;
    final title = isEditing ? 'Éditer Action' : 'Nouvelle Action';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom *',
                hintText: 'Ex: Appliquer le sérum',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 200,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Le nom est requis';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Ajoutez des détails optionnels',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 500,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ref.watch(productListProvider).when(
              data: (products) {
                return DropdownButtonFormField<int?>(
                  value: _selectedProductId,
                  decoration: InputDecoration(
                    labelText: 'Produit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('Aucun'),
                    ),
                    ...products.map(
                      (product) => DropdownMenuItem<int?>(
                        value: product.id,
                        child: Text(product.name),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProductId = value;
                    });
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Erreur: $error'),
            ),
            const SizedBox(height: 16),
            Text(
              'Type de récurrence',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<RecurrenceType>(
              segments: const [
                ButtonSegment<RecurrenceType>(
                  value: RecurrenceType.daily,
                  label: Text('Quotidien'),
                ),
                ButtonSegment<RecurrenceType>(
                  value: RecurrenceType.everyNDays,
                  label: Text('Tous les N jours'),
                ),
              ],
              selected: <RecurrenceType>{_recurrenceType},
              onSelectionChanged: (Set<RecurrenceType> newSelection) {
                setState(() {
                  _recurrenceType = newSelection.first;
                  if (_recurrenceType == RecurrenceType.daily) {
                    _recurrenceInterval = 1;
                  } else if (_recurrenceInterval < 2) {
                    _recurrenceInterval = 2;
                  }
                });
              },
            ),
            if (_recurrenceType == RecurrenceType.everyNDays) ...[
              const SizedBox(height: 16),
              Text(
                _getRecurrenceLabel(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Slider(
                value: _recurrenceInterval.toDouble(),
                min: 2,
                max: 30,
                divisions: 28,
                label: _recurrenceInterval.toString(),
                onChanged: (value) {
                  setState(() {
                    _recurrenceInterval = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date de référence'),
                subtitle: Text(_formatDate(_recurrenceStartDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isLoading ? null : _handleSave,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
