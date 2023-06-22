import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class primeNum extends StatefulWidget {
  @override
  _primeNumState createState() => _primeNumState();
}

class _primeNumState extends State<primeNum> {
  var input = TextEditingController();
  String result = '';

  bool isPrimeNum(int number) {
    if (number <= 1) {
      return false;
    }
    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  List<int> genPrime(int count) {
    List<int> primeNumbers = [];
    int number = 2;
    while (primeNumbers.length < count) {
      if (isPrimeNum(number)) {
        primeNumbers.add(number);
      }
      number++;
    }
    return primeNumbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('generate จำนวนเฉพาะ'),
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
                    List<int> primeNumbers = genPrime(count);
                    print(primeNumbers);
                    setState(() {
                      result = primeNumbers.toString();
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
