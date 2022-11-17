import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';

import 'package:thu_phi/profile/member.dart';
import 'package:thu_phi/profile/setting.dart';
import 'package:thu_phi/profile/introduce.dart';
import 'package:thu_phi/profile/logout.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF072AC8),
      body: Column(
        children: [
          SizedBox(height: 69,),
          Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('QUẢN LÝ ĐÔ THỊ', style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 28, color: Colors.white),),
          SizedBox(
            height: 5,
          ),
          Text(
            'PHƯỜNG AN KHÊ',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 28, color: Colors.white),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            height: 400.733,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Material(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              child: ListView(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  buildItemMenu(
                    text: 'Thành viên ban quản lý',
                    icon: Icons.people_rounded,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  Divider(
                    color: Color(0xBF000000),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildItemMenu(
                    text: 'Cài đặt',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  Divider(
                    color: Color(0xBF000000),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildItemMenu(
                    text: 'Giới thiệu',
                    icon: Icons.info_sharp,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  Divider(
                    color: Color(0xBF000000),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_sharp,
                      color: Colors.black,
                      size: 45,
                    ),
                    title: Text(
                      'Đăng xuất',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    hoverColor: Color(0xE6FFFFFF),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemMenu(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.black;
    final hoverColor = Color(0xE6FFFFFF);

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 45,
      ),
      title: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w400),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: color,
        size: 25,
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => memberPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => settingPage()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => introducePage()));
        break;
    }
  }
}
