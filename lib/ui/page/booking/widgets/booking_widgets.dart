import 'package:flutter/material.dart';

import '../../../../domain/booking_amenity.dart';
import '../../../../domain/booking_date_option.dart';
import '../../../../domain/booking_overview.dart';
import '../../../../domain/booking_space_option.dart';
import '../../../../domain/booking_time_option.dart';
import '../../../theme/app_theme.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({
    super.key,
    required this.title,
    required this.onBackTap,
  });

  final String title;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: EdgeInsets.only(top: topInset + AppSpacing.lg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onBackTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: AppSize.bookingTopAction,
                height: AppSize.bookingTopAction,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.surfaceAlt,
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                    width: AppStroke.hairline,
                  ),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: AppPalette.white,
                  size: AppIconSize.huge,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.heading,
                    letterSpacing: AppLetterSpacing.tightSm,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingSpaceToggleRow extends StatelessWidget {
  const BookingSpaceToggleRow({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<BookingSpaceOption> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: item == items.last ? 0 : AppSpacing.xl,
                ),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                  child: Container(
                    height: AppSize.bookingToggleHeight,
                    decoration: BoxDecoration(
                      color: item.isSelected ? AppPalette.white : AppPalette.surfaceAlt,
                      borderRadius: BorderRadius.circular(AppRadius.xxl),
                      border: Border.all(
                        color: item.isSelected
                            ? AppPalette.white
                            : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                        width: AppStroke.hairline,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: item.isSelected
                                ? AppPalette.black
                                : AppPalette.textMuted,
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSize.titleSm,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class BookingHeroCard extends StatelessWidget {
  const BookingHeroCard({
    super.key,
    required this.overview,
  });

  final BookingOverview overview;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        height: AppSize.bookingHeroHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              overview.imageAsset,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.medium),
                      AppPalette.black.withValues(alpha: AppOpacity.scrim),
                    ],
                    stops: const [0.22, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppInsets.bookingHeroOverlay.left,
              right: AppInsets.bookingHeroOverlay.right,
              bottom: AppInsets.bookingHeroOverlay.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overview.heroTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.displaySm,
                          letterSpacing: AppLetterSpacing.tightSm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    overview.heroSubtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppPalette.textMuted,
                          fontSize: AppFontSize.titleSm,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.giant,
                    runSpacing: AppSpacing.sm,
                    children: overview.amenities
                        .map((item) => _BookingAmenityTag(item: item))
                        .toList(growable: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingSectionTitle extends StatelessWidget {
  const BookingSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.titleLg,
          ),
    );
  }
}

class BookingDateRow extends StatelessWidget {
  const BookingDateRow({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<BookingDateOption> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.bookingDateCardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xl),
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            child: Container(
              width: AppSize.bookingDateCardWidth,
              height: AppSize.bookingDateCardHeight,
              decoration: BoxDecoration(
                color: item.isSelected ? AppPalette.primary : AppPalette.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.xxl),
                border: Border.all(
                  color: item.isSelected
                      ? AppPalette.primary
                      : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  width: AppStroke.hairline,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.weekdayLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: item.isSelected
                              ? AppPalette.black
                              : AppPalette.textMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.labelLg,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.dayLabel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: item.isSelected
                              ? AppPalette.black
                              : AppPalette.textMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: AppFontSize.heading,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookingTimeRow extends StatelessWidget {
  const BookingTimeRow({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<BookingTimeOption> items;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.xl,
      children: items
          .map(
            (item) => InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.xxl),
              child: Container(
                width: AppSize.bookingDateCardWidth,
                height: AppSize.bookingTimeChipHeight,
                decoration: BoxDecoration(
                  color: item.isSelected ? AppPalette.white : AppPalette.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                  border: Border.all(
                    color: item.isSelected
                        ? AppPalette.white
                        : AppPalette.white.withValues(alpha: AppOpacity.xxs),
                    width: AppStroke.hairline,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: item.isSelected
                            ? AppPalette.black
                            : AppPalette.textMuted,
                        fontWeight: FontWeight.w500,
                        fontSize: AppFontSize.titleSm,
                      ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class BookingPriceNote extends StatelessWidget {
  const BookingPriceNote({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.bodySm,
              ),
        ),
      ),
    );
  }
}

class BookingPrimaryButton extends StatelessWidget {
  const BookingPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.buttonHeight,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: AppPalette.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.cardXl),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.title,
          ),
        ),
      ),
    );
  }
}

class _BookingAmenityTag extends StatelessWidget {
  const _BookingAmenityTag({
    required this.item,
  });

  final BookingAmenity item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _iconForType(item.type),
          color: AppPalette.textMuted,
          size: AppIconSize.sm,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          item.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppPalette.textMuted,
                fontSize: AppFontSize.body,
              ),
        ),
      ],
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'people':
        return Icons.people_alt_outlined;
      case 'wifi':
        return Icons.wifi_outlined;
      case 'tv':
        return Icons.tv_outlined;
      case 'coffee':
        return Icons.local_cafe_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }
}
