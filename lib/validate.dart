import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class validatePage extends StatefulWidget {
  @override
  _validatePageState createState() => _validatePageState();
}

class _validatePageState extends State<validatePage> {
  var input = TextEditingController();
  bool? result;

  _showpopup(size, title, casenum) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, myState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.all(0),
            title: Text(title),
            content: SingleChildScrollView(
              child: SizedBox(
                width: size,
                child: Column(
                  children: [
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
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              enabledBorder: myinputborder(),
                              focusedBorder: myinputborder()),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    (result == null)
                        ? Container()
                        : (result == true)
                            ? Text(
                                'ข้อมูลถูกต้อง',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15),
                              )
                            : Text(
                                'ข้อมูลไม่ถูกต้อง',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Validate',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                onPressed: () {
                  //case1
                  if (casenum == 1) {
                    if (input.text.length > 5) {
                      myState(() {
                        result = true;
                      });
                    } else {
                      myState(() {
                        result = false;
                      });
                    }
                  }

                  //case2
                  if (casenum == 2) {
                    if (RegExp(r"(\d)\1{2}").hasMatch(input.text)) {
                      myState(() {
                        result = false;
                      });
                    } else {
                      myState(() {
                        result = true;
                      });
                    }
                  }

                  //case3
                  if (casenum == 3) {
                    if (RegExp(
                            r"012|123|234|345|456|567|678|789|987|876|765|654|543|432|321|210")
                        .hasMatch(input.text)) {
                      myState(() {
                        result = false;
                      });
                    } else {
                      myState(() {
                        result = true;
                      });
                    }
                  }
                  int countMatches(String string, RegExp pattern) {
                    Iterable<Match> matches = pattern.allMatches(string);
                    return matches.length;
                  }

                  //case4
                  if (casenum == 4) {
                    int count = countMatches(input.text, RegExp(r"(\d)\1{1}"));
                    if (count > 2) {
                      myState(() {
                        result = false;
                      });
                    } else {
                      myState(() {
                        result = true;
                      });
                    }
                  }
                },
              ),
              TextButton(
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Validate'),
        backgroundColor: Colors.purple[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    input.text = '';
                    result = null;
                  });
                  _showpopup(
                      screenWidth - 100, 'ความยาวมากกว่าหรือเท่ากับ 6', 1);
                },
                child: Text('ความยาวมากกว่าหรือเท่ากับ 6')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    input.text = '';
                    result = null;
                  });
                  _showpopup(screenWidth - 100,
                      'กันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว', 2);
                },
                child: Text('กันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    input.text = '';
                    result = null;
                  });
                  _showpopup(
                      screenWidth - 100, 'กันไม่ให้มีเลขเรียงกันเกิน 2 ตัว', 3);
                },
                child: Text('กันไม่ให้มีเลขเรียงกันเกิน 2 ตัว')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    input.text = '';
                    result = null;
                  });
                  _showpopup(
                      screenWidth - 100, 'กันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด', 4);
                },
                child: Text('กันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด')),
          ],
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
