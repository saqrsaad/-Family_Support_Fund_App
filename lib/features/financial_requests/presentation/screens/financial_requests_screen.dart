// lib/features/financial_requests/presentation/screens/financial_requests_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../core/routes/app_router.dart';
import '../../../financial_support/providers/support_provider.dart';

class FinancialRequestsScreen extends StatelessWidget {
  const FinancialRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer<SupportProvider>(
        builder: (context, provider, child) {
          final requests = provider.requests;

          if (requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد طلبات دعم مالي',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'طلب دعم جديد',
                    onPressed: () => context.pushNamed(AppRouter.supportRequest),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (ctx, index) {
              final req = requests[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ رقم التتبع بارز
                      Row(
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'رقم التتبع: ${req.trackingNumber}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(req.type, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(
                            '${req.amount.toStringAsFixed(2)} ريال',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(req.description, style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاريخ التقديم: ${req.submittedAt.toString().substring(0, 10)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          _buildStatusChip(context, req.status),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    String text;
    Color color;
    switch (status) {
      case 'pending':
        text = 'قيد المراجعة';
        color = Colors.orange;
        break;
      case 'approved':
        text = 'مقبول';
        color = Colors.green;
        break;
      case 'rejected':
        text = 'مرفوض';
        color = Colors.red;
        break;
      default:
        text = status;
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}