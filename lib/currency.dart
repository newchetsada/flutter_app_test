import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class currencyPage extends StatefulWidget {
  @override
  _currencyPageState createState() => _currencyPageState();
}

class _currencyPageState extends State<currencyPage> {
  getAPI() async {
    var response = await Http.get(
      Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'),
      headers: <String, String>{},
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Currency BTC'),
          ],
        ),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getAPI();
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
