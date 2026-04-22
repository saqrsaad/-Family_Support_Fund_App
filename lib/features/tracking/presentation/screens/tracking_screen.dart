import 'package:family_support_fund/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../join_fund/providers/join_request_provider.dart';
import '../../../../shared/widgets/custom_button.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // نفترض أننا نعرض آخر طلب انضمام (يمكن تطويره لاحقاً)
    return Consumer<JoinRequestProvider>(
      builder: (context, provider, child) {
        final request = provider.currentRequest;
        return Scaffold(
          appBar: CustomAppBar(
            //title: const Text('متابعة الطلبات'),
          ),
          body: request == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد طلبات حالياً',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'تقديم طلب انضمام',
                        onPressed: () {
                          // التنقل إلى شاشة الانضمام
                         // Navigator.of(context).pushNamed('/join-request');
                           context.push(AppRouter.joinRequest);
                        },
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person_add),
                        title: Text(request.fullName),
                        subtitle: Text('رقم الطلب: ${request.id}'),
                        trailing: Chip(
                          label: Text(
                            request.status == 'under_review' ? 'قيد المراجعة' : request.status,
                          ),
                          backgroundColor: Colors.orange.shade100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('تفاصيل الطلب', style: Theme.of(context).textTheme.titleMedium),
                            const Divider(),
                            _buildDetailRow('الاسم', request.fullName),
                            _buildDetailRow('رقم الهاتف', '${request.countryCode}${request.phone}'),
                            _buildDetailRow('تاريخ التقديم', '${request.submittedAt.day}/${request.submittedAt.month}/${request.submittedAt.year}'),
                            _buildDetailRow('الحالة', request.status == 'under_review' ? 'قيد المراجعة' : request.status),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}