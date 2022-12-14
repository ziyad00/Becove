import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/constants/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to Becove!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                // fontWeight: FontWeight.bold,
              )),
          Text(
            'continue without creating an account',
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
          ),
          SizedBox(
            height: 200,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign  in with Apple"),
            style: ElevatedButton.styleFrom(
                backgroundColor: orangeYellow, minimumSize: Size(200, 40)),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign  in with Google"),
            style: ElevatedButton.styleFrom(
                backgroundColor: orangeYellow, minimumSize: Size(200, 40)),
          ),
        ],
      )),
    );
  }
}
