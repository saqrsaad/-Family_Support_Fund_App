import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/app_customization_provider.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({super.key});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final customization = Provider.of<AppCustomizationProvider>(
      context,
      listen: false,
    );
    _titleController.text = customization.appBarTitle;
  }

  @override
  Widget build(BuildContext context) {
    final customization = Provider.of<AppCustomizationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('تخصيص الواجهة')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _titleController,
              label: 'اسم الصندوق  ',
              prefixIcon: Icons.title,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'حفظ الاسم',
              onPressed: () {
                customization.setAppBarTitle(_titleController.text);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('تم حفظ الاسم')));
              },
              isSecondary: true,
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'شعار التطبيق',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // في مكان عرض الصورة
                    if (customization.logoBytes != null)
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50), // دائري
                        ),
                        child: ClipOval(
                          child: Image.memory(
                            customization.logoBytes!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.family_restroom,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => customization.pickAndSetLogo(),
                          icon: const Icon(Icons.upload),
                          label: const Text('اختر صورة'),
                        ),
                        if (customization.logoBase64 != null)
                          ElevatedButton.icon(
                            onPressed: () => customization.removeLogo(),
                            icon: const Icon(Icons.delete),
                            label: const Text('إزالة'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
