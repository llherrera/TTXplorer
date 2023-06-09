import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttxplorer/services/upload_image.dart';
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

  @override
  void initState() {
    super.initState();
    _username = userControl.user.value.name;
    setImageProfile();
  }

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    //await uploadImageF(File(pickedFile!.path), 'usuario');
    String urlPhoto = await uploadImageF(File(pickedFile!.path), 'usuario');
    await userControl.updatePhoto(urlPhoto, authControl.getUid());
  }

  Future<void> setImageProfile() async {
    try{
      String urlPhoto = await userControl.getPhoto(authControl.getUid());
      setState(() {
        _image = File.fromUri(Uri.parse(urlPhoto));
      });
    // ignore: empty_catches
    } catch (e) { }
  }

  Future<List<String>> _searchImages() async {
    userControl.getRewards(authControl.getUid());
    await Future.delayed(const Duration(seconds: 1));
    return userControl.getPhotos(authControl.getUid());
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
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
                  Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: MediaQuery.of(context).size.width * 0.31,
                        child: const CircleAvatar( backgroundColor: Color(0xFFB27CD1),)
                      ),
                      Positioned(
                        top: 5,
                        left: MediaQuery.of(context).size.width * 0.44,
                        child: const CircleAvatar( backgroundColor: Color(0xFFB27CD1),)
                      ),
                      Positioned(
                        top: 5,
                        left: MediaQuery.of(context).size.width * 0.58,
                        child: const CircleAvatar( backgroundColor: Color(0xFFB27CD1),)
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: (Image.asset('assets/icons/cereza_icon.png', color: Colors.black))),
                              IconButton(
                                onPressed: () {},
                                icon: (Image.asset('assets/icons/semillas_icon.png', color: Colors.black))),
                              IconButton(
                                onPressed: () {},
                                icon: (Image.asset('assets/icons/arana_icon.png', color: Colors.black)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: invalid_use_of_protected_member
                              Text('${userControl.rewards.value.elementAt(0)}', style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 40),
                              // ignore: invalid_use_of_protected_member
                              Text('${userControl.rewards.value.elementAt(1)}', style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 40),
                              // ignore: invalid_use_of_protected_member
                              Text('${userControl.rewards.value.elementAt(2)}', style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
                          'Editar Avatar',
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
                    Get.to(const StorePage());
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Editar Perfil',
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
                    Get.to(const InventoryPage());
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
            onPressed: getImage
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(_username.toString(), style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ]
    );
  }

  Widget photos() {
    return FutureBuilder(
      future: _searchImages(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF38005F),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    snapshot.data![snapshot.data!.length - 1 - index],
                    fit: BoxFit.cover,
                  ),
                ),
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
