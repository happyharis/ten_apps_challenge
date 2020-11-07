import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ten_apps_challenge/weather_app/country.dart';
import 'package:ten_apps_challenge/weather_app/weather.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final searchController = TextEditingController();
  Future<List<Country>> getCountries;
  Weather weather;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Search country'),
                  controller: searchController,
                ),
                SizedBox(height: 30),
                if (weather != null) ...[
                  Text(
                    weather.title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 30),
                  Text(
                    weather.consolidatedWeather.first.weatherStateName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Max'),
                          Text(
                            weather.consolidatedWeather.first.maxTemp
                                .round()
                                .toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Text('Min'),
                          Text(
                            weather.consolidatedWeather.first.minTemp
                                .round()
                                .toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                if (weather == null)
                  FutureBuilder<List<Country>>(
                    future: getCountries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Country not found'));
                      }
                      if (snapshot?.data == null) {
                        return Center(child: Text('Search a country'));
                      }

                      return Column(
                        children: [
                          Text(
                            'Choose your country',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 30),
                          for (var country in snapshot.data)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  fetchWeather(country.woeid.toString())
                                      .then((value) {
                                    setState(() {
                                      weather = value;
                                    });
                                  });
                                },
                                child: Text(country.title),
                              ),
                            )
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              weather = null;
              getCountries = fetchCountries(searchController.text);
            });
          },
          child: Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}

Future<List<Country>> fetchCountries(String country) async {
  final response = await http
      .get('https://www.metaweather.com/api/location/search/?query=$country');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return countryFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Weather> fetchWeather(String woeId) async {
  final response =
      await http.get('https://www.metaweather.com/api/location/$woeId');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return weatherFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
