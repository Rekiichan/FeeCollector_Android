import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dbhelper/mongo.dart';
import 'home/home.dart';
import 'camera/camera.dart';
import 'profile/profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: (currentPage == 1)
            ? Color(0xE6FFFFFF)
            : (currentPage != 2)
                ? Color(0xE6FFFFFF)
                : Colors.white,
        body: (currentPage == 0)? home():(currentPage == 1)?camera():profile(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          child: Container(
            height: 60,
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                    },
                    icon: Icon(Icons.home_sharp),
                    color: Colors.black,
                    iconSize: 40,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        print("check");
                        currentPage = 1;
                      });
                    },
                    icon: Icon(Icons.add_a_photo_sharp),
                    color: Color(0xFF072AC8),
                    iconSize: 40,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                    },
                    icon: Icon(Icons.person),
                    color: Colors.black,
                    iconSize: 40,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        )
    );
  }
}
