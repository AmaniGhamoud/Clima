import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  double longitude=0;
  double latitude=0;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude ;
      latitude = position.latitude ;
    }
    catch (e) {
      print(e);}

  }



}





