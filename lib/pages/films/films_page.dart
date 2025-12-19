import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/selecteur.dart';
import 'package:culture_app1/pages/films/filmsVoir/films_voir_page.dart';
import 'package:culture_app1/pages/films/filmsVu/films_vu_page.dart';
import 'package:flutter/material.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({super.key});

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(texteBar: 'FILMS', couleur: filmJaune),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Selecteur(
            vu: vu,
            txtVoir: 'À VOIR',
            txtVu: 'VU',
            couleurOff: Color.fromARGB(255, 185, 175, 149),
            couleurOn: filmJaune,
            onTap1: () {
              setState(() {
                vu = false;
              });
            },
            onTap2: () {
              setState(() {
                vu = true;
              });
            },
          ),
          if (vu) ...[
            Expanded(child: FilmsVuPage()),
          ] else ...[
            Expanded(child: FilmsVoirPage()),
          ],
        ],
      ),
    );
  }
}
