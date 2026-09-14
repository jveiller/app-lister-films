import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/pages/films/data/donnees/page_donnees.dart';
import 'package:culture_app1/pages/films/data/top/page_top.dart';
import 'package:flutter/material.dart';

class DataFilm extends StatefulWidget {
  final List<FilmsVu> listeFilmsVu;
  final List<FilmsVoir> listeFilmsVoir;
  const DataFilm({
    super.key,
    required this.listeFilmsVu,
    required this.listeFilmsVoir,
  });

  @override
  State<DataFilm> createState() => _DataFilmState();
}

class _DataFilmState extends State<DataFilm> {
  int numPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(
          texteBar: 'FILMS',
          couleur: filmJaune,
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
                PageDonnees(
                  listeFilmsVu: widget.listeFilmsVu,
                  listeFilmsVoir: widget.listeFilmsVoir,
                ),
                PageTop(listeFilmsVu: widget.listeFilmsVu),
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
                      color: numPage == 0 ? filmJaune : Colors.white,
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
                      color: numPage == 1 ? filmJaune : Colors.white,
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
