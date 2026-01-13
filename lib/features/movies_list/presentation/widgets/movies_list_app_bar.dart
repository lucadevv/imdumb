import 'package:flutter/material.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/widgets/atoms/opacity_overlay.dart';

/// Widget para el AppBar de la lista de películas
class MoviesListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const MoviesListAppBar({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title, key: AppKeys.moviesListTitle),
      leading: IconButton(
        key: AppKeys.moviesListBackButton,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
      ),
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: OpacityOverlay(useThemeColor: true, themeColorOpacity: 0.9),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
