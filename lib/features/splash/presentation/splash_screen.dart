import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.router.replace(HomeRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Center(child: Text("IMDUMB", style: TextStyle())),
      ),
    );
  }
}
