import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/settings/app_settings.dart';
import '../features/age_gate/presentation/age_gate_screen.dart';
import '../features/catalog/presentation/catalog_screen.dart';
import '../features/diary/presentation/diary_screen.dart';
import '../features/settings/presentation/privacy_policy_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/stats/presentation/stats_screen.dart';
import 'shell/app_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/diary',
  refreshListenable: appSettingsStore,
  redirect: (BuildContext context, GoRouterState state) {
    final bool ageConfirmed = appSettingsStore.ageConfirmed;
    final String path = state.uri.path;
    final bool onAgeGate = path == '/age-gate';
    final bool onPrivacy = path == '/privacy';

    if (!ageConfirmed && !onAgeGate && !onPrivacy) {
      return '/age-gate';
    }
    if (ageConfirmed && onAgeGate) {
      return '/diary';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/age-gate',
      builder: (BuildContext context, GoRouterState state) {
        return const AgeGateScreen();
      },
    ),
    GoRoute(
      path: '/privacy',
      builder: (BuildContext context, GoRouterState state) {
        return const PrivacyPolicyScreen();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/diary',
          builder: (BuildContext context, GoRouterState state) {
            return const DiaryScreen();
          },
        ),
        GoRoute(
          path: '/catalog',
          builder: (BuildContext context, GoRouterState state) {
            return const CatalogScreen();
          },
        ),
        GoRoute(
          path: '/stats',
          builder: (BuildContext context, GoRouterState state) {
            return const StatsScreen();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
      ],
    ),
  ],
);
