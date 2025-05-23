import 'package:go_router/go_router.dart';
import 'package:quote_app/features/auth/presentation/auth_page.dart';
import 'package:quote_app/features/home/presentation/home_page.dart';
import 'error_screen.dart';
import 'routes_path.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutePath.auth,
    routes: [
      GoRoute(
        path: AppRoutePath.auth,
        name: AuthPage.routeName,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutePath.home,
        name: HomePage.routeName,
        builder: (context, state) =>
            HomePage(userEmail: state.extra.toString()),
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );

  static GoRouter get router => _router;
}
