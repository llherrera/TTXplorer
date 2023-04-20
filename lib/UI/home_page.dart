import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../Data/local_model.dart';
import '../widgets/filter_widget.dart';
import './feed_page.dart';
import './profile_page.dart';
import 'local_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    Home(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavyBar(
          items: <BottomNavyBarItem> [
            BottomNavyBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Feed'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.purpleAccent,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.pink,
            ),
          ],
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) {
            setState(() => _selectedIndex = index);
            _pageController.jumpToPage(index);
          },
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

const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 5,
);

class _HomeState extends State<Home> {
  Set<Marker> markerLocales = {};
  late String mapStyle;
  
  Iterable<Local> locales = [// Cuando este la db este iterable estará vacio, y se llamará la función getLocales en el init para traer la información
    Local('buenavista','ta bueno', File('') , 'semilla', const LatLng(11.01488064038962, -74.82745006489434)),
    Local('caiman del rio','ta bueno', File(''), 'fruta', const LatLng(11.023429370880141, -74.79637497469237)),
    Local('plaza de la paz','ta bueno', File(''), 'insecto', const LatLng(10.988428922594359, -74.7892494693815)),
  ];
  Iterable<Local> voidLocales = [];//aqui estarán los locales filtrados, es para no perder información

  @override
  void initState() {
    super.initState();
    getLocales();
    setLocales(voidLocales);
  }

  String _search = '';

  void setSearch(String search) {
    setState(() {
      _search = search;
    });
  }

  void getLocales() {
    voidLocales = locales;
  }

  void setLocales(Iterable<Local> voidLocales) async {// de los locales extrae la información para colocarlos en el mapa
    markerLocales = {};
    for (var locall in voidLocales) {
      markerLocales.add(
        Marker(
          markerId: MarkerId(locall.i.toString()),
          position: locall.ubi,
          infoWindow: InfoWindow(
            title: locall.localName,
            snippet: locall.localDescription,
          ),
          onTap: () {
            Get.to(LocalPage(local: locall));
          },
          icon: locall.type == 'fruta' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/fruit_icon.png') : 
               (locall.type == 'semilla' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/seed_icon.png') : 
               await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/bug_icon.png'))
        ),
      );
    }
    setState(() {
      markerLocales = markerLocales;
    });
  }

  Position _currentPosition = Position(longitude: -74.78132, latitude: 10.96854, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0);
  late GoogleMapController _mapController;
  StreamSubscription<Position>? positionStream;

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

  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes,byte.lengthInBytes);
    return utf8.decode(list);
  }

  Widget _buildMap() {
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
        (Position? position) {
          if (position != null) {
            _mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 12.0,
              ),
            ));
          }
    });
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      onMapCreated: (GoogleMapController controller) async {
        _mapController = controller;
        mapStyle = await getJsonFile('assets/map_style.json');
        _mapController.setMapStyle(mapStyle);
        _getCurrentLocation();
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 12,
      ),
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      markers: markerLocales,
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: _buildMap(),
            ),
            Flexible(
              flex: 1,
              child: Filter(locales: voidLocales, callback: setLocales,)
            )
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
              IconButton(onPressed: (){}, icon: const Icon(Icons.settings_outlined, size: 40,)),
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
                )
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 40,)),
            ],
          ))
        ),
      ],
    );
  }
}