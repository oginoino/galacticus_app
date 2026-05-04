import '../domain/booking_amenity.dart';
import '../domain/booking_date_option.dart';
import '../domain/booking_messages.dart';
import '../domain/booking_overview.dart';
import '../domain/booking_space_option.dart';
import '../domain/booking_time_option.dart';
import '../domain/booking_ui_labels.dart';

class BookingDto {
  BookingDto({
    required this.payload,
  });

  factory BookingDto.fromJson(Map<String, dynamic> json) {
    return BookingDto(payload: json);
  }

  final Map<String, dynamic> payload;

  BookingOverview toDomain() {
    final uiLabels = payload['uiLabels'] as Map<String, dynamic>;
    final messages = payload['messages'] as Map<String, dynamic>;

    return BookingOverview(
      title: payload['title'] as String,
      sectionDateTitle: payload['sectionDateTitle'] as String,
      sectionTimeTitle: payload['sectionTimeTitle'] as String,
      heroTitle: payload['heroTitle'] as String,
      heroSubtitle: payload['heroSubtitle'] as String,
      capacityLabel: payload['capacityLabel'] as String,
      imageAsset: payload['imageAsset'] as String,
      priceNote: payload['priceNote'] as String,
      ctaLabel: payload['ctaLabel'] as String,
      spaceOptions: _mapList(
        payload['spaceOptions'] as List<dynamic>,
        (item) => BookingSpaceOption(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      dateOptions: _mapList(
        payload['dateOptions'] as List<dynamic>,
        (item) => BookingDateOption(
          weekdayLabel: item['weekdayLabel'] as String,
          dayLabel: item['dayLabel'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      timeOptions: _mapList(
        payload['timeOptions'] as List<dynamic>,
        (item) => BookingTimeOption(
          label: item['label'] as String,
          isSelected: item['isSelected'] as bool,
        ),
      ),
      amenities: _mapList(
        payload['amenities'] as List<dynamic>,
        (item) => BookingAmenity(
          type: item['type'] as String,
          label: item['label'] as String,
        ),
      ),
      uiLabels: BookingUiLabels(
        navigationHomeLabel: uiLabels['navigationHomeLabel'] as String,
        navigationFeedLabel: uiLabels['navigationFeedLabel'] as String,
        navigationClubsLabel: uiLabels['navigationClubsLabel'] as String,
        navigationProfileLabel: uiLabels['navigationProfileLabel'] as String,
      ),
      messages: BookingMessages(
        quickAction: messages['quickAction'] as String,
        reserveAction: messages['reserveAction'] as String,
        selectionAction: messages['selectionAction'] as String,
      ),
    );
  }

  List<T> _mapList<T>(
    List<dynamic> source,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    return source
        .cast<Map<String, dynamic>>()
        .map(mapper)
        .toList(growable: false);
  }
}
