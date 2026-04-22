//lib/features/join_fund/presentation/widgets/join_form.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class JoinForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const JoinForm({super.key, required this.onSubmit});

  @override
  State<JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryCodeController = TextEditingController(text: '+967');
  final _idController = TextEditingController();
  final _addressController = TextEditingController();

  String? _maritalStatus;
  String? _educationLevel;
  String? _jobStatus;
  List<String>? _attachedFiles;
  bool _acceptedTerms = false;
  final bool _isSubmitting = false;

  final List<String> _maritalOptions = ['أعزب', 'متزوج', 'مطلق', 'أرمل'];
  final List<String> _educationOptions = ['ابتدائي', 'متوسط', 'ثانوي', 'جامعي', 'دراسات عليا'];
  final List<String> _jobOptions = ['موظف', 'عاطل', 'طالب', 'متقاعد', 'ربة منزل'];

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
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب الموافقة على السياسة والخصوصية')),
      );
      return;
    }

    final data = {
      'fullName': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'countryCode': _countryCodeController.text.trim(),
      'idNumber': _idController.text.trim(),
      'maritalStatus': _maritalStatus,
      'educationLevel': _educationLevel,
      'address': _addressController.text.trim(),
      'jobStatus': _jobStatus,
      'attachedFiles': _attachedFiles,
    };

    widget.onSubmit(data);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction, // [إضافة]

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
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: _countryCodeController,
                  label: 'رمز الدولة',
                  prefixIcon: Icons.flag,
                  validator: Validators.countryCode,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: CustomTextField(
                  controller: _phoneController,
                  label: 'رقم الهاتف',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _idController,
            label: 'رقم البطاقة الشخصية / جواز السفر',
            prefixIcon: Icons.badge,
            validator: Validators.idNumber,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'الحالة الاجتماعية',
              prefixIcon: Icon(Icons.people),
            ),
            initialValue: _maritalStatus,
            items: _maritalOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _maritalStatus = val),
            validator: (v) => Validators.required(v, 'الحالة الاجتماعية'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'المؤهل التعليمي',
              prefixIcon: Icon(Icons.school),
            ),
            initialValue: _educationLevel,
            items: _educationOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _educationLevel = val),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _addressController,
            label: 'العنوان',
            prefixIcon: Icons.location_on,
            validator: (v) => Validators.required(v, 'العنوان'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'الحالة الوظيفية',
              prefixIcon: Icon(Icons.work),
            ),
            initialValue: _jobStatus,
            items: _jobOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _jobStatus = val),
          ),
          const SizedBox(height: 16),
          // رفع ملفات
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.upload_file),
            title: const Text('رفع الهوية / ملفات إضافية'),
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
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _acceptedTerms,
            onChanged: (val) => setState(() => _acceptedTerms = val!),
            title: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'أوافق على '),
                  TextSpan(
                    text: 'السياسة والخصوصية',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'تقديم الطلب',
            onPressed: _submit,
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );
  }
}