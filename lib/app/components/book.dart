import 'package:spesiallibrary/app/components/slider.dart';
import 'package:spesiallibrary/app/data/models/response_buku.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spesiallibrary/app/routes/app_pages.dart';
import 'package:get/get.dart';

class bookSearch extends StatelessWidget {
  const bookSearch({
    super.key,
    required this.data,
  });

  final List<DataBuku> data;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const MySlider(),
        Column(
          children: data.map((e) => MyBuku(data: e.buku)).toList(),
        )
      ]),
    );
  }
}

class MyBuku extends StatelessWidget {
  const MyBuku({super.key, required this.data});
  final List<Buku>? data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 5 / 8,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.DETAILBOOK,
                parameters: {"idbook": data![index].bukuID.toString()}),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(data![index].coverBuku.toString()),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
