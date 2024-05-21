import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/login_screen.dart';

import '../model/user.dart';
import '../network/user_fun.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "register-screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isVisiblePass = false;
  bool isVisibleConfirmPass = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFFFD7001),
                    size: 30,
                  )),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFFD7001),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Create a new account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter this field";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "UserName",
                            suffixIcon: const Icon(
                              Icons.perm_identity,
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your password";
                          }
                          var regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (!regex.hasMatch(value)) {
                            return "Invalid password";
                          }

                          return null;
                        },
                        obscureText: !isVisiblePass,
                        decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: InkWell(
                              onTap: () {
                                isVisiblePass = !isVisiblePass;
                                setState(() {});
                              },
                              child: isVisiblePass == true
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
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmPassController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter confirm password";
                          }
                          if (value != passController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        obscureText: !isVisibleConfirmPass,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            suffixIcon: InkWell(
                              onTap: () {
                                isVisibleConfirmPass = !isVisibleConfirmPass;
                                setState(() {});
                              },
                              child: isVisibleConfirmPass == true
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
                        height: 60,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFFFD7001),
                            ),
                            fixedSize: MaterialStatePropertyAll(Size(230, 45)),
                          ),
                          child: const Text(
                            "CREATE ACCOUNT",
                            style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      try {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text);

        UserFun.createUser(Users(
            id: user.user?.uid,
            userName: userNameController.text,
            email: emailController.text,
            password: passController.text));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
