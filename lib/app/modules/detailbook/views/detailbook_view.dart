import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:spesiallibrary/app/components/bookDetails.dart';

import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
      (state) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: MyBookDetails(
                      controller: controller,
                      dataBookDetails: state!.state1!,
                      dataUlasan: state.state2!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
