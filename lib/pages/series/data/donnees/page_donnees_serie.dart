import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/pages/films/data/menu_deroulant_data.dart';
import 'package:culture_app1/pages/series/data/donnees/affiche_donnees_serie.dart';
import 'package:flutter/material.dart';

class PageDonneesSerie extends StatefulWidget {
  final List<Serie> listeSeries;
  const PageDonneesSerie({super.key, required this.listeSeries});

  @override
  State<PageDonneesSerie> createState() => _PageDonneesSerieState();
}

class _PageDonneesSerieState extends State<PageDonneesSerie> {
  late List<Serie> _seriesVues;
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
  late List<Serie> listSeriesVuesDate;
  late List<Serie> seriesEnCours;
  late List<Serie> seriesAVoir;

  @override
  void initState() {
    super.initState();
    final toutesVues = widget.listeSeries
        .where((s) => s.statut == 'vu')
        .toList();
    _seriesVues = toutesVues;
    listSeriesVuesDate = toutesVues.where((s) => s.dateFinEffective != null).toList();
    seriesEnCours = widget.listeSeries
        .where((s) => s.statut == 'en_cours')
        .toList();
    seriesAVoir = widget.listeSeries
        .where((s) => s.statut == 'a_voir')
        .toList();
    value2 = DateTime.now().year.toString();
    value3 = (DateTime.now().month).toString();
    List<Serie> listTri = listSeriesVuesDate;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues2 = [listTri.first.dateFinEffective!.year.toString()];
      } else {
        listTri.sort((a, b) => b.dateFinEffective!.compareTo(a.dateFinEffective!));
        int anneeMin = listTri.last.dateFinEffective!.year;
        int anneeMax = listTri.first.dateFinEffective!.year;
        listValues2 = [];
        for (var i = anneeMax; i >= anneeMin; i--) {
          listValues2.add(i.toString());
        }
      }
    } else {
      listValues2 = [value2];
    }
  }

  void fctChange1(String val) {
    setState(() {
      value1 = val;
      if (value1 == 'GLOBAL') {
        _seriesVues = widget.listeSeries.where((s) => s.statut == 'vu').toList();
      } else if (value1 == 'ANNÉE') {
        _seriesVues = listSeriesVuesDate
            .where((s) => s.dateFinEffective!.year == int.parse(value2))
            .toList();
      } else if (value1 == 'MOIS') {
        _seriesVues = listSeriesVuesDate
            .where(
              (s) =>
                  s.dateFinEffective!.year == int.parse(value2) &&
                  s.dateFinEffective!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange2(String val) {
    setState(() {
      value2 = val;
      if (value1 == 'ANNÉE') {
        _seriesVues = listSeriesVuesDate
            .where((s) => s.dateFinEffective!.year == int.parse(value2))
            .toList();
      } else if (value1 == 'MOIS') {
        _seriesVues = listSeriesVuesDate
            .where(
              (s) =>
                  s.dateFinEffective!.year == int.parse(value2) &&
                  s.dateFinEffective!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange3(String val) {
    setState(() {
      value3 = val;
      _seriesVues = listSeriesVuesDate
          .where(
            (s) =>
                s.dateFinEffective!.year == int.parse(value2) &&
                s.dateFinEffective!.month == int.parse(value3),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Les séries en cours n'ont pas de date de fin : elles ne peuvent
    // compter dans le temps regardé que hors filtre par période.
    final seriesTemps = value1 == 'GLOBAL'
        ? [..._seriesVues, ...seriesEnCours]
        : _seriesVues;
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
        Expanded(
          child: AfficheDonneesSerie(
            listeSeriesVues: _seriesVues,
            listeSeriesTemps: seriesTemps,
            listeSeriesAVoir: seriesAVoir,
          ),
        ),
      ],
    );
  }
}
