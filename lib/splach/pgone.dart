import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phone_verification/screens/HomeScreen.dart';
import 'package:phone_verification/splach/pgtwo.dart';

class Pgone extends StatefulWidget {
  

  @override
  _PgoneState createState() => _PgoneState();
}

class _PgoneState extends State<Pgone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
       
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Text('Skip', style: TextStyle(
                color: Colors.purple,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          SizedBox(width: 18,)
        ],
      ),
      body: Column(
        
        children: [
          Padding(padding: EdgeInsets.only(left:70),
          child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Lottie.asset('assets/tick.json'),
              ),
          ),
          Padding(padding: EdgeInsets.all(20),
          child: Text('verified! Enjoy the safety',
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
              child: IconButton(icon: Icon(Icons.arrow_right_alt_sharp),
              color: Colors.white,
              iconSize: 43,
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Pgtwo()));
               }),
            )
          ),
        ],
      ),
    );
  }
}