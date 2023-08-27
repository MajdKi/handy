import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testtest/core/constant/app_colors.dart';
import 'package:testtest/views/screens/login_and_signup/login_view.dart';
import 'package:testtest/views/screens/main_screens/bills.dart';
import 'package:testtest/views/screens/main_screens/home_screen.dart';
import 'package:testtest/views/screens/main_screens/history.dart';

import 'main_screens/shopping.dart';

class HomeView extends StatefulWidget {
  static const IconData shoppingCart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget body = const HomeScreen();
  int currentIndex = 0;
  setPage(int index) {
    if (index == 0) {
      body = const HomeScreen();
    } else if (index == 1) {
      body = Shopping();
    } else if (index == 2) {
      body = Bills();
    } else if (index == 3) {
      body = const PaymentHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              const storage = FlutterSecureStorage();

              storage.delete(
                  key: 'token'); // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ));
            },
            icon: const Icon(Icons.logout),
            color: AppColors.secondryText,
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Handy",
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
      body: body,
      //  backgroundColor: AppColors.mainColor,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        items: const [
          FaIcon(FontAwesomeIcons.house),
          Icon(HomeView.shoppingCart, size: 26),
          FaIcon(FontAwesomeIcons.moneyBills),
          FaIcon(FontAwesomeIcons.clockRotateLeft),
        ],
        onTap: (value) {
          setState(() {
            setPage(value);
          });
        },
        backgroundColor: AppColors.mainColor,
        color: Colors.white,
      ),
    );
  }
}
