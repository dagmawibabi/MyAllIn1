import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class WeatherBottomSheet extends StatefulWidget {
  const WeatherBottomSheet({
    super.key,
    required this.weatherData,
  });

  final Map weatherData;

  @override
  State<WeatherBottomSheet> createState() => _WeatherBottomSheetState();
}

class _WeatherBottomSheetState extends State<WeatherBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.grey[900]!,
                      // border: Border.all(
                      //   color: Colors.grey[850]!,
                      // ),
                      // border: Border(
                      //   top: BorderSide(
                      //     color: Colors.grey[850]!,
                      //   ),
                      // ),
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(20.0),
                      // ),
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "https:" + widget.weatherData["current"]["condition"]["icon"],
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                      ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),

                      // Back Button
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900]!,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),
                      Container(
                        width: 80.0,
                        height: 80.0,
                        child: Hero(
                          tag: "weatherIcon",
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: "https:" +
                                widget.weatherData["current"]["condition"]
                                    ["icon"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.grey[800]!,
                                strokeWidth: 2.0,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error_outline,
                            ),
                          ),
                          // Image.network(
                          //   "https:" +
                          //       widget.weatherData["current"]["condition"]["icon"],
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      Text(
                        widget.weatherData["current"]["temp_c"].toString() +
                            " °C",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.weatherData["current"]["condition"]["text"],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Sunrise and Sunset
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sunrise",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                        ["forecastday"][0]["astro"]["sunrise"],
                                    style: TextStyle(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.wb_sunny_outlined,
                              size: 40.0,
                            ),
                            Container(
                              width: 140.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Sunset",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                        ["forecastday"][0]["astro"]["sunset"],
                                    style: TextStyle(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // Weather Details
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Temp
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.thermometer_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["temp_c"]
                                              .toString() +
                                          " °C",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // Wind
                                Column(
                                  children: [
                                    Icon(
                                      Icons.wind_power_outlined,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["wind_kph"]
                                              .toString() +
                                          " kph",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // Precipitation
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.water_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["precip_mm"]
                                              .toString() +
                                          " mm",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // UV
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.sunny_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["uv"]
                                              .toString() +
                                          " uvi",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Cloud
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.cloud_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["cloud"]
                                              .toString() +
                                          " %",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // Change of rain
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.rainy_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["forecast"]
                                                  ["forecastday"][0]["day"]
                                                  ["daily_chance_of_rain"]
                                              .toString() +
                                          " %",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // Change of snow
                                Column(
                                  children: [
                                    Icon(
                                      Ionicons.snow_outline,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["forecast"]
                                                  ["forecastday"][0]["day"]
                                                  ["daily_chance_of_snow"]
                                              .toString() +
                                          " %",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                                // Humidity
                                Column(
                                  children: [
                                    Icon(
                                      Icons.bubble_chart_outlined,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      widget.weatherData["current"]["humidity"]
                                              .toString() +
                                          " %",
                                      style: TextStyle(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // Moonrise and Moonset
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850]!.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Moonrise",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                        ["forecastday"][0]["astro"]["moonrise"],
                                    style: TextStyle(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    "Phase",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                            ["forecastday"][0]["astro"]
                                        ["moon_phase"],
                                    style: TextStyle(
                                      // fontSize: 12.0,
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Ionicons.moon_outline,
                              size: 35.0,
                            ),
                            Container(
                              width: 150.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Moonset",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                        ["forecastday"][0]["astro"]["moonset"],
                                    style: TextStyle(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "Illumination",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.weatherData["forecast"]
                                                ["forecastday"][0]["astro"]
                                            ["moon_illumination"] +
                                        " %",
                                    style: TextStyle(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      // Location
                      Text(
                        "Lat: " +
                            widget.weatherData["location"]["lat"].toString() +
                            "  Lon: " +
                            widget.weatherData["location"]["lon"].toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[700]!,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        widget.weatherData["location"]["name"] +
                            ", " +
                            widget.weatherData["location"]["country"],
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[700]!,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
