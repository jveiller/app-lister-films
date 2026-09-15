import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/pages/series/data/donnees/page_donnees_serie.dart';
import 'package:culture_app1/pages/series/data/top/page_top_serie.dart';
import 'package:flutter/material.dart';

class DataSerie extends StatefulWidget {
  final List<Serie> listeSeries;
  const DataSerie({super.key, required this.listeSeries});

  @override
  State<DataSerie> createState() => _DataSerieState();
}

class _DataSerieState extends State<DataSerie> {
  int numPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(
          texteBar: 'SÉRIES',
          couleur: serieOrange,
          retour: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  numPage = value;
                });
              },
              children: [
                PageDonneesSerie(listeSeries: widget.listeSeries),
                PageTopSerie(listeSeries: widget.listeSeries),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      numPage = 0;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(360),
                      color: numPage == 0 ? serieOrange : Colors.white,
                    ),
                    width: TailleAdaptateur.width(context, 15),
                    height: TailleAdaptateur.width(context, 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      numPage = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(360),
                      color: numPage == 1 ? serieOrange : Colors.white,
                    ),
                    width: TailleAdaptateur.width(context, 15),
                    height: TailleAdaptateur.width(context, 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
