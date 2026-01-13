import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(
        AppStrings.appTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          key: AppKeys.homeMenuButton,
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          key: AppKeys.homeSearchButton,
          icon: const Icon(Iconsax.search_normal, color: Colors.white),
          onPressed: () {
            context.router.push(const SearchRoute());
          },
        ),
      ],
      pinned: true,
      floating: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
