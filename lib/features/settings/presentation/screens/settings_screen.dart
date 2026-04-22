import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/providers/app_settings_provider.dart'; // [إضافة]

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final settings = Provider.of<AppSettingsProvider>(context); // [إضافة]
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        //title: const Text('الإعدادات'),
        /* leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                */ 
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 40,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              auth.userName.isNotEmpty ? auth.userName[0].toUpperCase() : 'U',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            auth.userName,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            auth.userEmail,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Divider(),
          // [تعديل] اللغة مع إمكانية التغيير
         
         ListTile(
              leading: const Icon(Icons.dashboard_customize),
              title: const Text('تخصيص الشريط العلوي'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push('/customization'),
            ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('اللغة'),
            subtitle: Text(
              settings.locale.languageCode == 'ar' ? 'العربية' : 'English',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLanguageDialog(context, settings),
          ),
          // [تعديل] المظهر مع خيارات
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('المظهر'),
            subtitle: Text(_getThemeModeText(settings.themeMode)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showThemeDialog(context, settings),
          ),
          // [تعديل] الإشعارات
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('الإشعارات'),
            value: settings.notificationsEnabled,
            onChanged: (val) => settings.setNotificationsEnabled(val),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('عن التطبيق'),
            onTap: () => _showAboutDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('سياسة الخصوصية'),
            onTap: () => _showPrivacyPolicyDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _confirmLogout(context, auth),
          ),
        ],
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'النظام';
      case ThemeMode.light:
        return 'فاتح';
      case ThemeMode.dark:
        return 'داكن';
      default:
        return '';
    }
  }

  void _showLanguageDialog(BuildContext context, AppSettingsProvider settings) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اختر اللغة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('العربية'),
              leading: Radio<Locale>(
                value: const Locale('ar'),
                groupValue: settings.locale,
                onChanged: (Locale? val) {
                  if (val != null) {
                    settings.setLocale(val);
                    Navigator.pop(ctx);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio<Locale>(
                value: const Locale('en'),
                groupValue: settings.locale,
                onChanged: (Locale? val) {
                  if (val != null) {
                    settings.setLocale(val);
                    Navigator.pop(ctx);
                  }
                },
              ),
            ),

            
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, AppSettingsProvider settings) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اختر المظهر'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('النظام'),
              value: ThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (val) {
                if (val != null) settings.setThemeMode(val);
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('فاتح'),
              value: ThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (val) {
                if (val != null) settings.setThemeMode(val);
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('داكن'),
              value: ThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (val) {
                if (val != null) settings.setThemeMode(val);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('عن التطبيق'),
        content: const SingleChildScrollView(
          child: Text(
            'صندوق دعم الأسرة هو تطبيق تكافلي يهدف إلى تعزيز التضامن الاجتماعي بين الأسر.\n\n'
            'يمكن للمستخدمين الانضمام للصندوق وطلب الدعم المالي عند الحاجة.\n\n'
            'الإصدار: 1.0.0',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('سياسة الخصوصية'),
        content: const SingleChildScrollView(
          child: Text(
            'نحن نحترم خصوصيتك ولا نشارك بياناتك مع أي طرف ثالث.\n\n'
            'يتم استخدام بياناتك فقط لأغراض التكافل داخل الصندوق.\n\n'
            'جميع المعلومات آمنة ومشفرة.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, AuthProvider auth) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              auth.logout();
              context.go(AppRouter.login);
            },
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
