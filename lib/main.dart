import 'package:family_support_fund/core/providers/app_customization_provider.dart';
import 'package:family_support_fund/core/providers/app_settings_provider.dart';
import 'package:family_support_fund/features/financial_support/providers/support_provider.dart';
import 'package:family_support_fund/features/join_fund/providers/join_request_provider.dart';
import 'package:family_support_fund/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // استيراد الملفات المولّدة

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
         ChangeNotifierProvider(create: (_) => AppSettingsProvider()), // [إضافة]
        ChangeNotifierProvider(create: (_) => SupportProvider()),
          ChangeNotifierProvider(create: (_) => AppCustomizationProvider()),
                  ChangeNotifierProvider(create: (_) => JoinRequestProvider()), // [إضافة]
 

     
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

        final settings = Provider.of<AppSettingsProvider>(context);



    return MaterialApp.router(
      title: 'Family Support Fund',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode, // [تعديل] استخدام الإعدادات
      routerConfig: AppRouter.router,
      //locale: const Locale('ar'),
      locale: settings.locale, 
      // استخدم المندوبين المولّدين تلقائيًا (لاحظ إزالة const)
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // استخدم اللغات المدعومة المولّدة تلقائيًا (لاحظ إزالة const)
      supportedLocales: AppLocalizations.supportedLocales,

    );
  }
}