import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'extension_text_field.dart';
import 'extension_time_input.dart';
import 'package:intl/intl.dart';
import 'package:thu_phi/map_extension/map.dart';
import 'package:thu_phi/dbhelper/MongoDBModel.dart';
import 'package:thu_phi/dbhelper/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Check_in4 extends StatefulWidget {
  final XFile imagePath;
  final String imageName;
  final String idCarHint;
  const Check_in4({Key? key, required this.imagePath, required this.imageName, required this.idCarHint})
      : super(key: key);

  @override
  State<Check_in4> createState() => _Check_in4State();
}

class _Check_in4State extends State<Check_in4> {
  final TextEditingController _textEditingController = TextEditingController();
  DateTime _now = DateTime.now();
  String _timeRecord = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _timeMax = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 2)))
      .toString();
  String _selectedType = "Ô tô dưới 16 chỗ";
  List<String> typeList = [
    "Ô tô dưới 16 chỗ",
    "Ô tô từ 16 đến 30 chỗ",
    "Ô tô trên 30 chỗ"
  ];
  String location = 'Null, Press Button';
  String Address = 'search';
  late double _lat;
  late double _long;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street},${place.subAdministrativeArea}, ${place.country}';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.idCarHint;
    print(location);
    return Scaffold(
      backgroundColor: Color(0xD9E5E0E0),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'KIỂM TRA THÔNG TIN',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              input_in4(
                title: "Ngày phát hiện",
                hint: DateFormat.yMd().format(_now),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: Icon(Icons.calendar_month)),
              ),
              input_in4(
                title: "Biển số xe",
                hint: "Nhập biển số",
                controller: _textEditingController,
              ),
              input_in4(
                title: "Loại xe",
                hint: "$_selectedType",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  iconSize: 30,
                  elevation: 3,
                  underline: Container(
                    height: 0,
                  ),
                  items: typeList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                ),
              ),
              Text("Thời gian và Địa điểm",
                  style: GoogleFonts.inter(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
                height: 330,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 350,
                      height: 240,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          mapScreen(lat: _lat, long: _long, address: Address),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print("a");
                        },
                        child: input_record(
                          record: _timeRecord,
                          widget: IconButton(
                              onPressed: () {
                                _getTimeFromUser(timeRecord: true);
                              },
                              icon:
                                  Icon(Icons.access_time_filled_outlined)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_textEditingController.text.isNotEmpty) {
                    print("check!!!!");
                    _insertData(
                      widget.imagePath.path,
                      DateFormat.yMd().format(_now),
                      _textEditingController.text,
                      _selectedType,
                      _timeRecord,
                      _timeMax,
                      Address,
                      _lat,
                      _long,
                      (_selectedType == "Ô tô dưới 16 chỗ")
                          ? 15000
                          : (_selectedType == "Ô tô từ 16 đến 30 chỗ")
                              ? 20000
                              : 30000,
                    );
                    Get.back();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 100, top: 10, bottom: 25),
                  alignment: Alignment.center,
                  height: 55,
                  width: 145,
                  decoration: BoxDecoration(
                      color: Color(0xFF072AC8),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(
      String image,
      String date,
      String idCar,
      String type,
      String time,
      String timeM,
      String location,
      double lat,
      double long,
      int price) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id,
        image: image,
        date: date,
        idCar: idCar,
        type: type,
        time: time,
        timeM: timeM,
        location: location,
        lat: lat,
        long: long,
        price: price);
    await MongoDatabase.insert(data);
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2222),
    );

    if (_pickerDate != null) {
      setState(() {
        _now = _pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool timeRecord}) async {
    var pickedTime = await _showTimePicker();
    String formatTime = pickedTime.format(context);
    if (timeRecord == true) {
      setState(() {
        _timeRecord = formatTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_timeRecord.split(":")[0]),
          minute: int.parse(_timeRecord.split(":")[1].split(" ")[0]),
        ));
  }

  void getLocation() async {
    Position position = await _getGeoLocationPosition();
    _lat = position.latitude;
    _long = position.longitude;
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }
}
