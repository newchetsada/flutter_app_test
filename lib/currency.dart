import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as Http;
import 'package:intl/intl.dart';

class currencyPage extends StatefulWidget {
  @override
  _currencyPageState createState() => _currencyPageState();
}

class _currencyPageState extends State<currencyPage> {
  double curEUR = 0.0;
  double curGBP = 0.0;
  double curUSD = 0.0;
  int page = 0;
  var history = <classHistory>[];

  late Timer _timer;

  var input_eur = TextEditingController();
  var input_gbp = TextEditingController();
  var input_usd = TextEditingController();

  var out_eur = TextEditingController();
  var out_gbp = TextEditingController();
  var out_usd = TextEditingController();

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
              EUR: value['bpi']['EUR']['rate_float'],
              GBP: value['bpi']['GBP']['rate_float'],
              USD: value['bpi']['USD']['rate_float']));
          curEUR = value['bpi']['EUR']['rate_float'];
          curGBP = value['bpi']['GBP']['rate_float'];
          curUSD = value['bpi']['USD']['rate_float'];
        });
      }
    });
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      getAPI().then((value) {
        if (value != null) {
          setState(() {
            history.add(classHistory(
                updated: value['time']['updated'],
                EUR: value['bpi']['EUR']['rate_float'],
                GBP: value['bpi']['GBP']['rate_float'],
                USD: value['bpi']['USD']['rate_float']));
            curEUR = value['bpi']['EUR']['rate_float'];
            curGBP = value['bpi']['GBP']['rate_float'];
            curUSD = value['bpi']['USD']['rate_float'];
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  _showCal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calculate'),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close))
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: input_eur,
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
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'EUR = ',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: out_eur,
                          readOnly: true,
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.1),
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              enabledBorder: myinputborder(),
                              focusedBorder: myinputborder()),
                        )),
                    Text(
                      ' BTC',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: input_gbp,
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
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'GBP = ',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: out_gbp,
                          readOnly: true,
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.1),
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              enabledBorder: myinputborder(),
                              focusedBorder: myinputborder()),
                        )),
                    Text(
                      ' BTC',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: input_usd,
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
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'USD = ',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: out_usd,
                          readOnly: true,
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.1),
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              enabledBorder: myinputborder(),
                              focusedBorder: myinputborder()),
                        )),
                    Text(
                      ' BTC',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                ),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              onPressed: () {
                if (input_eur.text.isNotEmpty) {
                  setState(() {
                    out_eur.text = NumberFormat("#,###.####")
                        .format(double.parse(input_eur.text) / curEUR)
                        .toString();
                  });
                }
                if (input_gbp.text.isNotEmpty) {
                  setState(() {
                    out_gbp.text = NumberFormat("#,###.####")
                        .format(double.parse(input_gbp.text) / curGBP)
                        .toString();
                  });
                }
                if (input_usd.text.isNotEmpty) {
                  setState(() {
                    out_usd.text = NumberFormat("#,###.####")
                        .format(double.parse(input_usd.text) / curUSD)
                        .toString();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  _showCalApp(size) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: EdgeInsets.all(0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calculate'),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close))
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: size,
              child: Column(
                children: [
                  Text(
                    'EUR/BTC',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: input_eur,
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

                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: out_eur,
                        readOnly: true,
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            enabledBorder: myinputborder(),
                            focusedBorder: myinputborder()),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'GBP/BTC',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: input_gbp,
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

                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: out_gbp,
                        readOnly: true,
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            enabledBorder: myinputborder(),
                            focusedBorder: myinputborder()),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'USD/BTC',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: input_usd,
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

                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: out_usd,
                        readOnly: true,
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green.withOpacity(0.1),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            enabledBorder: myinputborder(),
                            focusedBorder: myinputborder()),
                      )),

                  // Text('Would you like to approve of this message?'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              onPressed: () {
                if (input_eur.text.isNotEmpty) {
                  setState(() {
                    out_eur.text = NumberFormat("#,###.####")
                        .format(double.parse(input_eur.text) / curEUR)
                        .toString();
                  });
                }
                if (input_gbp.text.isNotEmpty) {
                  setState(() {
                    out_gbp.text = NumberFormat("#,###.####")
                        .format(double.parse(input_gbp.text) / curGBP)
                        .toString();
                  });
                }
                if (input_usd.text.isNotEmpty) {
                  setState(() {
                    out_usd.text = NumberFormat("#,###.####")
                        .format(double.parse(input_usd.text) / curUSD)
                        .toString();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget cardCur(title, cur) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  style: TextStyle(fontSize: 30, color: Colors.black54),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '$cur',
                      style: TextStyle(fontSize: 30, color: Colors.green),
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
                  ' $title',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    return (screenWidth > 800)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: false,
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
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black54)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Currency BTC',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.black54),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCal();
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              'Calculate',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          children: [
                            Expanded(child: cardCur('EUR', curEUR)),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: cardCur('GBP', curGBP)),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: cardCur('USD', curUSD))
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
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black54),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'DateTime',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'BTC/EUR',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'BTC/GBP',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'BTC/USD',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                primary: false,
                                itemCount: history.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            history[index].updated,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].EUR}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].GBP}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].USD}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
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
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              toolbarHeight: 60,
              flexibleSpace: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black54)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Currency BTC',
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          onPageChanged: (value) {
                            setState(() {
                              page = value;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: cardCur('EUR', curEUR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: cardCur('GBP', curGBP),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: cardCur('USD', curUSD),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: (page == 0)
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: (page == 1)
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: (page == 2)
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  bottom: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    _showCalApp(screenWidth - 100);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueAccent.withOpacity(0.2),
                    ),
                    child: Center(
                        child: Text(
                      'Calculate',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    )),
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
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'BTC/EUR',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'BTC/GBP',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'BTC/USD',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            primary: false,
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    history[index].updated,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.green),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].EUR}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].GBP}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${history[index].USD}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ]),
          );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return OutlineInputBorder(

      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.green.withOpacity(0.4),
        width: 1,
      ));
}

class classHistory {
  final String updated;
  final double EUR;
  final double GBP;
  final double USD;

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
