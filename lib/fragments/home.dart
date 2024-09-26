import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inputdata/models/new_list.dart';
import 'package:inputdata/pages/detail_new.dart';
import 'package:inputdata/pages/edit.dart';
import 'package:inputdata/repositories/new_repository.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _search = TextEditingController();
  final FocusNode _focusSearch = FocusNode();

  // Membuat variable untuk menampung data
  List<NewList> newData = [];
  List<NewList> showData = [];

  // Buat fungsi untuk memanggil fungsi getNewList
  getData() {
    // Panggil Fungsi getNewList
    NewRepository.getNewList().then((value) {
      // Jika getNewList Berhasil dapat data maka data di simpan di variable newData
      setState(() {
        newData = value;
        showData = newData;
      });
    }).catchError((error) {
      // tapi jika gagal dapat data maka akn menjalankan code dibawah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    });
  }

  deleteData(idNew) {
    NewRepository.deleteNew(idNew).then((value) {
      getData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value.toString()),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  formatDate(String text) {
    // DateFormat dateFormat = DateFormat("H:m dd MMMM yyyy"); ini bisa
    DateTime dateTime = DateTime.parse(text);
    return DateFormat("H:m dd MMMM yyyy").format(dateTime); //ini juga bisa
  }

  onSearch() {
    setState(() {
      showData = newData
          .where((item) =>
              item.judul!.toLowerCase().contains(_search.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: TextFormField(
              controller: _search,
              focusNode: _focusSearch,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                suffixIcon: _focusSearch.hasFocus ? IconButton(
                  onPressed: () {
                    _search.clear();
                    setState(() {
                      showData = newData;
                    });
                    _focusSearch.unfocus();
                  },
                  icon: Icon(Icons.close),
                ): null,
              ),
              onChanged: (value) => onSearch(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: showData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailNew(idDetail: showData[index].id)));
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              showData[index].gambar!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      showData[index].judul!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      formatDate(showData[index].postOn!),
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Edit(dataNews: showData[index]!),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.black),
                                  onPressed: () =>
                                      deleteData(showData[index].id),
                                  icon: Icon(Icons.restore_from_trash_outlined))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
