import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/pages/films/data/affiche_donnees.dart';
import 'package:culture_app1/pages/films/data/menu_deroulant_data.dart';
import 'package:flutter/material.dart';

class PageDonnees extends StatefulWidget {
  final List<FilmsVu> listeFilmsVu;
  const PageDonnees({super.key, required this.listeFilmsVu});

  @override
  State<PageDonnees> createState() => _PageDonneesState();
}

class _PageDonneesState extends State<PageDonnees> {
  late List<FilmsVu> _filmsVu;
  String value1 = 'GLOBAL';
  List<String> listValues1 = ['GLOBAL', 'ANNÉE', 'MOIS'];
  late List<String> listValues2;
  List<String> listValues3 = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  List<String> listAffichage3 = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre',
  ];
  late String value2;
  late String value3;
  double largeurDeroulant = 350;
  late List<FilmsVu> listFilmsDate;

  @override
  void initState() {
    super.initState();
    _filmsVu = widget.listeFilmsVu;
    listFilmsDate = widget.listeFilmsVu.where((f) => f.date != null).toList();
    value2 = DateTime.now().year.toString();
    value3 = (DateTime.now().month).toString();
    List<FilmsVu> listTri = listFilmsDate;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues2 = [listTri.first.date!.year.toString()];
      } else {
        listTri.sort((a, b) => b.date!.compareTo(a.date!));
        int anneeMin = listTri.last.date!.year;
        int anneeMax = listTri.first.date!.year;
        listValues2 = [];
        for (var i = anneeMax; i >= anneeMin; i--) {
          listValues2.add(i.toString());
        }
      }
    }
  }

  void fctChange1(String val) {
    setState(() {
      value1 = val;
      if (value1 == 'GLOBAL') {
        _filmsVu = widget.listeFilmsVu;
      } else if (value1 == 'ANNÉE') {
        _filmsVu = listFilmsDate
            .where((f) => f.date!.year == int.parse(value2))
            .toList();
      } else if (value1 == 'MOIS') {
        _filmsVu = listFilmsDate
            .where(
              (f) =>
                  f.date!.year == int.parse(value2) &&
                  f.date!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange2(String val) {
    setState(() {
      value2 = val;
      if (value1 == 'ANNÉE') {
        _filmsVu = listFilmsDate
            .where((f) => f.date!.year == int.parse(value2))
            .toList();
      } else if (value1 == 'MOIS') {
        _filmsVu = listFilmsDate
            .where(
              (f) =>
                  f.date!.year == int.parse(value2) &&
                  f.date!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange3(String val) {
    setState(() {
      value3 = val;
      _filmsVu = listFilmsDate
          .where(
            (f) =>
                f.date!.year == int.parse(value2) &&
                f.date!.month == int.parse(value3),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: MenuDeroulantData(
            value: value1,
            fctChange: fctChange1,
            listValues: listValues1,
            listAffichage: listValues1,
            largeurDeroulant: largeurDeroulant,
          ),
        ),
        if (value1 != 'GLOBAL') ...[
          SizedBox(height: 10),
          Center(
            child: MenuDeroulantData(
              value: value2,
              fctChange: fctChange2,
              listValues: listValues2,
              listAffichage: listValues2,
              largeurDeroulant: largeurDeroulant,
            ),
          ),
        ],
        if (value1 == 'MOIS') ...[
          SizedBox(height: 10),
          Center(
            child: MenuDeroulantData(
              value: value3,
              fctChange: fctChange3,
              listValues: listValues3,
              listAffichage: listAffichage3,
              largeurDeroulant: largeurDeroulant,
            ),
          ),
        ],
        SizedBox(height: 10),
        AfficheDonnees(listeFilms: _filmsVu),
      ],
    );
  }
}
