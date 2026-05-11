import 'package:flutter/material.dart';
import '../../features/product/domain/product_model.dart';
import '../../features/product/presentation/detail_page.dart';
import '../../features/product/presentation/edit_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/auth/presentation/splash_page.dart';
import '../../features/login/login_page.dart';
import '../../features/home/presentation/home_shell_page.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeShellPage());

      case AppRoutes.detail:
        final args = settings.arguments;
        if (args is Map<String, dynamic> &&
            args['product'] is Product &&
            args['index'] is int) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(
              product: args['product'] as Product,
              index: args['index'] as int,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Product data is missing')),
          ),
        );

      case AppRoutes.edit:
        final args = settings.arguments;
        if (args is Product) {
          return MaterialPageRoute(builder: (_) => EditPage(product: args));
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Product data is missing for edit')),
          ),
        );

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route Not Found'))),
        );
    }
  }
}
