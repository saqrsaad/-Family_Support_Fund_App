//lib/features/financial_support/presentation/screens/support_request_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../widgets/support_form.dart';
import '../../providers/support_provider.dart';

class SupportRequestScreen extends StatelessWidget {
  const SupportRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SupportProvider(),
      child: Consumer<SupportProvider>(
        builder: (context, provider, child) {
          return LoadingOverlay(
            isLoading: provider.isLoading,
            message: 'جاري إرسال الطلب...',
            child: Scaffold(
              appBar: CustomAppBar(
             ///   title: const Text('طلب دعم مالي'),
                /* leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ), */
                
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: SupportForm(
                    onSubmit: (data) async {
                      final request = await provider.submitSupportRequest(
                        name: data['name']!,
                        amount: double.parse(data['amount']!),
                        description: data['description']!,
                        type: data['type']!,
                        attachedFiles: data['attachedFiles']?.cast<String>(),
                      );
                      if (request != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم تقديم الطلب بنجاح. رقم الطلب: ${request.id}'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(provider.error ?? 'حدث خطأ ما'),
                            backgroundColor: Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}