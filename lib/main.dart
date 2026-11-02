import 'package:flutter/material.dart';

void main() {
  runApp(NETFLIX());
}

class NETFLIX extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}
