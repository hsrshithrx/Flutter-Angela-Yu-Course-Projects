import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  Future<Position?> getCurrentLocation() async {
    try {
      debugPrint('getCurrentLocation started');

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint('Service enabled: $serviceEnabled');

      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint('Permission: $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          distanceFilter: 100,
        ),
      );
    } catch (e) {
      debugPrint('Location error: $e');
      return null;
    }
  }

  Future<String> getCityName(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks.first;

      return place.locality ??
          place.subAdministrativeArea ??
          place.administrativeArea ??
          place.country ??
          'Unknown location';
    } catch (_) {
      return 'Unknown location';
    }
  }
}

