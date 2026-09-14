import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/data/donnees/classement_pop_up.dart';
import 'package:culture_app1/pages/films/data/donnees/rond_data.dart';
import 'package:flutter/material.dart';

class AfficheDonnees extends StatelessWidget {
  final List<FilmsVu> listeFilms;
  final List<FilmsVoir> listeFilmsVoir;
  const AfficheDonnees({
    super.key,
    required this.listeFilms,
    required this.listeFilmsVoir,
  });

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

  Map<String, int> compteOccurrences<T>(
    List<T> films,
    List<String>? Function(T) getter,
  ) {
    Map<String, int> comptes = {};
    for (var film in films) {
      final valeurs = getter(film);
      if (valeurs != null) {
        for (var v in valeurs) {
          comptes[v] = (comptes[v] ?? 0) + 1;
        }
      }
    }
    return comptes;
  }

  List<String> topOccurrences(Map<String, int> comptes) {
    if (comptes.isEmpty) return [];
    int max = comptes.values.reduce((a, b) => a > b ? a : b);
    return comptes.entries
        .where((e) => e.value == max)
        .map((e) => e.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final comptePersonnes = compteOccurrences(listeFilms, (f) => f.personnes);
    final topPersonnes = topOccurrences(comptePersonnes);
    final compteCinemas = compteOccurrences(listeFilms, (f) => f.cinemas);
    final topCinemas = topOccurrences(compteCinemas);
    final compteRecommandations = compteOccurrences(
      listeFilmsVoir,
      (f) => f.recommandation,
    );
    final topRecommandations = topOccurrences(compteRecommandations);
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
            if (comptePersonnes.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topPersonnes.length > 1 ? 'Vu le plus de films avec (ex æquo)' : 'Vu le plus de films avec'} : ${topPersonnes.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Films vus par personne',
                          compte: comptePersonnes,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
            if (compteCinemas.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topCinemas.length > 1 ? 'Cinéma où tu vas le plus (ex æquo)' : 'Cinéma où tu vas le plus'} : ${topCinemas.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Films vus par cinéma',
                          compte: compteCinemas,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
            if (compteRecommandations.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topRecommandations.length > 1 ? 'Recommandé le plus par (ex æquo)' : 'Recommandé le plus par'} : ${topRecommandations.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Films à voir recommandés par',
                          compte: compteRecommandations,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
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
