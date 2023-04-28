import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/filter_widget.dart';
import './feed_page.dart';
import './profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    Home(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 40,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFF2F7694)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFF2F7694)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Color(0xFF2F7694)),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool quest = true;
  final picker = ImagePicker();
  String _search = '';

  void setSearch(String search) {
    setState(() {
      _search = search;
    });
  }

  Position _currentPosition = Position(
      longitude: -74.78132,
      latitude: 10.96854,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  late GoogleMapController _mapController;

  void _getCurrentLocation() async {
    final position = await _determinatePosition();
    setState(() {
      _currentPosition = position;
    });
  }

  Future<Position> _determinatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        _getCurrentLocation();
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 14,
      ),
      zoomControlsEnabled: false,
      mapType: MapType.normal,
    );
  }

  void checkProximityMission() async {
    double destLat1 = 37.7749;
    double destLat2 = destLat1;
    double destLng1 = -122.4194;
    double destLng2 = destLng1;

    // Calcular la distancia entre la ubicación actual del usuario y la ubicación de destino utilizando la fórmula Haversine
    double distance = await Geolocator.distanceBetween(
        destLat1, destLng1, destLat2, destLng2);

    // Comprobar si la distancia es menor que un umbral predefinido
    double proximityThreshold = 1000.0; // metros
    if (distance < proximityThreshold) {
      quest = true;
    }
  }

  void camara() async {
    await picker.getImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: _buildMap(),
            ),
            const Flexible(flex: 1, child: Filter())
          ],
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings_outlined,
                          size: 40,
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 20),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) => setSearch(value),
                        )),
                    IconButton(
                        onPressed: () {
                          checkProximityMission();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 40,
                        )),
                  ],
                ))),
        Visibility(
          visible: quest,
          child: Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Color(0xFFF07B2B),
              child: Column(
                children: [
                  Text(
                    '¡Has llegado a tu destino! Toma una foto y reclama tu recompensa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      camara();
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text(
                      'Cámara',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF7A935),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
