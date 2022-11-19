import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thu_phi/dbhelper/mongo.dart';
import 'package:thu_phi/home/printBill.dart';

import '../dbhelper/MongoDBModel.dart';
import '../map_extension/map.dart';

class home2 extends StatefulWidget {
  const home2({Key? key}) : super(key: key);

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD9E8E1E1),
      body: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return DisplayIn4(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
            }
          }),
    );
  }

  Widget DisplayIn4(MongoDbModel data){
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

    DateTime _timeMax = DateFormat.jm().parse(data.timeM.toString());
    var myMax = DateFormat("HH:mm").format(_timeMax);
    var myCurrent = DateFormat("HH:mm").format(DateTime.now());

    bool test = compare(
        int.parse(myMax.split(":")[0]),
        int.parse(myMax.split(":")[1].split(" ")[0]),
        int.parse(myCurrent.split(":")[0]),
        int.parse(myCurrent.split(":")[1].split(" ")[0])
    );
    if (!test) {
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
    } else
      return Container();
  }

  bool compare(int hM, int mM, int hC, int mC){
    if((hM*60+mM) > (hC*60 +mC)) return true;
    else return false;
  }
}
