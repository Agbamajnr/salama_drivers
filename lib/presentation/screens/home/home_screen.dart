import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:action_slider/action_slider.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/screens/home/booking_details_page.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';
import '../../../core/formatter/formatter.dart';
import '../../../core/routes/router_names.dart';
import '../../../domain/entities/subscriptions/booking.dart';
import '../../widgets/empty_placeholder.dart';
import '../others/booking_details_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool active = false;
  final _controller = ActionSliderController();
  late GoogleMapController mapController;

  LatLng? _currentLocation;
  bool _isLoading = true;

  // Fallback location: Calabar, Nigeria
  final LatLng _fallbackLocation = const LatLng(4.9757, 8.3417);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, use fallback location
      setState(() {
        _currentLocation = _fallbackLocation;
        _isLoading = false;
      });
      return;
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, use fallback location
        setState(() {
          _currentLocation = _fallbackLocation;
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, use fallback location
      setState(() {
        _currentLocation = _fallbackLocation;
        _isLoading = false;
      });
      return;
    }

    // Fetch the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        logger.d(_currentLocation);
        _isLoading = false;
      });
    } catch (e) {
      // If an error occurs (e.g., timeout), use fallback location
      setState(() {
        _currentLocation = _fallbackLocation;
        _isLoading = false;
      });
      logger.e("Error fetching location: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1.0, // Full screen height
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _fallbackLocation, // Use fallback location if current location is null
                zoom: 17.0,
              ),
              myLocationEnabled: true, // Show the user's location on the map
              myLocationButtonEnabled: true, // Show the "my location" button
              markers: _currentLocation != null
                  ? {
                Marker(
                  markerId: const MarkerId("user_location"),
                  position: _currentLocation!,
                  infoWindow: const InfoWindow(title: "Your Current Location"),
                ),
              }
                  : {},
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}