import 'package:flutter/material.dart';
import 'package:inputdata/models/new_detail.dart';
import 'package:inputdata/models/new_list.dart';
import 'package:inputdata/pages/mainNavigation.dart';
import 'package:inputdata/repositories/new_repository.dart';

class Edit extends StatefulWidget {
  Edit({super.key, required this.dataNews});

  NewList dataNews = NewList();

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime _dateTime = DateTime.now();

  TextEditingController _judul = TextEditingController();
  TextEditingController _postOn = TextEditingController();
  TextEditingController _gambar = TextEditingController();
  TextEditingController _deskripsi = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
      initialDate: _dateTime,
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        _postOn.text = picked.toString();
      });
    }
  }

  setData(){
    setState(() {
      _judul.text = widget.dataNews.judul!;
      _postOn.text = widget.dataNews.postOn!;
      _gambar.text = widget.dataNews.gambar!;
      _deskripsi.text = widget.dataNews.deskripsi!;
    });
  }

  updateData() {
    final data = <String, String>{
      'post_on': _postOn.text,
      'judul': _judul.text,
      'gambar': _gambar.text,
      'deskripsi': _deskripsi.text,
    };

    NewRepository.updateNew(data, widget.dataNews.id!).then((value) {
      if(value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainNavigation(),
        ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }


  @override
  void initState() {
    setData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _judul,
                decoration: InputDecoration(
                    labelText: "Judul",
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                    )),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _postOn,
                decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_month_outlined))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _gambar,
                decoration: InputDecoration(
                  labelText: "URL Image",
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _deskripsi,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: updateData,
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
