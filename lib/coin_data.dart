import 'package:http/http.dart' as http;
import 'dart:convert';

const coinApiURL = 'https://rest-sandbox.coinapi.io/v1/exchangerate';
const apiKey = '3C4F9919-326B-4DA6-B018-BF58FAAF75A8';

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
  'NGN',
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
//  Create the Asynchronous method getCoinData() that returns a Future (the price data).
  Future getCoinData(String selectedCurrency) async {
//    Create a url combining the coinAPIURL with the currencies we're interested, BTC to USD.
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinApiURL/$crypto/$selectedCurrency?apikey=$apiKey';

//    Make a GET request to the URL and wait for the response
      http.Response response = await http.get(requestURL);

//    Ensure the request was successful.
      if (response.statusCode == 200) {
//      Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
        var decodedData = jsonDecode(response.body);
//      Get the last price of bitcoin with the key 'last'.
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw "Not you, it's us!";
      }
    }

    return cryptoPrices;
  }
}
