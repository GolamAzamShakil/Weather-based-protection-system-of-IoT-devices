import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:sdp4/components/weather_data_model.dart';
import 'package:sdp4/features/fetching_weather_data.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  /*void signUserOut() {
    FirebaseAuth.instance.signOut();
  }*/

  final _fetchingWeatherData =
      FetchingWeatherData('${dotenv.env['API_KEY']}');
  WeatherDataModel? _weatherData;

  _fetchWeather() async {
    String city = await _fetchingWeatherData.getCurrentCity();

    try {
      final weather = await _fetchingWeatherData.getWeatherData("Dhaka");
      setState(() {
        _weatherData = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? data) {
    if (data == null) {
      return 'assets/';
    }

    switch (data.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
        return 'assets/Cloudy Day Blue Shaded.json';
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/partly cloudy-day-haze.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rain.json';
      case 'thunderstorm':
        return 'assets/Weather-storm.json';
      case 'clear':
        return 'assets/Sun Lottie.json';
      default:
        return 'assets/Sun Lottie.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("W E A T H E R")),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        elevation: 0,
        /*actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],*/
      ),
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(right: 50.0, left: 3.5),
                child: Text(_weatherData?.city ?? "loading city.."),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(getWeatherAnimation(_weatherData?.data)),
                      Text('${_weatherData?.temp.round()}°C'),
                      Text(_weatherData?.data ?? ""),
                      const SizedBox(height: 5),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.teal[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Lottie.asset('horizon.json'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      infoCard(
                                          title: "Humidity",
                                          value: "${_weatherData?.humidity}"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Lottie.asset(''),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      infoCard(
                                          title: "Feels like",
                                          value: "${_weatherData?.feelsLike}"),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Lottie.asset('Thermometer Hot.json'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      infoCard(
                                          title: "Max temp",
                                          value: "${_weatherData?.maxTemp}"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Lottie.asset('Thermometer Cold.json'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      infoCard(
                                          title: "Min temp",
                                          value: "${_weatherData?.minTemp}"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

Column infoCard({required String title, required dynamic value}) {
  return Column(
    children: [
      Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      )
    ],
  );
}
