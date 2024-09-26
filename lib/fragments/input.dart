import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inputdata/models/new_detail.dart';
import 'package:inputdata/pages/mainNavigation.dart';
import 'package:inputdata/repositories/new_repository.dart';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
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

    if(picked != null) {
      final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(picked),
      );
      if (time != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          picked.hour,
          picked.minute,
        );
        if (picked != null && picked != _dateTime) {
          setState(() {
            _dateTime = picked;
            _postOn.text = picked.toString();
          });
        }
      }

    }



  }

  storeData() {
    final data = <String, String>{
      'post_on': _postOn.text,
      'judul': _judul.text,
      'gambar': _gambar.text,
      'deskripsi': _deskripsi.text,
    };

    NewRepository.storeNew(data).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainNavigation(),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                onPressed: storeData,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
