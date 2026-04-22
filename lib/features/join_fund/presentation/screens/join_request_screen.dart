// lib /features/join_fund/presentation/screens/join_request_screen.dart
import 'package:family_support_fund/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../widgets/join_form.dart';
import '../../providers/join_request_provider.dart';

class JoinRequestScreen extends StatelessWidget {
  const JoinRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JoinRequestProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.clearRequest();
    });

    return Consumer<JoinRequestProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          message: '!جاري إرسال الطلب...',
          child: Scaffold(
            appBar: CustomAppBar(
              // title: const Text('طلب الانضمام'),
              /* leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ), */
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: JoinForm(
                  onSubmit: (data) async {
                    final success = await provider.submitJoinRequest(
                      fullName: data['fullName']!,
                      phone: data['phone']!,
                      countryCode: data['countryCode']!,
                      idNumber: data['idNumber']!,
                      maritalStatus: data['maritalStatus'],
                      educationLevel: data['educationLevel'],
                      address: data['address'],
                      jobStatus: data['jobStatus'],
                      attachedFiles: data['attachedFiles']?.cast<String>(),
                    );

                     /*   if (!context.mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إرسال الطلب بنجاح'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );

                      provider.clearForm();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (context.mounted) {
                          context.goNamed(AppRouter.home);
                        }
                      });
*/

                    if (success && provider.currentRequest != null) {
                      // الانتقال إلى صفحة حالة الطلب مع تمرير البيانات
                     
                      context.pushNamed(
                        AppRouter.requestStatus,
                        extra: {
                          'requestId': provider.currentRequest!.id,
                          'fullName': provider.currentRequest!.fullName,
                          'email': Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).userEmail,
                          'phone':
                              '${provider.currentRequest!.countryCode}${provider.currentRequest!.phone}',
                          'status': provider.currentRequest!.status,
                        },
                      );
                    
                      
                    
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
    );
  }
}
