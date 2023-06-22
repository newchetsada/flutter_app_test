import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fibonacci extends StatefulWidget {
  @override
  _FibonacciState createState() => _FibonacciState();
}

class _FibonacciState extends State<Fibonacci> {
  var input = TextEditingController();
  String result = '';
  List<int> genFibonacci(int count) {
    List<int> fibonacci = [];

    if (count <= 0) {
      return fibonacci;
    }

    fibonacci.add(0);

    if (count == 1) {
      return fibonacci;
    }

    fibonacci.add(1);

    if (count == 2) {
      return fibonacci;
    }

    for (int i = 2; i < count; i++) {
      int nextNumber = fibonacci[i - 1] + fibonacci[i - 2];
      fibonacci.add(nextNumber);
    }

    return fibonacci;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('generate ตัวเลข Fibonacci'),
        backgroundColor: Colors.purple[100],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ใส่จำนวนที่ต้องการ generate',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: input,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                        enabledBorder: myinputborder(),
                        focusedBorder: myinputborder()),
                  )),
              TextButton(
                child: const Text(
                  'Generate',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                onPressed: () {
                  if (input.text.isNotEmpty) {
                    int count = int.parse(input.text);
                    List<int> fibonacciNumbers = genFibonacci(count);
                    print(fibonacciNumbers);
                    setState(() {
                      result = fibonacciNumbers.toString();
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                result,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return OutlineInputBorder(

      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.purple.withOpacity(0.3),
        width: 1,
      ));
}
