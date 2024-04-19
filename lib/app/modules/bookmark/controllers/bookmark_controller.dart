import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spesiallibrary/app/data/constans/endpoint.dart';
import 'package:spesiallibrary/app/data/models/response_history_peminjaman.dart';
import 'package:spesiallibrary/app/data/models/response_koleksi.dart';

import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class BookmarkController extends GetxController with StateMixin{
  var koleksiBook = Rxn<List<DataKoleksi>>();
  var historyPeminjaman = Rxn<List<DataHistory>>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  // Jumlah Data
  int get jumlahKoleksiBook => koleksiBook.value?.length ?? 0;
  int get jumlahHistoryPeminjaman => historyPeminjaman.value?.length ?? 0;

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

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      final responseKoleksiBuku = await ApiProvider.instance().get(
          '${Endpoint.koleksi}/$idUser');
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.historyPeminjaman}/$idUser');

      if (responseKoleksiBuku.statusCode == 200 && responseHistoryPeminjaman.statusCode == 200) {
        final ResponseKoleksi responseKoleksi = ResponseKoleksi.fromJson(responseKoleksiBuku.data);
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseKoleksi.data!.isEmpty || responseHistory.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          koleksiBook(responseKoleksi.data!);
          historyPeminjaman(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
