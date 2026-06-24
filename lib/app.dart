import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';
import 'package:geronimmo_planner/features/dashboard/dashboard_screen.dart';
import 'package:geronimmo_planner/features/calendar/calendar_screen.dart';
import 'package:geronimmo_planner/features/tasks/tasks_screen.dart';
import 'package:geronimmo_planner/features/settings/settings_screen.dart';
import 'package:geronimmo_planner/features/notes/notes_screen.dart';
import 'package:geronimmo_planner/core/theme/app_theme.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

class GeronimmoPlannerApp extends ConsumerWidget {
  const GeronimmoPlannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Geronimmo Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        // We use our custom AppLocalizations + default Material/Cupertino
      ],
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/notes',
          builder: (context, state) => const NotesScreen(),
        ),
      ],
    ),
  ],
);

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final currentPath = GoRouterState.of(context).uri.path;

    final isDesktop = MediaQuery.of(context).size.width > 800;

    final destinations = [
      NavigationDestination(icon: const Icon(Icons.today), label: loc.today),
      NavigationDestination(icon: const Icon(Icons.calendar_month), label: loc.calendar),
      NavigationDestination(icon: const Icon(Icons.checklist), label: loc.tasks),
      NavigationDestination(icon: const Icon(Icons.note_alt_outlined), label: loc.notes),
      NavigationDestination(icon: const Icon(Icons.settings), label: loc.settings),
    ];

    int currentIndex = 0;
    if (currentPath.startsWith('/calendar')) currentIndex = 1;
    if (currentPath.startsWith('/tasks')) currentIndex = 2;
    if (currentPath.startsWith('/notes')) currentIndex = 3;
    if (currentPath.startsWith('/settings')) currentIndex = 4;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0: context.go('/'); break;
                  case 1: context.go('/calendar'); break;
                  case 2: context.go('/tasks'); break;
                  case 3: context.go('/notes'); break;
                  case 4: context.go('/settings'); break;
                }
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary, size: 28),
              unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurfaceVariant),
              destinations: destinations.map((d) => NavigationRailDestination(
                icon: d.icon,
                selectedIcon: Icon((d.icon as Icon).icon, color: Theme.of(context).colorScheme.primary),
                label: Text(d.label, style: const TextStyle(fontWeight: FontWeight.w500)),
              )).toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0: context.go('/'); break;
              case 1: context.go('/calendar'); break;
              case 2: context.go('/tasks'); break;
              case 3: context.go('/notes'); break;
              case 4: context.go('/settings'); break;
            }
          },
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          destinations: destinations,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),
    );
  }
}
