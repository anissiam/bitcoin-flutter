import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() {
    return _PriceScreenState();
  }
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'AUD';
  CoinData coinData = new CoinData();
  String bitcoinValue = '?';

  /*List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String ss in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(ss),
        value: ss,
      );
      dropdownMenuItems.add(newItem);
    }
    return dropdownMenuItems;
  }*/

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String ss in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(ss),
        value: ss,
      );
      dropdownMenuItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          selectCurrency = value.toString();
          getBitcoinValue();

        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> widget = [];
    for (String ss in currenciesList) {
      var newItem = Text(ss);
      widget.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.blue,
      onSelectedItemChanged: (int value) {
        setState(() {
          selectCurrency = currenciesList[value];
          getBitcoinValue();

        });
      },
      children: widget,
    );
  }

  dynamic getPikcer() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return getDropdownButton();
    }
  }

  getBitcoinValue() async {
    var data = await coinData.getData(selectCurrency);
    double bitcoinD = data['rate'];
    bitcoinValue = bitcoinD.toStringAsFixed(0);
  }
  @override
  void initState() {
    super.initState();
    getBitcoinValue();

  }

  /*List<Text> getPikcerItems() {
    List<Text> widget = [];
    for (String ss in currenciesList) {
      var newItem = Text(ss);
      widget.add(newItem);
    }
    return widget;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValue USD ',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPikcer()),
        ],
      ),
    );
  }
}
