// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:volantisassignmenttoaditya/presentation/widget/utils/location_permission.dart';

//import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 60,
                width: 200,
              ),

              // Login text Widget
              Center(
                child: Container(
                  height: 200,
                  width: 400,
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Text(
                        "Volantis Assignment Test",
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 70, 122),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Aditya Hermanto",
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 23, 37),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 400,
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(
                height: 60,
                width: 10,
              ),

              // Wrong Password text
              Visibility(
                visible: _isVisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "you have no access to enter",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              // Textfields for username and password fields
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      controller: usernameController, // Controller for Username
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          contentPadding: EdgeInsets.all(20)),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      child: Text("username : aditya"),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 70,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: RaisedButton(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    // ignore: sort_child_properties_last
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      String value = "aditya";
                      setState(() {
                        value = usernameController.text;
                        // value = value;
                      });
                      if (value == "aditya") {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          _isVisible = true;
                        });
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
