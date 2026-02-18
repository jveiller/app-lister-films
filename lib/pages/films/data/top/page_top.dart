import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/pages/films/data/top/affiche_top.dart';
import 'package:culture_app1/pages/films/data/menu_deroulant_data.dart';
import 'package:flutter/material.dart';

class PageTop extends StatefulWidget {
  final List<FilmsVu> listeFilmsVu;
  const PageTop({super.key, required this.listeFilmsVu});

  @override
  State<PageTop> createState() => _PageTopState();
}

class _PageTopState extends State<PageTop> {
  late List<FilmsVu> _filmsVu;
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
  late List<FilmsVu> listFilmsDate;
  late List<FilmsVu> listFilmsAnnee;

  @override
  void initState() {
    super.initState();
    _filmsVu = widget.listeFilmsVu;
    listFilmsDate = widget.listeFilmsVu.where((f) => f.date != null).toList();
    value21 = DateTime.now().year.toString();
    value22 = DateTime.now().year.toString();
    List<FilmsVu> listTri = listFilmsDate;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues21 = [listTri.first.date!.year.toString()];
      } else {
        listTri.sort((a, b) => b.date!.compareTo(a.date!));
        int anneeMin = listTri.last.date!.year;
        int anneeMax = listTri.first.date!.year;
        listValues21 = [];
        for (var i = anneeMax; i >= anneeMin; i--) {
          listValues21.add(i.toString());
        }
      }
    } else {
      listValues21 = [value21];
    }
    listFilmsAnnee = widget.listeFilmsVu.where((f) => f.annee != null).toList();
    listTri = listFilmsAnnee;
    if (listTri.isNotEmpty) {
      if (listTri.length == 1) {
        listValues22 = [listTri.first.annee!.toString()];
      } else {
        listTri.sort((a, b) => b.annee!.compareTo(a.annee!));
        listValues22 = [];
        for (FilmsVu f in listTri) {
          if (!listValues22.contains(f.annee.toString())) {
            listValues22.add(f.annee.toString());
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
        _filmsVu = widget.listeFilmsVu;
      } else if (value1 == 'DATE SORTIE') {
        _filmsVu = listFilmsAnnee
            .where((f) => f.annee == int.parse(value22))
            .toList();
      } else if (value1 == 'DATE VISIONNAGE') {
        _filmsVu = listFilmsDate
            .where(
              (f) =>
                  f.date!.year == int.parse(value21) && int.parse(value3) == 0
                  ? true
                  : f.date!.month == int.parse(value3),
            )
            .toList();
      }
    });
  }

  void fctChange2(String val) {
    setState(() {
      if (value1 == 'DATE SORTIE') {
        value22 = val;
        _filmsVu = listFilmsAnnee
            .where((f) => f.annee! == int.parse(value22))
            .toList();
      } else if (value1 == 'DATE VISIONNAGE') {
        value21 = val;
        _filmsVu = listFilmsDate
            .where(
              (f) =>
                  f.date!.year == int.parse(value21) &&
                  (int.parse(value3) == 0
                      ? true
                      : f.date!.month == int.parse(value3)),
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
                f.date!.year == int.parse(value21) &&
                (int.parse(value3) == 0
                    ? true
                    : f.date!.month == int.parse(value3)),
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
        Expanded(child: AfficheTop(listeFilms: _filmsVu)),
      ],
    );
  }
}
