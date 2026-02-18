import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/data/donnees/rond_data.dart';
import 'package:flutter/material.dart';

class AfficheDonnees extends StatelessWidget {
  final List<FilmsVu> listeFilms;
  const AfficheDonnees({super.key, required this.listeFilms});

  int dureeTotale(List<FilmsVu> films) {
    int total = 0;
    for (var film in films) {
      if (film.duree != null) {
        total += film.duree!;
      }
    }
    return total;
  }

  List<String> meilleursFilms(List<FilmsVu> films) {
    List<FilmsVu> sansNull = films.where((f) => f.note != null).toList();
    var fnote = sansNull.reduce((a, b) => a.note! > b.note! ? a : b);
    var listeFinale = sansNull.where((f) => f.note! == fnote.note!);
    List<String> result = [];
    for (FilmsVu f in listeFinale) {
      result.add(f.titre);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RondData(data: '${listeFilms.length}'),
                if (listeFilms.where((f) => f.cinema != null).isNotEmpty) ...[
                  RondData(
                    data:
                        '${listeFilms.where((f) => f.cinema != null && f.cinema!).length}',
                  ),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: TailleAdaptateur.width(context, 140),
                  child: ComposantTexte(texte: 'Films vus', size: 20),
                ),
                if (listeFilms.where((f) => f.cinema != null).isNotEmpty) ...[
                  SizedBox(
                    width: TailleAdaptateur.width(context, 140),
                    child: ComposantTexte(
                      texte: 'Films vus au cinéma',
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (listeFilms.where((f) => f.duree != null).isNotEmpty) ...[
                  RondData(
                    data:
                        (dureeTotale(listeFilms) / 60).floor() < 10 &&
                            (dureeTotale(listeFilms) % 60) != 0
                        ? '${(dureeTotale(listeFilms) / 60).floor()}h${dureeTotale(listeFilms) % 60}'
                        : '${(dureeTotale(listeFilms) / 60).floor()}',
                  ),
                ],
                if (listeFilms.where((f) => f.note != null).isNotEmpty) ...[
                  RondData(
                    data:
                        (listeFilms
                                    .where((f) => f.note != null)
                                    .map((f) => f.note!)
                                    .reduce((a, b) => a + b) /
                                listeFilms.where((f) => f.note != null).length)
                            .toStringAsFixed(2)
                            .replaceAll(RegExp(r'\.?0+$'), ''),
                  ),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listeFilms.where((f) => f.duree != null).isNotEmpty) ...[
                  SizedBox(
                    width: TailleAdaptateur.width(context, 140),
                    child: ComposantTexte(
                      texte: 'Heures totale regardées',
                      size: 20,
                    ),
                  ),
                ],
                if (listeFilms.where((f) => f.note != null).isNotEmpty) ...[
                  SizedBox(
                    width: TailleAdaptateur.width(context, 140),
                    child: ComposantTexte(texte: 'Note moyenne', size: 20),
                  ),
                ],
              ],
            ),
            SizedBox(height: 20),
            if (listeFilms.where((f) => f.date == null).isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de films sans date : ${listeFilms.where((f) => f.date == null).length}',
                    alignment: TextAlign.start,
                    size: 18,
                  ),
                ),
              ),
            ],
            if (listeFilms.where((f) => f.duree == null).isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de films sans durée : ${listeFilms.where((f) => f.duree == null).length}',
                    alignment: TextAlign.start,
                    size: 18,
                  ),
                ),
              ),
            ],
            if (listeFilms.where((f) => f.note == null).isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de films sans note : ${listeFilms.where((f) => f.note == null).length}',
                    alignment: TextAlign.center,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
