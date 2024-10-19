

import 'package:salama_users/domain/entities/auth/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.lat,
    required super.lng,
  });
  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lat: (json['geometry']['location']['lat'] as num).toDouble(),
        lng: (json['geometry']['location']['lng'] as num).toDouble(),
       
      );
}
