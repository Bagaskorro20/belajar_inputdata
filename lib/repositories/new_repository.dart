import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:inputdata/models/new_detail.dart';
import 'package:inputdata/models/new_list.dart';



// Definisikan Base URL (Jika ada)
const String BASE_URL = "https://66ea3fbb55ad32cda478261a.mockapi.io";

// Membuat Kelas
class NewRepository {

  // Membuat Fungsi untuk memanggil semua data
  static Future getNewList() async {

    // Definisikan path spesifik ke alamat yang dituju
    String url = BASE_URL + "/berita";

    // Tangkap data yang sudah di get menggunakan fungsi http
    final response = await http.get(Uri.parse(url));
    // Cek apakah data berhasil didapat atau tidak
    if(response.statusCode == 200){
      // Yang di lakukan jika data berhasil di dapat
      // Data akan di maping sesuai yang ada di kelas NewList

      // cara jika response hanya berisi data
      Iterable jsonData = jsonDecode(response.body);
      List<NewList> newList = jsonData.map((item) => NewList.fromJson(item)).toList();
      return newList;

      // cara jika response berisi api lengkap
      // return NewList.fromJson(jsonDecode(response.body));
    }

    // Yang di lakukan juka data tidak berhasil di dapat
    throw "Data Kosong";
  }

  static Future getNewDetail(String idNew) async {

    String url = BASE_URL + "/berita/" + idNew;

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      print(response.body);
      return NewDetail.fromJson(jsonDecode(response.body));
    }

    throw "Data Tidak Ada";
  }

  static Future storeNew(data) async {

    String url = BASE_URL + "/berita";

    final response = await http.post(Uri.parse(url),
    body:data // jsonEncode = merubah data dari string ke objek
    );

    if(response.statusCode == 201) {
      return true;
    }

    throw "Gagal Store Data";
  }

  static Future updateNew(data, idNew) async {
    String url = BASE_URL + "/berita/" + idNew;
    
    final response = await http.put(Uri.parse(url), body: data);

    if(response.statusCode == 200) {
      return true;
    }

    throw "Data Gagal Diupdate";
  }


  static Future deleteNew(idNew) async {
    String url = BASE_URL + "/berita/" + idNew;

    final respone = await http.delete(Uri.parse(url));

    if(respone.statusCode == 200){
      return "Hapus Data Berhasil";
    }

    throw "Hapus Data Gagal";
  }

}
