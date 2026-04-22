import 'package:family_support_fund/features/financial_requests/presentation/screens/financial_requests_screen.dart';
import 'package:family_support_fund/features/settings/presentation/screens/customization_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/join_fund/presentation/screens/join_request_screen.dart';
import '../../features/join_fund/presentation/screens/request_status_screen.dart';
import '../../features/tracking/presentation/screens/tracking_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/financial_support/presentation/screens/support_request_screen.dart';
import '../../shared/widgets/main_scaffold.dart';

class AppRouter {
  static const String login = '/login';
  static const String home = '/home';
  static const String joinRequest = '/join-request';
  static const String requestStatus = '/request-status';
  static const String supportRequest = '/support-request';
  static const String tracking = '/tracking';
  static const String settings = '/settings';
  static const String financialRequests = '/financial-requests';
  static const String customization = '/customization';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: tracking,
                name: 'tracking',
                builder: (context, state) => const TrackingScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: financialRequests,
                name: 'financial-requests',
                builder: (context, state) => const FinancialRequestsScreen(),
              ),
            ],
          ), // [إضافة]

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settings,
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: joinRequest,
        name: 'join-request',
        builder: (context, state) => const JoinRequestScreen(),
      ),
      GoRoute(
        path: requestStatus,
        name: 'request-status',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return RequestStatusScreen(requestData: extra);
        },
      ),

     
      GoRoute(
        path: supportRequest,
        name: 'support-request',
        builder: (context, state) => const SupportRequestScreen(),
      ),
      GoRoute(
        path: customization,
        builder: (context, state) => const CustomizationScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('صفحة غير موجودة: ${state.uri}'))),
  );
}
