import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class currencyPage extends StatefulWidget {
  @override
  _currencyPageState createState() => _currencyPageState();
}

class _currencyPageState extends State<currencyPage> {
  String curEUR = '';
  String curGBP = '';
  String curUSD = '';
  var history = <classHistory>[];

  late Timer _timer;

  getAPI() async {
    var response = await Http.get(
      Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'),
      headers: <String, String>{},
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      return jsonResponse;
    }
  }

  @override
  void initState() {
    super.initState();
    getAPI().then((value) {
      if (value != null) {
        setState(() {
          history.add(classHistory(
              updated: value['time']['updated'],
              EUR: value['bpi']['EUR']['rate'],
              GBP: value['bpi']['GBP']['rate'],
              USD: value['bpi']['USD']['rate']));
          curEUR = value['bpi']['EUR']['rate'];
          curGBP = value['bpi']['GBP']['rate'];
          curUSD = value['bpi']['USD']['rate'];
        });
      }
    });
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      getAPI().then((value) {
        if (value != null) {
          setState(() {
            history.add(classHistory(
                updated: value['time']['updated'],
                EUR: value['bpi']['EUR']['rate'],
                GBP: value['bpi']['GBP']['rate'],
                USD: value['bpi']['USD']['rate']));
            curEUR = value['bpi']['EUR']['rate'];
            curGBP = value['bpi']['GBP']['rate'];
            curUSD = value['bpi']['USD']['rate'];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 70,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Currency BTC',
                    style: TextStyle(fontSize: 30, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        'Calculate',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '1 BTC = ',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          curEUR,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      ' EUR',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '1 BTC = ',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          curGBP,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      ' GBP',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black54),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '1 BTC = ',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          curUSD,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      ' USD',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black54),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'History',
                          style: TextStyle(fontSize: 30, color: Colors.black54),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'DateTime',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'BTC/EUR',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'BTC/GBP',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'BTC/USD',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      history[index].updated,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      history[index].EUR,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      history[index].GBP,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      history[index].USD,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class classHistory {
  final String updated;
  final String EUR;
  final String GBP;
  final String USD;

  const classHistory({
    required this.updated,
    required this.EUR,
    required this.GBP,
    required this.USD,
  });

  factory classHistory.fromJson(Map<String, dynamic> json) {
    return classHistory(
      updated: json['updated'],
      EUR: json['EUR'],
      GBP: json['GBP'],
      USD: json['USD'],
    );
  }
}
