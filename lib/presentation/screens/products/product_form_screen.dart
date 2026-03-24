import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/enums.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/photo_utils.dart';
import '../../../domain/models/product.dart';
import '../../providers/product_providers.dart';
import '../../widgets/photo_picker_sheet.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final int? id;

  const ProductFormScreen({super.key, this.id});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _brandController;
  late final TextEditingController _notesController;

  late ProductType _selectedType;
  String? _photoPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _brandController = TextEditingController();
    _notesController = TextEditingController();
    _selectedType = ProductType.cleanser;

    if (widget.id != null) {
      _loadProduct();
    }
  }

  void _loadProduct() {
    ref.read(productByIdProvider(widget.id!)).whenData(
      (p) {
        if (p != null) {
          _nameController.text = p.name;
          _brandController.text = p.brand;
          _notesController.text = p.notes ?? '';
          _selectedType = p.type;
          if (p.photoPath != null) {
            _photoPath = p.photoPath;
          }
          setState(() {});
        }
      },
    );
  }

  Future<void> _pickPhoto() async {
    final imageSource = await showPhotoPickerSheet(context);
    if (imageSource == null) return;

    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: imageSource);

    if (xFile != null && mounted) {
      final savedPath = await savePhoto(
        xFile.path,
        'images/products',
        widget.id?.toString() ?? 'new',
      );

      setState(() {
        _photoPath = savedPath;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final name = _nameController.text.trim();
      final brand = _brandController.text.trim();
      final notes = _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim();

      final isEditing = widget.id != null;
      final productRepository = ref.read(productRepositoryProvider);

      if (isEditing) {
        final product = Product(
          id: widget.id!,
          name: name,
          brand: brand,
          type: _selectedType,
          photoPath: _photoPath,
          notes: notes,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await productRepository.updateProduct(product);
      } else {
        await productRepository.createProduct(
          name: name,
          brand: brand,
          type: _selectedType.name,
          photoPath: _photoPath,
          notes: notes,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Produit modifié avec succès'
                  : 'Produit créé avec succès',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le nom du produit est requis';
    }
    if (value.trim().length > 100) {
      return 'Le nom ne doit pas dépasser 100 caractères';
    }
    return null;
  }

  String? _validateBrand(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La marque est requise';
    }
    if (value.trim().length > 100) {
      return 'La marque ne doit pas dépasser 100 caractères';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final title = isEditing ? 'Modifier le produit' : 'Nouveau produit';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPhotoSection(),
              const SizedBox(height: 24),
              _buildNameField(),
              const SizedBox(height: 16),
              _buildBrandField(),
              const SizedBox(height: 16),
              _buildTypeDropdown(),
              const SizedBox(height: 16),
              _buildNotesField(),
              const SizedBox(height: 32),
              _buildSaveButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: GestureDetector(
        onTap: _pickPhoto,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _photoPath != null
                ? FutureBuilder<String>(
                    future: getAbsolutePath(_photoPath!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          backgroundImage: FileImage(File(snapshot.data!)),
                        );
                      }
                      return CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_rounded,
                          size: 48,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_rounded,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      maxLength: 100,
      validator: _validateName,
      decoration: InputDecoration(
        labelText: context.l10n.productFormName,
        hintText: context.l10n.productFormNameHint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildBrandField() {
    return TextFormField(
      controller: _brandController,
      maxLength: 100,
      validator: _validateBrand,
      decoration: InputDecoration(
        labelText: context.l10n.productFormBrand,
        hintText: context.l10n.productFormBrandHint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<ProductType>(
      value: _selectedType,
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedType = value);
        }
      },
      items: ProductType.values
          .map(
            (type) => DropdownMenuItem(
              value: type,
              child: Text(type.labelFr),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        labelText: context.l10n.productFormType,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: _notesController,
      maxLength: 500,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: context.l10n.productFormNotes,
        hintText: 'Ajouter des notes sur ce produit...',
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _isLoading ? null : _submitForm,
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
    );
  }
}
