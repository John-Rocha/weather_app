class Constants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'ac092e7a6b4431c1c3f27cb493eb616d';
  static const String units = 'metric';

  static String currentWeatherByName(String cityName) {
    return '$baseUrl/weather?q=$cityName&units=$units&appid=$apiKey';
  }

  static String weatherIcon(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
