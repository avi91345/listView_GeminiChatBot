import "dart:async";

import "package:flutter/material.dart";

import "../main.dart";

class splashscreen extends StatefulWidget{
  @override
  State<splashscreen> createState() => splash();

  }
class splash extends State<splashscreen>{
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MyHomePage(title: 'SpeakX Assignment')));
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue,
            child: Center(child: Text("SpeakX",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w700,color: Colors.white)))
        )
    );
  }

}


