import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/extensions/context_extensions.dart';
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

  String _getRecurrenceLabel(BuildContext context) {
    if (_recurrenceType == RecurrenceType.daily) {
      return context.l10n.actionFormRecurrenceDaily;
    }
    if (_recurrenceInterval == 7) {
      return context.l10n.actionFormRecurrenceWeekly;
    }
    return context.l10n.actionFormRecurrenceEveryN(_recurrenceInterval);
  }

  void _showProductSearchDialog(BuildContext context, List<Product> products) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (ctx, scrollController) {
            return _ProductSearchSheet(
              products: products,
              selectedId: _selectedProductId,
              onSelected: (id) {
                setState(() => _selectedProductId = id);
                Navigator.pop(ctx);
              },
            );
          },
        );
      },
    );
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

  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    _selectedProductId = null;
    _recurrenceType = RecurrenceType.daily;
    _recurrenceInterval = 2;
    _recurrenceStartDate = DateTime.now();
    setState(() {});
  }

  Future<void> _handleSave({bool stayAndCreate = false}) async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.actionFormValidationNameRequired)),
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
      ref.invalidate(routineListProvider);
      ref.invalidate(activeRoutinesProvider);

      if (mounted) {
        if (stayAndCreate) {
          _resetForm();
        } else {
          context.pop();
        }
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

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.actionId != null;
    final title = isEditing ? context.l10n.actionEdit : context.l10n.actionNew;
    final locale = Localizations.localeOf(context).languageCode;

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
                labelText: context.l10n.actionFormName,
                hintText: context.l10n.actionFormNameHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 200,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.l10n.actionFormNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: context.l10n.actionFormDescription,
                hintText: context.l10n.actionFormDescriptionHint,
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
                final selected = _selectedProductId != null
                    ? products.where((p) => p.id == _selectedProductId).firstOrNull
                    : null;
                return InkWell(
                  onTap: () => _showProductSearchDialog(context, products),
                  borderRadius: BorderRadius.circular(8),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: context.l10n.actionFormProduct,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: _selectedProductId != null
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () => setState(() => _selectedProductId = null),
                            )
                          : const Icon(Icons.search),
                    ),
                    child: Text(
                      selected != null
                          ? '${selected.brand} — ${selected.name}'
                          : context.l10n.actionFormProductNone,
                      overflow: TextOverflow.ellipsis,
                      style: selected != null
                          ? null
                          : TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text(context.l10n.commonErrorWithDetails(error.toString())),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.actionFormRecurrence,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<RecurrenceType>(
              segments: [
                ButtonSegment<RecurrenceType>(
                  value: RecurrenceType.daily,
                  label: Text(context.l10n.actionFormRecurrenceDaily),
                ),
                ButtonSegment<RecurrenceType>(
                  value: RecurrenceType.everyNDays,
                  label: Text(context.l10n.actionFormInterval),
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
                _getRecurrenceLabel(context),
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
                title: Text(context.l10n.actionFormStartDate),
                subtitle: Text(_formatDate(_recurrenceStartDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isLoading ? null : () => _handleSave(stayAndCreate: false),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(context.l10n.commonSave),
            ),
            const SizedBox(height: 12),
            if (widget.actionId == null)
              OutlinedButton(
                onPressed: _isLoading ? null : () => _handleSave(stayAndCreate: true),
                child: Text(context.l10n.actionFormSaveAndNew(context.l10n.commonSave)),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProductSearchSheet extends StatefulWidget {
  final List<Product> products;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  const _ProductSearchSheet({
    required this.products,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  State<_ProductSearchSheet> createState() => _ProductSearchSheetState();
}

class _ProductSearchSheetState extends State<_ProductSearchSheet> {
  final _searchController = TextEditingController();
  List<Product> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.products;
  }

  void _filter(String query) {
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.products;
      } else {
        final q = query.toLowerCase();
        _filtered = widget.products
            .where((p) =>
                p.name.toLowerCase().contains(q) ||
                p.brand.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).languageCode;
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: context.l10n.actionFormProductSearch,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: colorScheme.surfaceContainerHighest,
            ),
            onChanged: _filter,
          ),
        ),
        // "Aucun" option
        ListTile(
          leading: Icon(Icons.block, color: colorScheme.outline),
          title: Text(context.l10n.actionFormProductNoneLabel),
          selected: widget.selectedId == null,
          onTap: () => widget.onSelected(null),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              final product = _filtered[index];
              final isSelected = product.id == widget.selectedId;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    product.brand[0].toUpperCase(),
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                ),
                title: Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${product.brand} • ${product.type.localizedLabel(locale)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                selected: isSelected,
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: colorScheme.primary)
                    : null,
                onTap: () => widget.onSelected(product.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
