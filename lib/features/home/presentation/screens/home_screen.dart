import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../auth/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        //title: const Text('الرئيسية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: الإشعارات
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحباً، ${auth.userName}!',
                          style: textTheme.headlineMedium?.copyWith(color: colorScheme.onPrimary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'معاً نبني تكافلاً أقوى لأسرنا.',
                          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
                    child: Icon(Icons.person, size: 35, color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // بطاقة التكافل
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.volunteer_activism, size: 48, color: colorScheme.primary),
                    const SizedBox(height: 12),
                    Text(
                      'التكافل الاجتماعي',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'يداً بيد ندعم بعضنا البعض. صندوق الأسرة هو مبادرة مجتمعية تهدف إلى تقديم الدعم المالي والمعنوي للأسر المحتاجة.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // الأزرار
            CustomButton(
              text: 'انضم إلى الصندوق',
              icon: Icons.how_to_reg,
              onPressed: () => context.push(AppRouter.joinRequest),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'طلب دعم مالي',
              icon: Icons.attach_money,
              onPressed: () => context.push(AppRouter.supportRequest),
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}