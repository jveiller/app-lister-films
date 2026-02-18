import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:flutter/material.dart';

class AfficheTop extends StatelessWidget {
  final List<FilmsVu> listeFilms;
  const AfficheTop({super.key, required this.listeFilms});

  @override
  Widget build(BuildContext context) {
    int j = 1;
    listeFilms.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
    return ListView(
      children: [
        for (int i = 0; i < listeFilms.length; i++)
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
                    color: filmJaune,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ComposantTexte(
                        texte: i == 0
                            ? '1'
                            : ((listeFilms[i].note ?? 0) !=
                                      (listeFilms[i - 1].note ?? 0)
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
                      texte: listeFilms[i].titre,
                      size: 20,
                      alignment: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 5),
                  width: TailleAdaptateur.width(context, 30),
                  child: ComposantTexte(
                    texte: listeFilms[i].note != null
                        ? listeFilms[i].note.toString().replaceAll(
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
  }
}
