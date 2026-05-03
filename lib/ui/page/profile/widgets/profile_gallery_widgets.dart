import 'package:flutter/material.dart';

import '../../../../domain/profile_gallery_item.dart';
import '../../../theme/app_theme.dart';

class ProfileGalleryGrid extends StatelessWidget {
  const ProfileGalleryGrid({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<ProfileGalleryItem> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.giant,
        mainAxisSpacing: AppSpacing.giant,
        childAspectRatio: AppSize.profileGalleryAspectRatio,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSize.profileGalleryRadius),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.profileGalleryRadius),
            child: Image.asset(
              item.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
