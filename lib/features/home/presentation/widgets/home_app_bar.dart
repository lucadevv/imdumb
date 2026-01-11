import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(
        "IMDUMB",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      pinned: true,
      floating: false,
    );
  }
}
