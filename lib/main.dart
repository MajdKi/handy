import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtest/views/screens/login_and_signup/login_view.dart';

void main(List<String> args) async {
  runApp(const Home());
}

// Future<bool> getstring() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? stringValue = prefs.getString('token') ?? "";
//   return await validate(
//       token: stringValue, url: 'https://handyclose.com/api/Auth/vladateToken');
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? idleTimer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  void _resetTimer() {
    if (idleTimer != null) {
      idleTimer!.cancel();
    }
    idleTimer = Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: MainPage());
  }

  @override
  void dispose() {
    idleTimer!.cancel();
    super.dispose();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? idleTimer;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  void resetTimer() {
    if (idleTimer != null) {
      idleTimer!.cancel();
    }
    idleTimer = Timer(const Duration(seconds: 5), () {
      Get.to(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        resetTimer();
        print(000001);
      },
      child: const Scaffold(body: LoginView()),
    );
  }
}


// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         theme: ThemeData(primarySwatch: Colors.deepPurple),
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(body: LoginView()));
//   }
// }
