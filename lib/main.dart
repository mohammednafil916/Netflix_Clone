import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/core/theme/app_theme.dart';
import 'package:netflix_clone/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: NETFLIX()));
}

class NETFLIX extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: HomeScreen(),
    );
  }
}
