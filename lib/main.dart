import 'package:flutter/material.dart';
import 'package:iot_project/screens/home_layout.dart';
import 'package:iot_project/screens/home_screen.dart';
import 'package:iot_project/screens/login_screen.dart';
import 'package:iot_project/screens/register_screen.dart';
import 'package:iot_project/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main () async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      title: "IoT App",
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName:(context) =>  const RegisterScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
      },

    );
  }

}