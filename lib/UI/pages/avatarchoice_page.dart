import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ttxplorer/ui/pages/home_page.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class AvatarChoicePage extends StatefulWidget {
  const AvatarChoicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AvatarChoicePageState createState() => _AvatarChoicePageState();
}

class _AvatarChoicePageState extends State<AvatarChoicePage> {
  int _currentAvatar = 0;
  AuthenticationController authControl = Get.find();
  UserController userControl = Get.find();

  final List<String> _avatarImages = [
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar1.png?alt=media&token=72dda27f-3e70-48a4-8f39-691555680e92',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar2.png?alt=media&token=30fe7dde-fdf3-4e89-914c-e626edcb489e',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar3.png?alt=media&token=83de4816-0ec4-4868-b39f-f49fe12a2cc6',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar4.png?alt=media&token=6d65b4e0-5d8c-49b0-adef-959a1057bad3',
    // more avatars here
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF07B2B),
        body: Stack(
          children: [
            Positioned(
              top: 0, right: 0,
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                child: Lottie.asset(
                  'assets/images/swipe.json',
                  alignment: Alignment.topRight,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('CHOOSE YOUR AVATAR', style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 28)),
                const SizedBox(height: 20),
                CarouselSlider.builder(
                  itemCount: _avatarImages.length,
                  itemBuilder: (context, index, _) {
                    return Image.network(_avatarImages[index]);
                  },
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 1.0,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentAvatar = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 35),
                Text('Titi Avatar ${_currentAvatar + 1}',
                    style: const TextStyle(
                        fontSize: 28,
                        fontFamily: 'RobotoSlab',
                        color: Colors.white)),
                const SizedBox(height: 30),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => {
                      userControl.setAvatar(authControl.getUid(), _avatarImages[_currentAvatar]),
                      Get.off(const HomePage())
                    },
                    child: const Text('Continue', style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 20)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}