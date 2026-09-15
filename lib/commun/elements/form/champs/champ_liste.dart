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
  final focusNode = FocusNode();
  final double largeurCarte;
  final Future<List<String>> Function()? suggestionsFonction;
  ChampListe({
    super.key,
    required this.txt,
    required this.liste,
    required this.addListeFonction,
    required this.supprListeFonction,
    required this.apresAjoutez,
    this.largeurCarte = 230,
    this.suggestionsFonction,
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
                      content: suggestionsFonction == null
                          ? TextFormField(
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
                            )
                          : FutureBuilder<List<String>>(
                              future: suggestionsFonction!(),
                              builder: (context, snapshot) {
                                final suggestions = snapshot.data ?? [];
                                return RawAutocomplete<String>(
                                  textEditingController: textController,
                                  focusNode: focusNode,
                                  onSelected: (String selection) {
                                    textController.text = selection;
                                  },
                                  optionsBuilder: (TextEditingValue value) {
                                    if (value.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    }
                                    return suggestions.where(
                                      (s) => s.toLowerCase().contains(
                                        value.text.toLowerCase(),
                                      ),
                                    );
                                  },
                                  fieldViewBuilder:
                                      (
                                        context,
                                        controller,
                                        focusNode,
                                        onFieldSubmitted,
                                      ) {
                                        return TextFormField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          cursorColor: Colors.black,
                                          textCapitalization:
                                              TextCapitalization.sentences,
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
                                        );
                                      },
                                  optionsViewBuilder:
                                      (context, onSelected, options) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            elevation: 4,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: 200,
                                                maxWidth: 260,
                                              ),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                children: [
                                                  for (String option
                                                      in options)
                                                    ListTile(
                                                      title: ComposantTexte(
                                                        texte: option,
                                                      ),
                                                      onTap: () =>
                                                          onSelected(option),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                );
                              },
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
