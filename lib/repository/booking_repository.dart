import '../domain/booking_overview.dart';
import '../dto/booking_dto.dart';
import '../service/booking/booking_service_interface.dart';

class BookingRepository {
  BookingRepository(this._service);

  final BookingServiceInterface _service;

  Future<BookingOverview> getBooking() async {
    final json = await _service.fetchBooking();
    return BookingDto.fromJson(json).toDomain();
  }
}
