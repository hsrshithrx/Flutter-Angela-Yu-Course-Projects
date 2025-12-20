import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coingecko_api.dart';

final CoinGeckoApi coinGeckoApi = CoinGeckoApi();



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String? selectedCurrency = 'USD';

  double? btcPrice;
  double? ethPrice;
  double? ltcPrice;

  DropdownButton<String> android(){
    List<DropdownMenuItem<String>> dropdownItems = [];

    for(String currency in currenciesList){
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }


    return DropdownButton <String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value){
          setState(() {
            selectedCurrency=value;
          });
          updatePrices();
        });
  }


  CupertinoPicker iOSPicker(){
    List<Text> pickerItems= [];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
        });
        updatePrices(); // ✅ CALL API HERE
      },
      children: currenciesList.map((currency) {
        return Text(currency);
      }).toList(),
    );

  }

  Future<void> updatePrices() async {
    try {
      final btc = await coinGeckoApi.getPrice(
        cryptoId: 'bitcoin',
        currency: selectedCurrency!.toLowerCase(),
      );

      final eth = await coinGeckoApi.getPrice(
        cryptoId: 'ethereum',
        currency: selectedCurrency!.toLowerCase(),
      );

      final ltc = await coinGeckoApi.getPrice(
        cryptoId: 'litecoin',
        currency: selectedCurrency!.toLowerCase(),
      );

      setState(() {
        btcPrice = btc;
        ethPrice = eth;
        ltcPrice = ltc;
      });
    } catch (e) {
      print('Error fetching prices: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    updatePrices();
  }

  Widget buildCryptoCard({
    required String crypto,
    required double? value,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${value?.toStringAsFixed(2) ?? '...'} $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Coin Ticker')),
        backgroundColor: Colors.lightBlue ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildCryptoCard(crypto: 'BTC', value: btcPrice),
          buildCryptoCard(crypto: 'ETH', value: ethPrice),
          buildCryptoCard(crypto: 'LTC', value: ltcPrice),

          const Spacer(),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : android(),
          ),
        ],
      ),
    );
  }
}
