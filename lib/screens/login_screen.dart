import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/model/user.dart';
import 'package:iot_project/screens/home_layout.dart';
import 'package:iot_project/screens/register_screen.dart';

import '../network/user_fun.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isVisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Welcome Back",
                style: TextStyle(
                    color: Color(0xFFFD7001),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Sign to continue",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            Form(
              key: formKey,
                child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "You must enter this field";
                    }
                    var regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (!regex.hasMatch(value)) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      suffixIcon: const Icon(
                        Icons.email_outlined,
                        color: Color(0xFFFD7001),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              style: BorderStyle.solid, width: 0.4))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passController,
                  obscureText: !isVisible,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "You must enter this field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: InkWell(
                        onTap: () {
                          isVisible = !isVisible;
                          setState(() {});
                        },
                        child: isVisible == true
                            ? const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 28,
                          color: Color(0xfffb6f01),
                        )
                            : const Icon(
                          Icons.visibility_off_outlined,
                          size: 28,
                          color: Color(0xfffb6f01),
                        ),
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              style: BorderStyle.solid, width: 0.4))),
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  onPressed: () {
                       login(context);


                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xFFFD7001),
                    ),
                    fixedSize: WidgetStatePropertyAll(Size(220, 45)),
                  ),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xff707070), fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text(
                        "Create account",
                        style: TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        var user = userCredential.user;
        if (user != null) {
          var credentialUser = await UserFun.getUser(user.uid);
          Navigator.pushReplacementNamed(context, HomeLayout.routeName, arguments: credentialUser);

        }
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: const Text('Incorrect email or password'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error signing in: $e');
      }
    }
  }

}
