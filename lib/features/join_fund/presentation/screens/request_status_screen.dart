import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_button.dart';

class RequestStatusScreen extends StatelessWidget {
  final Map<String, dynamic> requestData;

  const RequestStatusScreen({super.key, required this.requestData});

  String _getStatusText(String status) {
    switch (status) {
      case 'under_review':
        return 'قيد المراجعة';
      case 'approved':
        return 'مقبول';
      case 'rejected':
        return 'مرفوض';
      default:
        return 'قيد الانتظار';
    }
  }

  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status) {
      case 'under_review':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return colorScheme.error;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final status = requestData['status'] ?? 'pending';

    return Scaffold(
      appBar: CustomAppBar(
        // title: const Text('حالة الطلب'),
       /*  leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/home'),
        ), */
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.hourglass_bottom,
                      size: 64,
                      color: _getStatusColor(status, colorScheme),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'رقم الطلب: ${requestData['requestId']}',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          status,
                          colorScheme,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getStatusText(status),
                        style: textTheme.titleMedium?.copyWith(
                          color: _getStatusColor(status, colorScheme),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow('الاسم', requestData['fullName']),
                    const Divider(),
                    _buildInfoRow('البريد الإلكتروني', requestData['email']),
                    const Divider(),
                    _buildInfoRow('رقم الهاتف', requestData['phone']),
                    const SizedBox(height: 24),
                    Text(
                      'سيتم مراجعة طلبك من قبل الإدارة، وستتغير الحالة تلقائياً عند الانتهاء.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'العودة للرئيسية',
              onPressed: () => context.go('/home'),
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
