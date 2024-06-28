import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  String _error = '';

  void _getWeather() async {
    final city = _cityController.text;
    final weather = await WeatherService.fetchWeather(city);
    if (weather == null) {
      setState(() {
        _error = 'City not found';
        _weather = null;
      });
    } else {
      setState(() {
        _error = '';
        _weather = weather;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: 'Enter city name',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _getWeather,
                      child: Text('Search'),
                    ),
                    if (_weather != null) ...[
                      SizedBox(height: 20),
                      Text(
                        _weather!.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.wb_sunny,
                        size: 40,
                        color: Colors.amber,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${_weather!.temperature}°C',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humidity: ${_weather!.humidity}%',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Wind Speed: ${_weather!.windSpeed} km/h',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                    if (_error.isNotEmpty)
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
