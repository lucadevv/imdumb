import 'package:flutter/material.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/widgets/atoms/opacity_overlay.dart';

/// Widget para el AppBar de búsqueda
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onQueryChanged;
  final VoidCallback? onBackPressed;

  const SearchAppBar({
    super.key,
    required this.searchController,
    this.onQueryChanged,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: TextField(
        key: AppKeys.searchTextField,
        controller: searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Buscar películas...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: context.appColor.onSurfaceVariant,
          ),
        ),
        style: TextStyle(
          color: context.appColor.onSurface,
        ),
        onChanged: onQueryChanged,
      ),
      leading: IconButton(
        key: AppKeys.searchBackButton,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
      ),
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: OpacityOverlay(
          useThemeColor: true,
          themeColorOpacity: 0.9,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
