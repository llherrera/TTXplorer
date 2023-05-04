import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/local_controller.dart';
import '../controllers/user_controller.dart';
import 'inventory_page.dart';
import 'local_form.dart';
import 'login_page.dart';
import 'store_page.dart';
import 'calendar_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthenticationController authControl = Get.find();
  UserController userControl = Get.find();
  LocalController localControl = Get.find();
  String _username = '';

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
    _username = authControl.userEmail();
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
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF38005F),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    ),
                    width: double.infinity,
                    child: photoLoad(),
                  ),
                  const SizedBox(height: 20),
                  photos(),
                ],
              ),
            )
          ),
        ],
      )
    );
  }

  Widget menuBar() {
    return Drawer(
        backgroundColor: const Color(0xFFF07B2B),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/monoMenu.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFFF07B2B)),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const FormUploadLocal());
                    },
                    icon: const Icon(Icons.add_circle_outline_outlined, size: 150, color: Colors.white,)
                  )
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
                const SizedBox(height: 150,),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Cerrar sesión',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () {
                    authControl.logout();
                    Get.offAll(const LoginPage());
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget photoLoad() {
    return Column(
      children: [
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
          child: Text(_username.toString(), style: const TextStyle(fontSize: 20, color: Colors.black)),
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
      ]
    );
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
