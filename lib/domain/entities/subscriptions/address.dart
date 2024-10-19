import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final dynamic longitude;
  final dynamic latitude;
  final dynamic address;
  final dynamic country;
  final dynamic distance;

  const Address(
      {required this.longitude,
      required this.latitude,
      required this.address,
      required this.country,
      required this.distance
      });

  @override
  List<Object?> get props => [longitude, latitude, address, country, distance];
}
