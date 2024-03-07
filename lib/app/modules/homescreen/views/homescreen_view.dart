import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spesiallibrary/app/routes/app_pages.dart';

import '../controllers/homescreen_controller.dart';

import 'package:google_fonts/google_fonts.dart';

class HomescreenView extends GetView<HomescreenController> {
  const HomescreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA6F6FF),
              Color(0xFFFFFFFF)
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Image(image: AssetImage('assets/logo.png')),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: (){Get.toNamed(Routes.LOGIN);}, child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
              child: Text('LOGIN',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 30,fontFamily: GoogleFonts.inter().fontFamily),),
            ),style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),), 
            SizedBox(height: 40,), 
            ElevatedButton(onPressed: (){Get.toNamed(Routes.REGISTER);}, child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 10),
              child: Text('REGISTER',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 30,fontFamily: GoogleFonts.inter().fontFamily),),
            ),style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),),
            
          ],
        ),
      )
    );
  }
}
