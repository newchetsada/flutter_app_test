import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class filterArray extends StatefulWidget {
  @override
  _filterArrayState createState() => _filterArrayState();
}

class _filterArrayState extends State<filterArray> {
  List<int> array1 = [1, 2, 3, 4, 5, 8, 11];
  List<int> array2 = [2, 4, 6, 8, 10, 11];
  List<int> arrayfil = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < array1.length; i++) {
      for (int a = 0; a < array2.length; a++) {
        if (array1[i] == array2[a]) {
          arrayfil.add(array2[a]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Array'),
        backgroundColor: Colors.purple[100],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'array1 = $array1',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'array2 = $array2',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'filter array = $arrayfil',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
