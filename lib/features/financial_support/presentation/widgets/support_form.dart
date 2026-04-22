//lib/features/financial_support/presentation/widgets/support_form.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class SupportForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const SupportForm({super.key, required this.onSubmit});

  @override
  State<SupportForm> createState() => _SupportFormState();
}

class _SupportFormState extends State<SupportForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _type = 'منحة';
  List<String>? _attachedFiles;
  final bool _isSubmitting = false;

  final List<String> _types = ['منحة', 'قرض'];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _attachedFiles = result.files.map((f) => f.name).toList();
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'name': _nameController.text.trim(),
      'amount': _amountController.text.trim(),
      'description': _descriptionController.text.trim(),
      'type': _type,
      'attachedFiles': _attachedFiles,
    };
    widget.onSubmit(data);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'الاسم الكامل',
            prefixIcon: Icons.person,
            validator: Validators.name,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _amountController,
            label: 'المبلغ المطلوب',
            prefixIcon: Icons.attach_money,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: Validators.amount,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'نوع الطلب',
              prefixIcon: Icon(Icons.category),
            ),
            initialValue: _type,
            items: _types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _type = val!),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _descriptionController,
            label: 'سبب الطلب (وصف)',
            prefixIcon: Icons.description,
            maxLines: 3,
            validator: (v) => Validators.required(v, 'الوصف'),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.upload_file),
            title: const Text('رفع ملفات داعمة'),
            subtitle: const Text('اختياري'),
            trailing: IconButton(
              icon: const Icon(Icons.cloud_upload),
              onPressed: _pickFiles,
            ),
          ),
          if (_attachedFiles != null && _attachedFiles!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: _attachedFiles!
                    .map((f) => Chip(
                          label: Text(f),
                          onDeleted: () {
                            setState(() => _attachedFiles!.remove(f));
                          },
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'تقديم طلب الدعم',
            onPressed: _submit,
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );
  }
}