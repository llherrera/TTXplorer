import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_page.dart';
import 'store_page.dart';
import 'calendar_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username = 'username';

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  Future<List<String>> _searchImages(String term) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        20, (index) => 'https://source.unsplash.com/random/800x800/?$term');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF38005F),
        title: const Text(''),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: menuBar(),
      body: Stack(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  photoLoad(),
                  photos(),
                ],
              ),
            )
          )
        ],
      )
    );
  }

  Widget menuBar() {
    return Drawer(
        backgroundColor: const Color(0xFFF07B2B),
        child: Container(
          decoration: const BoxDecoration(
            /*image: DecorationImage(
              image: AssetImage('assetsimages/monoMenu.png'),
              fit: BoxFit.cover,
            ),*/
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF07B2B),
                  ),
                  accountName: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'accountName',
                    ),
                  ),
                  accountEmail: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'accountEmail',
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Notificaciones',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Calendario',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(const CalendarPage());
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Inventario',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(const InventoryPage());
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Tienda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.store_mall_directory_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(const StorePage());
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget photoLoad() {
    return /*Expanded(child: 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFF38005F),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          IconButton(
            icon: _image == null ? 
                          const Icon(Icons.photo_camera, size: 70) :
                          ClipOval(child: Image.file(_image!, width: 130, height: 130, fit: BoxFit.cover,)),
            onPressed: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _image = File(pickedFile.path);
                });
              }
            },
          ),
        ]
      ),
    ));*/
    
    Column(children: [
      Container(
        width: 130,
        height: 130,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: IconButton(
          icon: _image == null ? 
                          const Icon(Icons.photo_camera, size: 70) :
                          ClipOval(child: Image.file(_image!, width: 130, height: 130, fit: BoxFit.cover,)),
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                _image = File(pickedFile.path);
              });
            }
          },
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(_username, style: const TextStyle(fontSize: 20, color: Colors.black)),
      ),
      SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.food_bank, size: 40,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.food_bank, size: 40,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.food_bank, size: 40,)),
          ],
        )
      )
    ]);
  }

  Widget photos() {
    return FutureBuilder(
      future: _searchImages('food'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                snapshot.data![index],
                fit: BoxFit.cover,
              );
            },
          );
        } else {
          return const Center(child: Text('No se encontraron resultados.'));
        }
      },
    );
  }
}
