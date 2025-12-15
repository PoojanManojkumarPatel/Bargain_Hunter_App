import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/firebase_service.dart';

final firebaseService = FirebaseService();

class AddDealPage extends StatefulWidget {
  const AddDealPage({super.key});

  @override
  State<AddDealPage> createState() => _AddDealPageState();
}

class _AddDealPageState extends State<AddDealPage> {
  final _formKey = GlobalKey<FormState>();
  final _productController = TextEditingController();
  final _storeController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _discountedPriceController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _endDate;
  File? _selectedImage;

  Future<void> _pickImage() async {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (picked != null) {
                setState(() {
                  _selectedImage = File(picked.path);
                });
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () async {
              final picked = await ImagePicker().pickImage(source: ImageSource.camera);
              if (picked != null) {
                setState(() {
                  _selectedImage = File(picked.path);
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}



  void _submit() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Optional: show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Upload image if selected
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await firebaseService.uploadDealImage(_selectedImage!);
      }

      // Save deal to Firestore
      await firebaseService.saveDeal(
        title: _productController.text.trim(),
        store: _storeController.text.trim(),
        discountedPrice: double.parse(_discountedPriceController.text),
        originalPrice: _originalPriceController.text.isNotEmpty
            ? double.tryParse(_originalPriceController.text)
            : null,
        endDate: _endDate ?? DateTime.now().add(const Duration(days: 3)),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        imageUrl: imageUrl,
      );

      Navigator.pop(context); // remove loading
      Navigator.pop(context); // return to Home

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deal added successfully!")),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Deal")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: _selectedImage == null
                      ? const Center(child: Text("Tap to select image"))
                      : Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _productController,
                decoration: const InputDecoration(labelText: "Product Name*"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _storeController,
                decoration: const InputDecoration(labelText: "Store Name*"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _originalPriceController,
                decoration: const InputDecoration(labelText: "Original Price"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _discountedPriceController,
                decoration:
                    const InputDecoration(labelText: "Discounted Price*"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      _endDate == null
                          ? "When does the deal end? "
                          : "Ends: ${_endDate!.toLocal().toString().split(' ')[0]}",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 3)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          _endDate = picked;
                        });
                      }
                    },
                    child: const Text("date"),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
