import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/principal.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Principal())));
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage("assets/images/fish3.png"),
                    height: 100,
                    width: 300),
                SizedBox(
                  height: 40,
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          )),
    );
  }
}
