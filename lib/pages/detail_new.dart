import 'package:flutter/material.dart';
import 'package:inputdata/repositories/new_repository.dart';

class DetailNew extends StatefulWidget {
  const DetailNew({super.key, required this.idDetail});

  final idDetail;

  @override
  State<DetailNew> createState() => _DetailNewState();
}

class _DetailNewState extends State<DetailNew> {
  dynamic newDetail;

  getDetail() {
    NewRepository.getNewDetail(widget.idDetail).then((value) {
      setState(() {
        newDetail = value;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    });
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (newDetail != null)
        ? Scaffold(
            appBar: AppBar(
              title: Text(newDetail.judul),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        newDetail.gambar,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      newDetail.judul,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.calendar_month,
                              size: 20,
                            ),
                          ),
                          TextSpan(
                            text: newDetail.postOn,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(newDetail.deskripsi)
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
