import 'package:flutter/material.dart';
import 'package:flutter_app_test/currency.dart';
import 'package:flutter_app_test/fibonacci.dart';
import 'package:flutter_app_test/filterarray.dart';
import 'package:flutter_app_test/primenum.dart';
import 'package:flutter_app_test/validate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => currencyPage()));
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: Center(
                      child: Text(
                    'Currency',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Fibonacci()));
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: Center(
                      child: Text(
                    'Fibonacci',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => primeNum()));
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: Center(
                      child: Text(
                    'จำนวนเฉพาะ',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => filterArray()));
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: Center(
                      child: Text(
                    'Filter Array',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => validatePage()));
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: Center(
                      child: Text(
                    'Validate',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
