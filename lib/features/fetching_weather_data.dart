import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sdp4/components/weather_data_model.dart';

class FetchingWeatherData {
  static const URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String api;

  FetchingWeatherData(this.api);

  Future<WeatherDataModel> getWeatherData(String city) async {
    final response = await http.get(
      Uri.parse('$URL?q=$city&appid=$api&units=metric')
    );

    if(response.statusCode == 200) {
      return WeatherDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude, position.longitude
    );

    String? city = placemark[0].locality;

    return city ?? "";
  }
}
