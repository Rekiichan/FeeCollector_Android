import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class input_record extends StatelessWidget {
  final String record;
  final TextEditingController? controller;
  final Widget? widget;
  const input_record({
    Key? key,
    required this.record,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 40,
      width: 145,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          widget == null
              ? Container()
              : Container(
                  child: widget,
                ),
          Text(record,
              style: GoogleFonts.inter(
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
