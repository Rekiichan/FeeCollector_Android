import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class billScreen extends StatelessWidget {
  final String idCar;
  final String address;
  final String time;
  final String timeM;
  final int price;
  final String date;
  const billScreen({
    Key? key,
    required this.idCar,
    required this.address,
    required this.time,
    required this.timeM,
    required this.price,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SizedBox(
          height: 600,
          child: Material(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THÔNG TIN HÓA ĐƠN',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'BIỂN SỐ: ${idCar}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'ĐẬU TẠI: ${address}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Phát hiện đậu: ${time}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Hết thời gian đậu: ${timeM}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'THÀNH TIỀN: ${price}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'NGÀY THU: ${date}',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Image.network(
                      "http://momofree.apimienphi.com/api/QRCode?phone=0329489007&amount=${price}& note=Thu phí giữ xe công cộng ${price}VND"),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
