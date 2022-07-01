import 'package:book_a_hall_admin_app/constants/constants.dart';

class HallModel {
  final String? hallName;
  final String? hallAddress;
  final String? ratePerPerson;
  final String? maxCapacity;
  final List<dynamic>? hallFeatures;
  List<dynamic>? hallImages = [];
  final String? hallId;

  HallModel(
      {this.hallFeatures,
      this.hallAddress,
      this.hallName,
      this.hallId,
      this.maxCapacity,
      this.hallImages,
      this.ratePerPerson});

  Map<String, dynamic> asMap() {
    return {
      kHallName: hallName,
      kHallAddress: hallAddress,
      kHallFeatures: hallFeatures,
      kMaxCapacity: maxCapacity,
      kRatePerPerson: ratePerPerson,
      kHallImages:hallImages,
      kHallId:hallId,
    };
  }
}
