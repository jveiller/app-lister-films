import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/pages/films/data/menu_deroulant_data.dart';
import 'package:culture_app1/pages/series/data/top/affiche_top_serie.dart';
import 'package:flutter/material.dart';

class PageTopSerie extends StatefulWidget {
  final List<Serie> listeSeries;
  const PageTopSerie({super.key, required this.listeSeries});

  @override
  State<PageTopSerie> createState() => _PageTopSerieState();
}

class _PageTopSerieState extends State<PageTopSerie> {
  late List<Serie> _series;
  late List<Serie> _seriesVues;
  String value1 = 'GLOBAL';
  List<String> listValues1 = ['GLOBAL', 'DATE SORTIE', 'DATE VISIONNAGE'];
  late List<String> listValues21;
  late List<String> listValues22;
  List<String> listValues3 = [
    '0',
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
    'Global',
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
  late String value21;
  late String value22;
  String value3 = '0';
  double largeurDeroulant = 350;
  late List<Serie> listSeriesDate;
  late List<Serie> listSeriesAnnee;

  @override
  void initState() {
    super.initState();
    _seriesVues = widget.listeSeries.where((s) => s.statut == 'vu').toList();
    _series = _seriesVues;
    listSeriesDate = _seriesVues.where((s) => s.dateFinEffective != null).toList();
    value21 = DateTime.now().year.toString();
    value22 = DateTime.now().year.toString();
    List<Serie> listTri = listSeriesDate;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues21 = [listTri.first.dateFinEffective!.year.toString()];
      } else {
        listTri.sort((a, b) => b.dateFinEffective!.compareTo(a.dateFinEffective!));
        int anneeMin = listTri.last.dateFinEffective!.year;
        int anneeMax = listTri.first.dateFinEffective!.year;
        listValues21 = [];
        for (var i = anneeMax; i >= anneeMin; i--) {
          listValues21.add(i.toString());
        }
      }
    } else {
      listValues21 = [value21];
    }
    listSeriesAnnee = _seriesVues.where((s) => s.annee != null).toList();
    listTri = listSeriesAnnee;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues22 = [listTri.first.annee!.toString()];
      } else {
        listTri.sort((a, b) => b.annee!.compareTo(a.annee!));
        listValues22 = [];
        for (Serie s in listTri) {
          if (!listValues22.contains(s.annee.toString())) {
            listValues22.add(s.annee.toString());
          }
        }
      }
    } else {
      listValues22 = [value22];
    }
  }

  void fctChange1(String val) {
    setState(() {
      value1 = val;
      if (value1 == 'GLOBAL') {
        _series = _seriesVues;
      } else if (value1 == 'DATE SORTIE') {
        _series = listSeriesAnnee
            .where((s) => s.annee == int.parse(value22))
            .toList();
      } else if (value1 == 'DATE VISIONNAGE') {
        _series = listSeriesDate
            .where(
              (s) =>
                  s.dateFinEffective!.year == int.parse(value21) && int.parse(value3) == 0
                  ? true
                  : s.dateFinEffective!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange2(String val) {
    setState(() {
      if (value1 == 'DATE SORTIE') {
        value22 = val;
        _series = listSeriesAnnee
            .where((s) => s.annee! == int.parse(value22))
            .toList();
      } else if (value1 == 'DATE VISIONNAGE') {
        value21 = val;
        _series = listSeriesDate
            .where(
              (s) =>
                  s.dateFinEffective!.year == int.parse(value21) &&
                  (int.parse(value3) == 0
                      ? true
                      : s.dateFinEffective!.month == int.parse(value3)),
            )
            .toList();
      }
    });
  }

  void fctChange3(String val) {
    setState(() {
      value3 = val;
      _series = listSeriesDate
          .where(
            (s) =>
                s.dateFinEffective!.year == int.parse(value21) &&
                (int.parse(value3) == 0
                    ? true
                    : s.dateFinEffective!.month == int.parse(value3)),
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
        if (value1 == 'DATE VISIONNAGE') ...[
          SizedBox(height: 10),
          Center(
            child: MenuDeroulantData(
              value: value21,
              fctChange: fctChange2,
              listValues: listValues21,
              listAffichage: listValues21,
              largeurDeroulant: largeurDeroulant,
            ),
          ),
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
        if (value1 == 'DATE SORTIE') ...[
          SizedBox(height: 10),
          Center(
            child: MenuDeroulantData(
              value: value22,
              fctChange: fctChange2,
              listValues: listValues22,
              listAffichage: listValues22,
              largeurDeroulant: largeurDeroulant,
            ),
          ),
        ],
        SizedBox(height: 10),
        Expanded(child: AfficheTopSerie(listeSeries: _series)),
      ],
    );
  }
}
