import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage:  AssetImage('images/ddd.png'),
                  ),
                Text(
                  'Harshit Rawat',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                Text(
                'FLUTTER DEVELOPER',
                  style: TextStyle(
                    fontFamily: 'Source Code Pro',
                    color: Colors.teal[100],
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),

                  child: ListTile(

                        leading: Icon(
                          Icons.phone,
                          color: Colors.teal,
                        ),

                        title: Text(
                          '+91 6387 404 369',
                          style: TextStyle(
                            color: Colors.teal[900],
                            fontFamily: 'Source Code Pro',
                            fontSize: 20.0,
                          ),

                        ),



                    ),

                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'harshit@gmail.com',
                        style: TextStyle(
                          fontFamily: 'Source Code Pro',
                          fontSize: 20.0,
                          color: Colors.teal[900],
                        ),
                      ),

                    ),
                  ),




              ],

            ),
          ),
        ),
      ),
    );
  }
}




