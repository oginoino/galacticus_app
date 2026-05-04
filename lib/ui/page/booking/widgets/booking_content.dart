import 'package:flutter/material.dart';

import '../../../../domain/booking_overview.dart';
import '../../../theme/app_theme.dart';
import 'booking_widgets.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onSelectionTap,
    required this.onReserveTap,
  });

  final BookingOverview overview;
  final VoidCallback onBackTap;
  final VoidCallback onSelectionTap;
  final VoidCallback onReserveTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingHeader(
          title: overview.title,
          onBackTap: onBackTap,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              0,
              AppSpacing.page,
              AppSpacing.bottomContent,
            ),
            children: [
              const SizedBox(height: AppSpacing.page),
              BookingSpaceToggleRow(
                items: overview.spaceOptions,
                onTap: onSelectionTap,
              ),
              const SizedBox(height: AppSpacing.giant),
              BookingHeroCard(overview: overview),
              Padding(
                padding: AppInsets.bookingSection,
                child: BookingSectionTitle(title: overview.sectionDateTitle),
              ),
              const SizedBox(height: AppSpacing.xl),
              BookingDateRow(
                items: overview.dateOptions,
                onTap: onSelectionTap,
              ),
              Padding(
                padding: AppInsets.bookingSection,
                child: BookingSectionTitle(title: overview.sectionTimeTitle),
              ),
              const SizedBox(height: AppSpacing.xl),
              BookingTimeRow(
                items: overview.timeOptions,
                onTap: onSelectionTap,
              ),
              const SizedBox(height: AppSpacing.xl),
              BookingPriceNote(label: overview.priceNote),
              const SizedBox(height: AppSpacing.page),
              BookingPrimaryButton(
                label: overview.ctaLabel,
                onTap: onReserveTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
