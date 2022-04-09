import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima_weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima_weather_app/services/networking.dart';
import 'location_screen.dart';

const APIkey = '443b1f2686d32f290dfadc644fa06d53';

class Loadingscreen extends StatefulWidget {
  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  double? latitude;
  double? longitude;
  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  void getlocationdata() async {
    Location location = Location();
    await location.getcurrentlocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$APIkey&units=metric');
    var weatherdata = await networkhelper.getdata();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationweather: weatherdata,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

      