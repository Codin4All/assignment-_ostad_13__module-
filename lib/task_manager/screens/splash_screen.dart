import 'package:batch_18/task_manager/controller/auth_controller.dart';
import 'package:batch_18/task_manager/screens/login_screen.dart';
import 'package:batch_18/task_manager/screens/main_nav_screen.dart';
import 'package:flutter/material.dart';

import '../utils/asset_path.dart';
import '../widgets/screen_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }

  Future moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    AuthController.getUserData();
    bool isLogin = await AuthController.isUserLogin();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>isLogin ? MainNavScreen() : LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBG(child: Center(child: Image.asset(AssetPath.book, width: 300,height: 300,)),),
    );
  }
}

