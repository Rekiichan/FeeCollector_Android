import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class input_in4 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const input_in4({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 15, right: 10),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget == null? false: true,
                      autofocus: false,
                      controller: controller,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      decoration: InputDecoration(
                        hintText: hint,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )
                      ),
                    ),
                ),
                widget == null? Container():Container(child: widget,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
