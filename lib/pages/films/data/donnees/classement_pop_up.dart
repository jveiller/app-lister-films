import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

class ClassementPopUp extends StatelessWidget {
  final String titre;
  final Map<String, int> compte;
  final Color couleur;
  const ClassementPopUp({
    super.key,
    required this.titre,
    required this.compte,
    this.couleur = filmJaune,
  });

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, int>> classement = compte.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    int rang = 1;
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.all(10),
      actionsPadding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
      backgroundColor: Colors.white,
      title: ComposantTexte(texte: titre, weight: FontWeight.bold, size: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < classement.length; i++)
            Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: TailleAdaptateur.width(context, 45),
                    height: TailleAdaptateur.width(context, 45),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: couleur,
                    ),
                    child: Center(
                      child: ComposantTexte(
                        texte: i == 0
                            ? '1'
                            : (classement[i].value != classement[i - 1].value
                                  ? '${rang = i + 1}'
                                  : '$rang'),
                        color: Colors.white,
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: ComposantTexte(
                        texte: classement[i].key,
                        alignment: TextAlign.start,
                        size: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ComposantTexte(
                      texte: '${classement[i].value}',
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [BoutonAnnuler(txt: 'Fermer')],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
