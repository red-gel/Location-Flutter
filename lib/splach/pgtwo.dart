import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'pgthree.dart';

class Pgtwo extends StatefulWidget {


  @override
  _PgtwoState createState() => _PgtwoState();
}

class _PgtwoState extends State<Pgtwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      
      ),
      body: Column(
        
        children: [
          Padding(padding: EdgeInsets.only(left:70),
          child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Lottie.asset('assets/virus.json'),
              ),
          ),
          Padding(padding: EdgeInsets.only(left:80),
          child: Text('Find the safe place & \nSAFE FROM COVID ',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90, left: 60),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
              icon: Icon(Icons.arrow_right_alt_sharp),
              color: Colors.white,
              iconSize: 43,
               onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Pgthree()));}),
            )
          ),
        ],
      ),
    );
  }
}