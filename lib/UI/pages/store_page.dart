import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import 'home_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  AuthenticationController authControl = Get.find();
  UserController userControl = Get.find();

  int _currentAvatar = 0;
  final List<String> _avatarImages = [
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar1.png?alt=media&token=72dda27f-3e70-48a4-8f39-691555680e92',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar2.png?alt=media&token=30fe7dde-fdf3-4e89-914c-e626edcb489e',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar3.png?alt=media&token=83de4816-0ec4-4868-b39f-f49fe12a2cc6',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Favatar4.png?alt=media&token=6d65b4e0-5d8c-49b0-adef-959a1057bad3',
    // more avatars here
  ];

  final List<String> _avatarAssets1 = [
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Fcamiseta1.png?alt=media&token=bd03d0e1-1809-42ae-9347-8840617ce5ca',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Fcamiseta2.png?alt=media&token=65b5df09-e4a8-4eb8-a992-ccfc40109d73'
  ];
  final List<String> _avatarAssets2 = [
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Fsombrero1.png?alt=media&token=b3e7f202-c551-49b2-ae54-54808ffa9b73',
    'https://firebasestorage.googleapis.com/v0/b/titixplorerdb.appspot.com/o/avatares%2Fsombrero2.png?alt=media&token=5fb36215-d356-47f4-9b64-f6f8e406ccd7'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF07B2B),
        body: Stack(
          children: [
            if (userControl.user.value.avatar == null) ...[
              Positioned(
                bottom: 10, right: 0,
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
              )
            ],
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userControl.user.value.avatar == null) ...[chooseAvatar()]
                else ...[editAvatar()]
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget chooseAvatar() {
    return Column(
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
            height: 200,
            viewportFraction: 0.4,
            initialPage: 0,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentAvatar = index;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _avatarImages.map((url) {
            int index = _avatarImages.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentAvatar == index ? Colors.white : Colors.grey,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            userControl.setAvatar(authControl.getUid(),_avatarImages[_currentAvatar]);
            userControl.getUser();
            Get.offAll(() => const HomePage());
          },
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }

  int i1=0;
  int i2=0;
  
  void changeI(op, i) {
    setState(() {
      if (op == 'add') {
        if (i == 1) {
            i1++;
            i1 = i1%_avatarAssets1.length;
        } else {
            i2++;
            i2 = i2%_avatarAssets2.length;
        }
      } else {
        if (i == 1) {
            i1--;
            i1 = i1%_avatarAssets1.length;
        } else {
            i2--;
            i2 = i2%_avatarAssets2.length;
        }
      }
    });
  }

  Widget editAvatar() {
    return Column(
      children: [
        const Text('EDIT YOUR AVATAR', style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 28)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {changeI('res',2);}, icon: const Icon(Icons.arrow_back_ios)),
            Image.network(_avatarAssets2[i2], width: 100, height: 100,),
            IconButton(onPressed: () {changeI('add',2);}, icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
        Center(child: Image.network(userControl.user.value.avatar!, scale: 3)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {changeI('res',1);}, icon: const Icon(Icons.arrow_back_ios)),
            Image.network(_avatarAssets1[i1], width: 100, height: 100,),
            IconButton(onPressed: () {changeI('add',1);}, icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            userControl.setAvatar(authControl.getUid(),_avatarImages[_currentAvatar]);
            userControl.getUser();
            Get.offAll(() => const HomePage());
          },
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }

}