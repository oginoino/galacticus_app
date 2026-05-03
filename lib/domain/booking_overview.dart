import 'booking_amenity.dart';
import 'booking_date_option.dart';
import 'booking_messages.dart';
import 'booking_space_option.dart';
import 'booking_time_option.dart';
import 'booking_ui_labels.dart';

class BookingOverview {
  const BookingOverview({
    required this.title,
    required this.sectionDateTitle,
    required this.sectionTimeTitle,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.capacityLabel,
    required this.imageAsset,
    required this.priceNote,
    required this.ctaLabel,
    required this.spaceOptions,
    required this.dateOptions,
    required this.timeOptions,
    required this.amenities,
    required this.uiLabels,
    required this.messages,
  });

  final String title;
  final String sectionDateTitle;
  final String sectionTimeTitle;
  final String heroTitle;
  final String heroSubtitle;
  final String capacityLabel;
  final String imageAsset;
  final String priceNote;
  final String ctaLabel;
  final List<BookingSpaceOption> spaceOptions;
  final List<BookingDateOption> dateOptions;
  final List<BookingTimeOption> timeOptions;
  final List<BookingAmenity> amenities;
  final BookingUiLabels uiLabels;
  final BookingMessages messages;
}
