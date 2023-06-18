import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import 'dart:math';
import 'package:great_circle_distance_calculator/great_circle_distance_calculator.dart';

enum InZoneStatus { inside, out, checking }

class LocationController extends GetxController {
  Position? currentPosition;
  var isLoading = false.obs;
  String? currentLocation;
  Rx<double> currentLat = targetLat.obs;
  Rx<double> currentLong = targetLong.obs;
  final inZoneStatus = InZoneStatus.checking.obs;

  static const targetLat = 47.90844313455537;
  static const targetLong = 106.94031407726557;
  static const checkRadius = 1000; // in meters

  // final lat = 47.9054335;
  // final long = 106.9283961;
  // final testLat = 47.9085257;
  // final testLong = 106.9403782;

  Future<Position> getPosition() async {
    LocationPermission? permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng(long, lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

      Placemark place = placemark[0];

      currentLocation =
          "${place.locality}, ${place.street}, ${place.subLocality}, ${place.administrativeArea}, ${place.country}";
      print('Current Location:' + currentLocation!);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading(true);
      update();
      currentPosition = await getPosition();
      currentLat.value = currentPosition!.latitude;
      currentLong.value = currentPosition!.longitude;
      // getAddressFromLatLng(
      //     currentPosition!.longitude, currentPosition!.latitude);
      await checkLocation();

      isLoading(false);
      update();
    } catch (e) {
      print(e);
    }
  }

  checkLocation() async {
    // var gcd = GreatCircleDistance.fromDegrees(
    //     latitude1: lat,
    //     longitude1: long,
    //     latitude2: testLat,
    //     longitude2: testLong);
    // print(
    //     'Distance from location 1 to 2 using the Haversine formula is: ${gcd.haversineDistance()}');
    // print(
    //     'Distance from location 1 to 2 using the Spherical Law of Cosines is: ${gcd.sphericalLawOfCosinesDistance()}');
    // print(
    //     'Distance from location 1 to 2 using the Vicenty`s formula is: ${gcd.vincentyDistance()}');
    // const R = 6371e3;
    // var lat1Pi = lat * pi / 180;
    // var lat2Pi = testLat * pi / 180;
    // var dLatPi = (testLat - lat) * pi / 180;
    // var dLongPi = (testLong - long) * pi / 180;

    // var a = sin(dLatPi / 2) * sin(dLatPi / 2) +
    //     cos(lat1Pi) * cos(lat2Pi) * sin(dLongPi / 2) * sin(dLongPi / 2);
    // var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    // var distance = R * c;
    // print(distance);

    var greatCircleDistance = GreatCircleDistance.fromDegrees(
        latitude1: targetLat,
        longitude1: targetLong,
        latitude2: currentLat.value,
        longitude2: currentLong.value);
    var distance = greatCircleDistance.haversineDistance(); // in meters
    print(distance);

    distance <= checkRadius
        ? inZoneStatus.value = InZoneStatus.inside
        : inZoneStatus.value = InZoneStatus.out;
    print(inZoneStatus.value);
  }
}
