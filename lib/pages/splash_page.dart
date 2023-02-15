import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final int userId = prefs.getInt('userId');

    // if (userId != null) {
    //   Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/home'));
    // } else {
    //   Timer(
    //       Duration(seconds: 3), () => Navigator.pushNamed(context, '/sign-in'));
    // }

    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    if (status == true) {
      if (await authProvider.getUser(
        token: prefs.getString('token'),
      )) {
        // print('Dadi');
        Navigator.pushNamed(context, '/home');
      }
    } else {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image_splash.png'))),
        ),
      ),
    );
  }
}
