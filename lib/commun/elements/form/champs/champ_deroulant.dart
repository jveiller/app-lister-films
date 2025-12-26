import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

class ChampDeroulant extends StatefulWidget {
  final String txt;
  final List<Object> liste;
  final bool addSuppr;
  final Object initFormController;
  final TextEditingController? addController;
  //String? supprController;
  final Function? addFonction;
  final Function? supprFonction;
  final bool txtFeminin;
  final bool necessaire;
  final Function changeGenre;
  const ChampDeroulant({
    super.key,
    required this.txt,
    required this.liste,
    required this.changeGenre,
    this.addSuppr = true,
    required this.initFormController,
    this.addController,
    //this.supprController,
    this.addFonction,
    this.txtFeminin = false,
    this.supprFonction,
    this.necessaire = false,
  }) : assert(
         addSuppr == false ||
             (addController != null &&
                 //supprController != null &&
                 addFonction != null &&
                 supprFonction != null),
         'Les attributs pour les forms permettants d\'ajouter ou supprimer des éléments sont requis',
       );

  @override
  State<ChampDeroulant> createState() => _ChampDeroulantState();
}

class _ChampDeroulantState extends State<ChampDeroulant> {
  final keyAdd = GlobalKey<FormState>();
  final keySuppr = GlobalKey<FormState>();
  late String formController;
  late String supprController;

  @override
  void initState() {
    super.initState();
    formController = widget.initFormController.toString();
    supprController = widget.liste.first.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: widget.txt, weight: FontWeight.bold),
        DropdownButtonFormField(
          items: [
            if (!widget.necessaire)
              DropdownMenuItem(
                value: '',
                child: ComposantTexte(texte: 'Je ne sais pas'),
              ),
            for (Object g in widget.liste)
              DropdownMenuItem(
                value: g.toString(),
                child: ComposantTexte(texte: g.toString()),
              ),
          ],
          value: formController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          onChanged: (value) {
            widget.changeGenre(value);
            setState(() {
              formController = value!;
              if (value != '') {
                widget.liste.remove(value);
                widget.liste.insert(0, value);
              }
            });
          },
        ),
        if (widget.addSuppr) ...[
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: ComposantTexte(
                        texte: 'Ajouter ${widget.txt.toLowerCase()}',
                      ),
                      content: Form(
                        key: keyAdd,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 18,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelText: widget.txtFeminin == false
                                  ? 'Nouveau ${widget.txt.toLowerCase()}'
                                  : 'Nouvelle ${widget.txt.toLowerCase()}',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: widget.txtFeminin == false
                                  ? 'Entrez le nouveau ${widget.txt.toLowerCase()}'
                                  : 'Entrez la nouvelle ${widget.txt.toLowerCase()}',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tu dois compléter ce texte';
                              }
                              return null;
                            },
                            controller: widget.addController,
                          ),
                        ),
                      ),
                      actions: [
                        BoutonAnnuler(),
                        TextButton(
                          onPressed: () async {
                            if (widget.addController!.text.isNotEmpty &&
                                keyAdd.currentState!.validate()) {
                              Object nouveauElt = widget.addController!.text;

                              await widget.addFonction!(nouveauElt);
                              widget.addController!.clear();
                              setState(() {
                                formController = nouveauElt.toString();
                              });
                              widget.changeGenre(nouveauElt.toString());
                              Navigator.pop(context);
                            }
                          },
                          child: ComposantTexte(texte: 'Valider'),
                        ),
                      ],
                    ),
                  );
                },
                child: ComposantTexte(texte: 'Ajouter', size: 14),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: ComposantTexte(
                        texte: 'Supprimer ${widget.txt.toLowerCase()}',
                      ),
                      content: Form(
                        key: keySuppr,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (widget.liste.length < 2) {
                                return widget.txtFeminin == false
                                    ? 'Tu dois garder un ${widget.txt.toLowerCase()} dans la liste'
                                    : 'Tu dois garder une ${widget.txt.toLowerCase()} dans la liste';
                              }
                              return null;
                            },
                            items: [
                              for (Object g in widget.liste)
                                DropdownMenuItem(
                                  value: g.toString(),
                                  child: ComposantTexte(texte: g.toString()),
                                ),
                            ],
                            value: supprController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(),
                              labelText: widget.txt,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                supprController = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      actions: [
                        BoutonAnnuler(),
                        TextButton(
                          onPressed: () async {
                            if (keySuppr.currentState!.validate()) {
                              await widget.supprFonction!(supprController);
                              setState(() {
                                supprController = widget.liste.first.toString();
                                if (!widget.liste.contains(formController)) {
                                  formController = widget.liste.first
                                      .toString();
                                  widget.changeGenre(
                                    widget.liste.first.toString(),
                                  );
                                }
                              });

                              Navigator.pop(
                                // ignore: use_build_context_synchronously
                                context,
                              );
                            }
                          },
                          child: ComposantTexte(texte: 'Valider'),
                        ),
                      ],
                    ),
                  );
                },
                child: ComposantTexte(
                  texte: 'Supprimer',
                  color: Colors.red[900],
                  size: 14,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
