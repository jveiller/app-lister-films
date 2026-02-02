import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

class ChampListe extends StatelessWidget {
  final String txt;
  final List<String> liste;
  final Function addListeFonction;
  final Function supprListeFonction;
  final String apresAjoutez;
  final textController = TextEditingController();
  final double largeurCarte;
  ChampListe({
    super.key,
    required this.txt,
    required this.liste,
    required this.addListeFonction,
    required this.supprListeFonction,
    required this.apresAjoutez,
    this.largeurCarte = 230,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: txt, weight: FontWeight.bold),
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: ComposantTexte(
                        texte: 'Ajoutez $apresAjoutez',
                        weight: FontWeight.bold,
                      ),
                      content: TextFormField(
                        cursorColor: Colors.black,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Entrez $apresAjoutez',
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        controller: textController,
                      ),
                      actions: [
                        BoutonAnnuler(),
                        TextButton(
                          onPressed: () {
                            addListeFonction(textController.text);
                            Navigator.pop(context);
                          },
                          child: ComposantTexte(texte: 'Ajouter'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: TailleAdaptateur.width(context, largeurCarte),
              child: Column(
                children: [
                  for (String l in liste) ...[
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: ComposantTexte(texte: l),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              supprListeFonction(l);
                            },
                            icon: Icon(Icons.cancel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
