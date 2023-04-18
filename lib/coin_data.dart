import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getData(String coin) async {
    Uri uri = Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$coin?apikey=8D55E99D-1F12-4B22-9EA7-B34485A82EB3');
    http.Response response= await http.get(uri);
    if(response.statusCode==200){
      String data = response.body;
      print(data);

      return jsonDecode(data);

    }else{
      print(response.statusCode);
    }
  }


}
