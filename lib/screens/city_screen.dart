import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityname= '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ss.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.5),borderRadius: BorderRadius.all(Radius.circular(30))),

                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            onChanged: (value){
                              cityname = value ;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              icon : Icon(Icons.location_city , color : Colors.white),
                              hintText: 'Enter city name',
                              hintStyle: TextStyle(color: Colors.grey,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide.none,
                              ),


                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context,cityname);
                          },
                          child: Text(
                            'Get Weather',
                            style : kButtonTextStyle.copyWith(
                              color: Colors.white, // Set the desired text color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
