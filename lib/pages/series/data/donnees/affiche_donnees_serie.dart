import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/pages/films/data/donnees/classement_pop_up.dart';
import 'package:culture_app1/pages/films/data/donnees/rond_data.dart';
import 'package:flutter/material.dart';

class AfficheDonneesSerie extends StatelessWidget {
  // Séries vues (filtrées par la période choisie) : notes, avec qui, genre,
  // créateur·rice et données manquantes sont calculés dessus.
  final List<Serie> listeSeriesVues;
  // Séries vues + en cours (uniquement en vue GLOBALE) : temps total regardé.
  final List<Serie> listeSeriesTemps;
  // Séries à voir, non filtrées par période : recommandations.
  final List<Serie> listeSeriesAVoir;
  const AfficheDonneesSerie({
    super.key,
    required this.listeSeriesVues,
    required this.listeSeriesTemps,
    required this.listeSeriesAVoir,
  });

  int dureeTotaleMinutes(List<Serie> series) {
    int total = 0;
    for (var serie in series) {
      final duree = serie.dureeVisionneeMinutes;
      if (duree != null) total += duree;
    }
    return total;
  }

  Map<String, int> compteOccurrences<T>(
    List<T> series,
    List<String>? Function(T) getter,
  ) {
    Map<String, int> comptes = {};
    for (var serie in series) {
      final valeurs = getter(serie);
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
    final compteAvecQui = compteOccurrences(listeSeriesVues, (s) => s.avecQui);
    final topAvecQui = topOccurrences(compteAvecQui);
    final compteGenres = compteOccurrences(listeSeriesVues, (s) => s.genre);
    final topGenres = topOccurrences(compteGenres);
    final compteCreateurs = compteOccurrences(
      listeSeriesVues,
      (s) => s.createur == null || s.createur == '' ? null : [s.createur!],
    );
    final topCreateurs = topOccurrences(compteCreateurs);
    final compteRecommandations = compteOccurrences(
      listeSeriesAVoir,
      (s) => s.recommandePar,
    );
    final topRecommandations = topOccurrences(compteRecommandations);
    final dureeTotale = dureeTotaleMinutes(listeSeriesTemps);
    final seriesAvecDuree = listeSeriesTemps
        .where((s) => s.dureeVisionneeMinutes != null)
        .toList();
    final seriesAvecNote = listeSeriesVues.where((s) => s.note != null).toList();
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RondData(data: '${listeSeriesVues.length}', couleur: serieOrange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: TailleAdaptateur.width(context, 140),
                  child: ComposantTexte(texte: 'Séries vues', size: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (seriesAvecDuree.isNotEmpty) ...[
                  RondData(
                    couleur: serieOrange,
                    data: (dureeTotale / 60).floor() < 10 && (dureeTotale % 60) != 0
                        ? '${(dureeTotale / 60).floor()}h${dureeTotale % 60}'
                        : '${(dureeTotale / 60).floor()}',
                  ),
                ],
                if (seriesAvecNote.isNotEmpty) ...[
                  RondData(
                    couleur: serieOrange,
                    data:
                        (seriesAvecNote.map((s) => s.note!).reduce((a, b) => a + b) /
                                seriesAvecNote.length)
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
                if (seriesAvecDuree.isNotEmpty) ...[
                  SizedBox(
                    width: TailleAdaptateur.width(context, 140),
                    child: ComposantTexte(
                      texte: 'Heures totale regardées',
                      size: 20,
                    ),
                  ),
                ],
                if (seriesAvecNote.isNotEmpty) ...[
                  SizedBox(
                    width: TailleAdaptateur.width(context, 140),
                    child: ComposantTexte(texte: 'Note moyenne', size: 20),
                  ),
                ],
              ],
            ),
            if (compteAvecQui.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topAvecQui.length > 1 ? 'Vu le plus de séries avec (ex æquo)' : 'Vu le plus de séries avec'} : ${topAvecQui.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Séries vues par personne',
                          compte: compteAvecQui,
                          couleur: serieOrange,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
            if (compteGenres.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topGenres.length > 1 ? 'Genre le plus regardé (ex æquo)' : 'Genre le plus regardé'} : ${topGenres.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Séries vues par genre',
                          compte: compteGenres,
                          couleur: serieOrange,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
            if (compteCreateurs.isNotEmpty) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ComposantTexte(
                      texte:
                          '${topCreateurs.length > 1 ? 'Créateur·rice le plus vu (ex æquo)' : 'Créateur·rice le plus vu'} : ${topCreateurs.join(', ')}',
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ClassementPopUp(
                          titre: 'Séries vues par créateur·rice',
                          compte: compteCreateurs,
                          couleur: serieOrange,
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
                          titre: 'Séries à voir recommandées par',
                          compte: compteRecommandations,
                          couleur: serieOrange,
                        ),
                      );
                    },
                    icon: Icon(Icons.leaderboard),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20),
            if (listeSeriesVues.where((s) => s.dateFinEffective == null).isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de séries sans date de fin : ${listeSeriesVues.where((s) => s.dateFinEffective == null).length}',
                    alignment: TextAlign.start,
                    size: 18,
                  ),
                ),
              ),
            ],
            if (listeSeriesVues
                .where((s) => s.dureeVisionneeMinutes == null)
                .isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de séries sans durée : ${listeSeriesVues.where((s) => s.dureeVisionneeMinutes == null).length}',
                    alignment: TextAlign.start,
                    size: 18,
                  ),
                ),
              ),
            ],
            if (listeSeriesVues.where((s) => s.note == null).isNotEmpty) ...[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ComposantTexte(
                    texte:
                        'Nombre de séries sans note : ${listeSeriesVues.where((s) => s.note == null).length}',
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
