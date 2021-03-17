import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebScraper webScraper;
  bool loaded = false;
  String mom;
  String gold;
  int igold;
  String sippal;
  int isippal;
  String sipsa;
  int isipsa;
  String platinum;
  int iplatinum;
  String silver;
  int isilver;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    webScraper = WebScraper('http://www.jongrogx.com/');
    if (await webScraper.loadWebPage('/')) {
      List<Map<String, dynamic>> results =
          webScraper.getElement('tbody', ['title']);
      setState(() {
        loaded = true;
        mom = results[0]['title'];

        gold = mom.substring(mom.indexOf('순금시세'), mom.indexOf('18K'));
        gold = gold.substring(0, gold.indexOf('원'));
        gold = gold.substring(gold.length - 8, gold.length);
        String sgold = gold.replaceAll(RegExp(','), '');
        igold = int.parse(sgold);
        print(igold);

        sippal = mom.substring(mom.indexOf('18K'), mom.indexOf('14K'));
        sippal = sippal.substring(0, sippal.indexOf('원'));
        sippal = sippal.substring(sippal.length - 8, sippal.length);
        String ssippal = sippal.replaceAll(RegExp(','), '');
        isippal = int.parse(ssippal);
        print(isippal);

        sipsa = mom.substring(mom.indexOf('14K'), mom.indexOf('백금시세'));
        sipsa = sipsa.substring(0, sipsa.indexOf('원'));
        sipsa = sipsa.substring(sipsa.length - 8, sipsa.length);
        String ssipsa = sipsa.replaceAll(RegExp(','), '');
        isipsa = int.parse(ssipsa);
        print(isipsa);

        platinum = mom.substring(mom.indexOf('백금시세'), mom.indexOf('은시세'));
        platinum = platinum.substring(0, platinum.indexOf('원'));
        platinum = platinum.substring(platinum.length - 8, platinum.length);
        String splatinum = platinum.replaceAll(RegExp(','), '');
        iplatinum = int.parse(splatinum);
        print(iplatinum);

        silver = mom.substring(mom.indexOf('은시세'), mom.length);
        silver = silver.substring(0, silver.indexOf('원'));
        silver = silver.substring(silver.length - 8, silver.length);
        String ssilver = silver.replaceAll(RegExp(','), '');
        isilver = int.parse(ssilver);
        print(isilver);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          (loaded) ? Text(gold) : CircularProgressIndicator(),
          (loaded) ? Text(sippal) : CircularProgressIndicator(),
          (loaded) ? Text(sipsa) : CircularProgressIndicator(),
          (loaded) ? Text(platinum) : CircularProgressIndicator(),
          (loaded) ? Text(silver) : CircularProgressIndicator(),
        ],
      )),
    );
  }
}
