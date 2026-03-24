import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/presentation/screens/home/home_screen.dart';
import 'package:my_skin_routine/presentation/screens/products/product_list_screen.dart';
import 'package:my_skin_routine/presentation/screens/products/product_detail_screen.dart';
import 'package:my_skin_routine/presentation/screens/products/product_form_screen.dart';
import 'package:my_skin_routine/presentation/screens/routines/routine_list_screen.dart';
import 'package:my_skin_routine/presentation/screens/routines/routine_detail_screen.dart';
import 'package:my_skin_routine/presentation/screens/routines/routine_form_screen.dart';
import 'package:my_skin_routine/presentation/screens/routines/action_form_screen.dart';
import 'package:my_skin_routine/presentation/screens/progress/progress_screen.dart';
import 'package:my_skin_routine/presentation/screens/journal/journal_entry_form_screen.dart';
import 'package:my_skin_routine/presentation/screens/settings/settings_screen.dart';
import 'package:my_skin_routine/presentation/widgets/msr_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return MSRScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/products',
              name: 'products',
              builder: (BuildContext context, GoRouterState state) {
                return const ProductListScreen();
              },
              routes: [
                GoRoute(
                  path: 'new',
                  name: 'productNew',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ProductFormScreen();
                  },
                ),
                GoRoute(
                  path: ':id',
                  name: 'productDetail',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return ProductDetailScreen(id: id);
                  },
                ),
                GoRoute(
                  path: ':id/edit',
                  name: 'productEdit',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return ProductFormScreen(id: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/routines',
              name: 'routines',
              builder: (BuildContext context, GoRouterState state) {
                return const RoutineListScreen();
              },
              routes: [
                GoRoute(
                  path: 'new',
                  name: 'routineNew',
                  builder: (BuildContext context, GoRouterState state) {
                    return const RoutineFormScreen();
                  },
                ),
                GoRoute(
                  path: ':id',
                  name: 'routineDetail',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return RoutineDetailScreen(id: id);
                  },
                ),
                GoRoute(
                  path: ':id/edit',
                  name: 'routineEdit',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return RoutineFormScreen(id: id);
                  },
                ),
                GoRoute(
                  path: ':id/actions/new',
                  name: 'actionNew',
                  builder: (BuildContext context, GoRouterState state) {
                    final routineId = int.parse(state.pathParameters['id']!);
                    return ActionFormScreen(routineId: routineId);
                  },
                ),
                GoRoute(
                  path: ':id/actions/:actionId/edit',
                  name: 'actionEdit',
                  builder: (BuildContext context, GoRouterState state) {
                    final routineId = int.parse(state.pathParameters['id']!);
                    final actionId = int.parse(state.pathParameters['actionId']!);
                    return ActionFormScreen(
                      routineId: routineId,
                      actionId: actionId,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/progress',
              name: 'progress',
              builder: (BuildContext context, GoRouterState state) {
                return const ProgressScreen();
              },
              routes: [
                GoRoute(
                  path: 'journal/new',
                  name: 'journalEntryNew',
                  builder: (BuildContext context, GoRouterState state) {
                    return const JournalEntryFormScreen();
                  },
                ),
                GoRoute(
                  path: 'journal/:id',
                  name: 'journalEntryEdit',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return JournalEntryFormScreen(id: id);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          fullscreenDialog: true,
          child: const SettingsScreen(),
        );
      },
    ),
  ],
);
