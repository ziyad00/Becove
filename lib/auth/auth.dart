import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14213D),
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
                backgroundColor: Color(0xFFFCA311), minimumSize: Size(200, 40)),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign  in with Google"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFCA311), minimumSize: Size(200, 40)),
          ),
        ],
      )),
    );
  }
}
