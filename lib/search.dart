import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dbhelper/MongoDBModel.dart';
import 'dbhelper/mongo.dart';
import 'home/printBill.dart';
import 'map_extension/map.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD9E5E0E0),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 50, 15, 15),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Tìm kiếm biến số',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25),
                ),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.clear_rounded)),
              ),
            ),
          ),
          // FutureBuilder(
          //     future: MongoDatabase.getData(),
          //     builder: (context, AsyncSnapshot snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         if (snapshot.hasData) {
          //           return ListView.builder(
          //               itemCount: snapshot.data.length,
          //               itemBuilder: (context, index) {
          //                 return DisplayIn4(
          //                     MongoDbModel.fromJson(snapshot.data[index]));
          //               });
          //         } else {
          //           return Center(
          //             child: Text("No Data"),
          //           );
          //         }
          //       }
          //     }),
        ],
      ),
    );
  }

  Widget DisplayIn4(MongoDbModel data) {
    Future openDialog() => showDialog(
      context: context,
      builder: (context) => billScreen(
        idCar: data.idCar!,
        address: data.location!,
        time: data.time!,
        timeM: data.timeM!,
        date: data.date!,
        price: data.price!,
      ),
    );

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          child: ClipOval(
            child: Image.file(
              File(data.image!),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          radius: 30,
        ),
        title: Text(
          data.idCar!,
          style: GoogleFonts.inter(
            textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Đậu tại: ${data.location}',
                style: GoogleFonts.inter(
                  textStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                )),
            Text('Phát hiện lần đầu: ${data.time!}',
                style: GoogleFonts.inter(
                  textStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                )),
          ],
        ),
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xD9A49F9F),
              borderRadius: BorderRadius.circular(100),
            ),
            child: mapScreen(
                lat: data.latitude!, long: data.longtitude!, address: data.location!),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              openDialog();
              MongoDatabase.delete(data);
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.only(top: 15),
              height: 55,
              width: 180,
              decoration: BoxDecoration(
                  color: Color(0xFF072AC8),
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                'IN HÓA ĐƠN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
