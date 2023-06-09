import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttxplorer/services/upload_image.dart';
import 'package:ttxplorer/ui/controllers/user_controller.dart';
import '../../Data/model/local.dart';
import '../../widgets/filter_widget.dart';
import '../controllers/auth_controller.dart';
import '../controllers/local_controller.dart';
import './feed_page.dart';
import './profile_page.dart';
import './local_page.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex)
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF713D8F),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFFF07B2B),
          iconSize: 20,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Feed',
              backgroundColor:  Color(0xFF713D8F),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor:  Color(0xFF713D8F),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor:  Color(0xFF713D8F),
            ),
          ],
        )
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
  AuthenticationController authControl = Get.find();
  UserController userControl = Get.find();
  LocalController localControl = Get.find();

  Set<Marker> markerLocales = {};
  late String mapStyle;
  
  Iterable<LocalB> locales = [];
  Iterable<LocalB> voidLocales = [];

  LocalB? localDest;

  @override
  void initState() {
    super.initState();
    getLocales();
    userControl.getUser();
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
        (Position? position) {
          if (position != null) {
            _currentPosition = position;
            _mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15.0,
              ),
            ));
          }
    });
  }

  @override
  void dispose() {
    super.dispose();
    positionStream!.cancel();
  }

  bool quest = false;
  final picker = ImagePicker();
  // ignore: unused_field
  XFile? _image;
  // ignore: unused_field
  String _search = '';

  void setSearch(String search) {
    setState(() {
      _search = search;
    });
  }

  Future<void> getLocales() async {
    //await localControl.setLocales(await localControl.getLocales(), setMarker);
    //setMarker();
    locales = await localControl.getLocales();
    setState(() {
      voidLocales = locales;
    });
    await setLocales(voidLocales);
  }

  Future<void> setLocales(Iterable<LocalB> voidLocales) async {
    if (voidLocales.isEmpty) {
      voidLocales = locales;
    }
    markerLocales = {};
    for (var locall in voidLocales) {
      markerLocales.add(
        Marker(
          markerId: MarkerId(locall.localName),
          position: locall.ubi,
          infoWindow: InfoWindow(
            title: locall.localName,
            snippet: locall.localDescription,
          ),
          onTap: () {
            Get.to(LocalPage(local: locall, callback: setLocales));
          },
          icon: locall.type == 'fruta' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/cereza_icon.png') : 
               (locall.type == 'semilla' ? await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/semillas_icon.png') : 
               await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/icons/arana_icon.png'))
        ),
      );
    }
    setState(() {
      markerLocales = markerLocales;
    });
  }

  void setMarker(){
    Set<Marker> markers = {};
    // ignore: invalid_use_of_protected_member
    for (var element in localControl.markerLocales.value) {
      markers.add(element);
    }
    setState(() {
      // ignore: invalid_use_of_protected_member
      localControl.markerLocales.value = markers;
      markerLocales = markers;
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
  StreamSubscription<Position>? positionStream;

  void _getCurrentLocation() async {
    final position = await _determinatePosition();
    userControl.getRewards(authControl.getUid());
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
        zoom: 15,
      ),
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      // ignore: invalid_use_of_protected_member
      markers: markerLocales,
    );
  }

  double checkProximityMission() {
    double destLat1 = localControl.localDest.value.ubi.latitude;
    double destLng1 = localControl.localDest.value.ubi.longitude;
    double destLat2 = _currentPosition.latitude;
    double destLng2 = _currentPosition.longitude;

    double distance = Geolocator.distanceBetween(destLat1, destLng1, destLat2, destLng2);
    return distance;
  }

  void camara() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
    if (pickedFile != null) {
      String urlPhoto = await uploadImageF(File(pickedFile.path), 'fotos');
      await localControl.setPhoto(urlPhoto);
      await userControl.setPhoto(urlPhoto, authControl.getUid(), localControl.localDest.value);
      localControl.resetLocalDest();
      setLocales([]);
      userControl.getRewards(authControl.getUid());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: _buildMap(),
            ),
            Flexible(flex: 2, child: Filter(locales: voidLocales, callback: setLocales))
          ],
        ),
        if (checkProximityMission() < 100.0) ...[
          Positioned(top: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: const Color(0xFFF07B2B),
              child: Column(
                children: [
                  const Text('¡Has llegado a tu destino! Toma una foto y reclama tu recompensa.',
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
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Cámara',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7A935),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ],
    );
  }
}
