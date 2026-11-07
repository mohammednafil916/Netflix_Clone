import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/core/theme/app_theme.dart';
import 'package:netflix_clone/core/router/app_router.dart';

void main() {
  runApp(ProviderScope(child: NETFLIX()));
}

class NETFLIX extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
