import 'package:flutter/material.dart';

// the main if the starting point for all our flutter apps
void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Center(child: Text('I Am Rich')),
          backgroundColor: Colors.blueGrey[900],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,


          )

        ),
        body: Center(
          child:Image(
          image: AssetImage('images/diamond.png'),
          ),
        )
      )
    )
  );
}