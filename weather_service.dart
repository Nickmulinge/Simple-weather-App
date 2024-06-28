import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  static const _apiKey = 'e88cc0ddfcbf7fc934525815e34618f0';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather?> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      return null;
    }
  }
}
