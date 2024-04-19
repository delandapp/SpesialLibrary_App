import 'package:spesiallibrary/app/data/models/response_ulasan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spesiallibrary/app/data/constans/endpoint.dart';
import 'package:spesiallibrary/app/data/models/response_detailsbook.dart';
import 'package:spesiallibrary/app/data/provider/api_provider.dart';
import 'package:spesiallibrary/app/data/provider/storage_provider.dart';

class MyState<T1,T2> {
  T1? state1;
  T2? state2;
  // T3? state3;
  MyState({this.state1,this.state2});
}
class DetailbookController extends GetxController with StateMixin<MyState<DataBookDetails, List<DataUlasan>>> {
  //TODO: Implement DetailbookController
  final detailBuku = DataBookDetails().obs;
  final judulBuku = "".obs;
  final count = 0.obs;
    final loading = false.obs;
    final id = Get.parameters['idbook'];
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getData() async{
    change(null, status: RxStatus.loading());

    try {
        final bearerToken = StorageProvider.read(StorageKey.bearerToken);
        final response = await ApiProvider.instance().get('${Endpoint.book}/${id}',options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
        final responseUlasanData = await ApiProvider.instance().get('${Endpoint.ulasan}/${id}',options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
        if (response.statusCode == 200 && responseUlasanData.statusCode == 200) {
          final ResponseDetailsbook responseDetailsbook = ResponseDetailsbook.fromJson(response.data);
          final ResponseUlasan responseUlasan = ResponseUlasan.fromJson(responseUlasanData.data);
          if(responseDetailsbook.data!.deskripsi!.isEmpty ) {
            change(null, status: RxStatus.empty());
          } else {
            final newData = MyState(state1: responseDetailsbook.data, state2: responseUlasan.data);
            change(newData, status: RxStatus.success());
            detailBuku.value = responseDetailsbook.data!;
            judulBuku.value = responseDetailsbook.data!.judulBuku.toString();
          }
        } else {
          change(null, status: RxStatus.error("Gagal mengambil data"));
        }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  addKoleksiBuku() async {
    if(detailBuku.value.koleksi == true) {
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Pemberitahuan",
        "Buku ini sudah ada di koleksi",
        "Ok",
      );
      return;
    }
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id;
      final bearerToken = StorageProvider.read(StorageKey.bearerToken);

      var response = await ApiProvider.instance().post(
        Endpoint.koleksi,
        options: Options(headers: {"Authorization": "Bearer $bearerToken"}),
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBukuDialog = judulBuku.value;
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Buku berhasil disimpan",
          "Buku $judulBukuDialog berhasil disimpan di koleksi buku",
          "Oke",
        );
        getData();
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal disimpan, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }
}

 Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF03010E),
          title: Text(
            'SPESIALBOOK',
            style: GoogleFonts.inriaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFF0094FF),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  judul,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20.0
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              autofocus: true,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF0094FF),
                animationDuration: const Duration(milliseconds: 300),
              ),
              onPressed: onPressed,
              child: Text(
                nameButton,
                style: GoogleFonts.inriaSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

