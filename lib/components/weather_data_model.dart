class WeatherDataModel {
  final String city;
  final double temp;
  final String data;
  final int humidity;
  final double feelsLike;
  final double maxTemp;
  final double minTemp;

  WeatherDataModel({
    required this.city,
    required this.temp,
    required this.data,
    required this.humidity,
    required this.feelsLike,
    required this.maxTemp,
    required this.minTemp,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      city: json['name'],
      temp: json['main']['temp'].toDouble(),
      data: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toInt(),
      feelsLike: json['main']['feels_like'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
      
    );
  }
}
