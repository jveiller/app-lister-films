import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

class ChampListeDeroulant extends StatefulWidget {
  final String txt;
  final List<Object> listeDeroulant;
  final bool addSuppr;
  //final Object initFormController;
  //final TextEditingController? addController;
  final Function? addDeroulantFonction;
  final Function? supprDeroulantFonction;
  final bool txtFeminin;
  //final bool necessaire;
  //final Function changeGenre;
  final List<String> liste;
  final Function addListeFonction;
  final Function supprListeFonction;
  final String apresAjoutez;
  final double largeurCarte;
  const ChampListeDeroulant({
    super.key,
    required this.txt,
    required this.listeDeroulant,
    //required this.changeGenre,
    this.addSuppr = true,
    //required this.initFormController,
    //this.addController,
    required this.addDeroulantFonction,
    this.txtFeminin = false,
    required this.supprDeroulantFonction,
    //this.necessaire = false,
    required this.liste,
    required this.addListeFonction,
    required this.supprListeFonction,
    required this.apresAjoutez,
    this.largeurCarte = 230,
  }) : assert(
         addSuppr == false ||
             ( //addController != null &&
             addDeroulantFonction != null && supprDeroulantFonction != null),
         'Les attributs pour les forms permettants d\'ajouter ou supprimer des éléments sont requis',
       );

  @override
  State<ChampListeDeroulant> createState() => _ChampListeDeroulantState();
}

class _ChampListeDeroulantState extends State<ChampListeDeroulant> {
  final keyAdd = GlobalKey<FormState>();
  final keySuppr = GlobalKey<FormState>();
  late String formController;
  late String supprController;
  final addController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //formController = widget.initFormController.toString();
    formController = widget.listeDeroulant.first.toString();
    supprController = widget.listeDeroulant.first.toString();
    /*if (widget.listeDeroulant.contains(widget.initFormController.toString())) {
      widget.listeDeroulant.remove(widget.initFormController.toString());
      widget.listeDeroulant.insert(0, widget.initFormController.toString());
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: widget.txt, weight: FontWeight.bold),
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setStateDialog) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: ComposantTexte(
                            texte: 'Ajoutez ${widget.apresAjoutez}',
                            weight: FontWeight.bold,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButtonFormField(
                                items: [
                                  /*if (!widget.necessaire)
                                  DropdownMenuItem(
                                    value: '',
                                    child: ComposantTexte(
                                      texte: 'Je ne sais pas',
                                    ),
                                  ),*/
                                  for (Object g in widget.listeDeroulant)
                                    DropdownMenuItem(
                                      value: g.toString(),
                                      child: ComposantTexte(
                                        texte: g.toString(),
                                      ),
                                    ),
                                ],
                                value: formController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  //widget.changeGenre(value);
                                  setStateDialog(() {
                                    formController = value!;
                                    /*if (value != '') {
                                    widget.listeDeroulant.remove(value);
                                    widget.listeDeroulant.insert(0, value);
                                  }*/
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
                                              texte:
                                                  'Ajouter ${widget.txt.toLowerCase()}',
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
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  maxLength: 18,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 2,
                                                              ),
                                                        ),
                                                    labelText:
                                                        widget.txtFeminin ==
                                                            false
                                                        ? 'Nouveau ${widget.txt.toLowerCase()}'
                                                        : 'Nouvelle ${widget.txt.toLowerCase()}',
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    hintText:
                                                        widget.txtFeminin ==
                                                            false
                                                        ? 'Entrez le nouveau ${widget.txt.toLowerCase()}'
                                                        : 'Entrez la nouvelle ${widget.txt.toLowerCase()}',
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Tu dois compléter ce texte';
                                                    }
                                                    return null;
                                                  },
                                                  //controller: widget.addController,
                                                  controller: addController,
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              BoutonAnnuler(),
                                              TextButton(
                                                onPressed: () async {
                                                  if ( //widget.
                                                  addController
                                                          .text
                                                          .isNotEmpty &&
                                                      keyAdd.currentState!
                                                          .validate()) {
                                                    Object nouveauElt =
                                                        //widget.addController!.text;
                                                        addController.text;

                                                    await widget
                                                        .addDeroulantFonction!(
                                                      nouveauElt,
                                                    );
                                                    //widget.addController!.clear();
                                                    addController.clear();
                                                    setStateDialog(() {
                                                      formController =
                                                          nouveauElt.toString();
                                                    });
                                                    /*widget.changeGenre(
                                                    nouveauElt.toString(),
                                                  );*/
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: ComposantTexte(
                                                  texte: 'Valider',
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: ComposantTexte(
                                        texte: 'Ajouter ${widget.apresAjoutez}',
                                        size: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: ComposantTexte(
                                              texte:
                                                  'Supprimer ${widget.txt.toLowerCase()}',
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
                                                    if (widget
                                                            .listeDeroulant
                                                            .length <
                                                        2) {
                                                      return widget
                                                                  .txtFeminin ==
                                                              false
                                                          ? 'Tu dois garder un ${widget.txt.toLowerCase()} dans la liste'
                                                          : 'Tu dois garder une ${widget.txt.toLowerCase()} dans la liste';
                                                    }
                                                    return null;
                                                  },
                                                  items: [
                                                    for (Object g
                                                        in widget
                                                            .listeDeroulant)
                                                      DropdownMenuItem(
                                                        value: g.toString(),
                                                        child: ComposantTexte(
                                                          texte: g.toString(),
                                                        ),
                                                      ),
                                                  ],
                                                  value: supprController,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 2,
                                                              ),
                                                        ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: widget.txt,
                                                    labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setStateDialog(() {
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
                                                  if (keySuppr.currentState!
                                                      .validate()) {
                                                    await widget
                                                        .supprDeroulantFonction!(
                                                      supprController,
                                                    );
                                                    setStateDialog(() {
                                                      supprController = widget
                                                          .listeDeroulant
                                                          .first
                                                          .toString();
                                                      if (!widget.listeDeroulant
                                                          .contains(
                                                            formController,
                                                          )) {
                                                        formController = widget
                                                            .listeDeroulant
                                                            .first
                                                            .toString();
                                                        /*widget.changeGenre(
                                                        widget
                                                            .listeDeroulant
                                                            .first
                                                            .toString(),
                                                      );*/
                                                      }
                                                    });

                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: ComposantTexte(
                                                  texte: 'Valider',
                                                ),
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
                          ),
                          actions: [
                            BoutonAnnuler(),
                            TextButton(
                              onPressed: () {
                                widget.addListeFonction(formController);
                                Navigator.pop(context);
                              },
                              child: ComposantTexte(texte: 'Ajouter'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: widget.largeurCarte,
              child: Column(
                children: [
                  for (String l in widget.liste) ...[
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
                              widget.supprListeFonction(l);
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
