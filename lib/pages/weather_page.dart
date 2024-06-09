import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:sdp4/components/weather_data_model.dart';
import 'package:sdp4/features/fetching_weather_data.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _searchController = TextEditingController();
  String? _searchText;

  /*void signUserOut() {
    FirebaseAuth.instance.signOut();
  }*/

  final _fetchingWeatherData =
      FetchingWeatherData('${dotenv.env['WEATHER_API_KEY']}');
  WeatherDataModel? _weatherData;

  Future<void> _fetchWeather() async {
    String city;
    //String city = await _fetchingWeatherData.getCurrentCity();
    if (_searchText == null) {
      city = await _fetchingWeatherData.getCurrentCity();
    } else {
      city = _searchText![0].toUpperCase() + _searchText!.substring(1);
      /*bodyContent(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height, context);*/
    }

    try {
      final weather = await _fetchingWeatherData.getWeatherData(city);
      setState(() {
        _weatherData = weather;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  String getWeatherAnimation(String? data) {
    if (data == null) {
      return 'assets/Dirigible.json';
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        title: const Text("W E A T H E R"),
        titleTextStyle: const TextStyle(
          color: Color(0xffe2e2e9),
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        centerTitle: true,
        //foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
        child: bodyContent(_width, _height, context),
      ),
    );
  }

  LiquidPullToRefresh bodyContent(
      double _width, double _height, BuildContext context) {
    return LiquidPullToRefresh(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      showChildOpacityTransition: false,
      onRefresh: _fetchWeather,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: _width,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                    child: Text(
                      _weatherData?.city ?? "loading city..",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: _width * 0.55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onTertiary,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          //shadows: [BoxShadow],
                        ),
                        hintText: "Set location..",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        filled: false,
                      ),
                      onSubmitted: (String value) {
                        setState(() {
                          _searchText = _searchController.text;
                          print(_searchText![0].toUpperCase() +
                              _searchText!.substring(1));
                        });
                        _searchController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                //height: _height * 0.4,
                width: _width,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //height: _height * 0.4,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(25),
                      child: Lottie.asset(
                          //width: MediaQuery.of(context).size.width - 30,
                          height: _height * 0.3,
                          fit: BoxFit.contain,
                          getWeatherAnimation(_weatherData?.data)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                          '${_weatherData?.temp.round()}°C   ${_weatherData?.data ?? ""}'),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Container(
                      height: _height * 0.3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 2,
                              child: const Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
