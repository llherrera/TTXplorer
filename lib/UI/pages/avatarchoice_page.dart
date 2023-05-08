import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ttxplorer/UI/pages/home_page.dart';

class AvatarChoicePage extends StatefulWidget {
  const AvatarChoicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AvatarChoicePageState createState() => _AvatarChoicePageState();
}

class _AvatarChoicePageState extends State<AvatarChoicePage> {
  int _currentAvatar = 0;

  final List<String> _avatarImages = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
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
                const Text('CHOOSE YOUR AVATAR',
                    style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 28)),
                const SizedBox(height: 20),
                CarouselSlider.builder(
                  itemCount: _avatarImages.length,
                  itemBuilder: (context, index, _) {
                    return Image.asset(
                      _avatarImages[index],
                      fit: BoxFit.cover,
                    );
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
                    onPressed: () => Get.off(const HomePage()),
                    child: const Text('Continue',
                      style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 20)),
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
