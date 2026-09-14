import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/database/db_film_voir.dart';
import 'package:culture_app1/commun/database/db_film_vu.dart';
import 'package:culture_app1/commun/elements/selecteur.dart';
import 'package:culture_app1/pages/films/data/data_film.dart';
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
  List<FilmsVu> _filmsVu = [];
  List<FilmsVoir> _filmsVoir = [];

  void _fetchFilmVu() async {
    // Actualise l'état de la BdD dans l'application
    final data =
        await DbFilmsVu.getList(); //  Donne à data les éléments de la BdD
    setState(() {
      // Mise à jour de l'état
      _filmsVu = List.from(
        data.reversed,
      ); // La variable activités prend les valeurs de data
    });
  }

  void _fetchFilmVoir() async {
    // Actualise l'état de la BdD dans l'application
    final data = await DbFilmsVoir.getList();
    setState(() {
      _filmsVoir = List.from(data.reversed);
    });
  }

  @override //à mettre avant les méthodes utilisant des instances
  void initState() {
    //Donne les valeurs initiales de la BdD à activites
    super.initState();
    _fetchFilmVu();
    _fetchFilmVoir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(
          texteBar: 'FILMS',
          couleur: filmJaune,
          bouton: true,
          pageBouton: DataFilm(
            listeFilmsVu: _filmsVu,
            listeFilmsVoir: _filmsVoir,
          ),
        ),
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
            Expanded(
              child: FilmsVuPage(actualiseBDD: _fetchFilmVu, listeFV: _filmsVu),
            ),
          ] else ...[
            Expanded(
              child: FilmsVoirPage(
                actualiseBDD: _fetchFilmVoir,
                listeFV: _filmsVoir,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
