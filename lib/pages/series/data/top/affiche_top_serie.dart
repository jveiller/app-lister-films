import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:flutter/material.dart';

class AfficheTopSerie extends StatelessWidget {
  final List<Serie> listeSeries;
  const AfficheTopSerie({super.key, required this.listeSeries});

  @override
  Widget build(BuildContext context) {
    if (listeSeries.isNotEmpty) {
      int j = 1;
      listeSeries.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
      return ListView(
        children: [
          for (int i = 0; i < listeSeries.length; i++)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: TailleAdaptateur.width(context, 60),
                    height: TailleAdaptateur.width(context, 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: serieOrange,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ComposantTexte(
                          texte: i == 0
                              ? '1'
                              : ((listeSeries[i].note ?? 0) !=
                                        (listeSeries[i - 1].note ?? 0)
                                    ? '${j = i + 1}'
                                    : '$j'),
                          color: Colors.white,
                          weight: FontWeight.bold,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: ComposantTexte(
                        texte: listeSeries[i].titre,
                        size: 20,
                        alignment: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 5),
                    width: TailleAdaptateur.width(context, 30),
                    child: ComposantTexte(
                      texte: listeSeries[i].note != null
                          ? listeSeries[i].note.toString().replaceAll(
                              RegExp(r'\.?0+$'),
                              '',
                            )
                          : '-',
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: TailleAdaptateur.font(context, 70)),
        child: ComposantTexte(
          texte: 'Pas de séries vues pour cette période',
          size: 18,
        ),
      );
    }
  }
}
