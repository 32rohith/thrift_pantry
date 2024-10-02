// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Ensure you have the correct package imported

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<Map<String, double>> locations = [
    {'latitude': 13.067439, 'longitude': 80.237617},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Locations'),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        centerTitle: true,
      ),
      
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(13.067439, 80.237617), // Center the map over London
          initialZoom: 13,
        ),
        children: [
          TileLayer( // Display map tiles from any source
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            userAgentPackageName: 'com.example.app',
            // And many more recommended properties!
          ),
          const RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
              ),
              // Also add images...
            ],
          ),
        ],
      ),
    );
  }
}
