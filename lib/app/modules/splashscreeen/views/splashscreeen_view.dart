import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spesiallibrary/app/routes/app_pages.dart';

import '../controllers/splashscreeen_controller.dart';

class SplashscreeenView extends GetView<SplashscreeenController> {
  const SplashscreeenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Future.delayed(
      const Duration(milliseconds: 5000),((){
        Get.offAllNamed(Routes.HOMESCREEN);
      }));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA6F6FF),
              Color(0xFFFFFFFF)
            ]
          )
        ),
        child:Image(image: AssetImage('assets/logo.png'))
      )
    );
  }
}
