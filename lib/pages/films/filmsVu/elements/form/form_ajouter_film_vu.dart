import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_date.dart';
//import 'package:culture_app1/commun/elements/form/champs/champ_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_duree.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormAjouterFilmVu extends StatefulWidget {
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function setFilmState;
  final Function addFilmFonction;
  final List<String> listePlateformes;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  const FormAjouterFilmVu({
    super.key,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.setFilmState,
    required this.addFilmFonction,
    required this.listePlateformes,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
  });

  @override
  State<FormAjouterFilmVu> createState() => _FormAjouterFilmVuState();
}

class _FormAjouterFilmVuState extends State<FormAjouterFilmVu> {
  final titreController = TextEditingController();
  //String genreController = '';
  List<String> genres = [];
  List<String> plateformes = [];
  final heureController = TextEditingController();
  final minuteController = TextEditingController();
  final noteController = TextEditingController();
  //final plateformeController = TextEditingController();
  final anneeController = TextEditingController();
  final descriptionController = TextEditingController();
  final realisateurController = TextEditingController();
  bool? cinemaController;
  bool ouiIsCheck = false;
  bool nonIsCheck = false;
  final contexteController = TextEditingController();
  DateTime? dateController;
  final keyForm = GlobalKey<FormState>();
  //final addGenreController = TextEditingController();
  final List<String> listeActeurs = [];
  final List<String> listeCitations = [];
  //late String supprGenreController;

  /*void changeGenre(String g) {
    setState(() {
      genreController = g;
    });
  }*/

  void addGenre(String g) {
    if (!genres.contains(g)) {
      setState(() {
        genres.add(g);
      });
    }
  }

  void supprGenre(String g) {
    setState(() {
      genres.remove(g);
    });
  }

  void addActeur(String a) {
    if (!listeActeurs.contains(a)) {
      setState(() {
        listeActeurs.add(a);
      });
    }
  }

  void supprActeur(String a) {
    setState(() {
      listeActeurs.remove(a);
    });
  }

  void addCitation(String c) {
    if (!listeCitations.contains(c)) {
      setState(() {
        listeCitations.add(c);
      });
    }
  }

  void supprCitation(String c) {
    setState(() {
      listeCitations.remove(c);
    });
  }

  void addPlateforme(String p) {
    if (!plateformes.contains(p)) {
      setState(() {
        plateformes.add(p);
      });
    }
  }

  void supprPlateforme(String p) {
    setState(() {
      plateformes.remove(p);
    });
  }

  void changeDate(DateTime? value) {
    setState(() {
      dateController = value;
    });
  }

  void checkOui(val) {
    setState(() {
      ouiIsCheck = val;
      if (nonIsCheck && ouiIsCheck) {
        nonIsCheck = false;
        cinemaController = true;
      } else if (!nonIsCheck && !ouiIsCheck) {
        cinemaController = null;
      } else {
        cinemaController = true;
      }
    });
  }

  void checkNon(val) {
    setState(() {
      nonIsCheck = val;
      if (nonIsCheck && ouiIsCheck) {
        ouiIsCheck = false;
        cinemaController = false;
      } else if (!nonIsCheck && !ouiIsCheck) {
        cinemaController = null;
      } else {
        cinemaController = false;
      }
    });
  }

  /*@override
  void initState() {
    super.initState();
    //supprGenreController = widget.listeGenres.first;
  }*/

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          title: EnteteForm(couleur: filmJaune, txt: 'Ajouter film'),
          content: Form(
            key: keyForm,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Titre',
                      champController: titreController,
                      necessaire: true,
                    ),
                  ),
                  /*Container(
                    margin: EdgeInsets.all(5),
                    child: ChampDeroulant(
                      txt: 'Genre',
                      initFormController: genreController,
                      liste: widget.listeGenres,
                      changeGenre: changeGenre,
                      addController: addGenreController,
                      addFonction: widget.addGenreFonction,
                      supprFonction: widget.supprGenreFonction,
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListeDeroulant(
                      txt: 'Genre·s',
                      //initFormController: genreController,
                      liste: genres,
                      listeDeroulant: widget.listeGenres,
                      //changeGenre: changeGenre,
                      //addController: addGenreController,
                      addDeroulantFonction: widget.addGenreFonction,
                      supprDeroulantFonction: widget.supprGenreFonction,
                      addListeFonction: addGenre,
                      supprListeFonction: supprGenre,
                      apresAjoutez: 'un genre',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampDuree(
                      txt: 'Durée',
                      champHeureController: heureController,
                      champMinuteController: minuteController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampNote(
                      txt: 'Note',
                      champController: noteController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampDate(
                      txt: 'Date de visionnage',
                      changeDate: changeDate,
                      date: dateController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListe(
                      txt: 'Acteurs/Actrices',
                      liste: listeActeurs,
                      addListeFonction: addActeur,
                      supprListeFonction: supprActeur,
                      apresAjoutez: 'un·e acteur·ice',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Réalisateur/Réalisatrice',
                      champController: realisateurController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListe(
                      txt: 'Citations',
                      liste: listeCitations,
                      addListeFonction: addCitation,
                      supprListeFonction: supprCitation,
                      apresAjoutez: 'une citation',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ComposantTexte(
                          texte: 'Vu au cinéma',
                          weight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                ComposantTexte(texte: 'Oui'),
                                Checkbox(
                                  value: ouiIsCheck,
                                  onChanged: checkOui,
                                  checkColor: Colors.white,
                                  activeColor: filmJaune,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ComposantTexte(texte: 'Non'),
                                Checkbox(
                                  value: nonIsCheck,
                                  onChanged: checkNon,
                                  checkColor: Colors.white,
                                  activeColor: filmJaune,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Contexte de visionnage',
                      champController: contexteController,
                      plusieursLignes: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampNombre(
                      txt: 'Année de sortie',
                      champController: anneeController,
                      largeur: 100,
                      nbMaxNombres: 4,
                    ),
                  ),
                  /*Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Plateforme',
                      champController: plateformeController,
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListeDeroulant(
                      txt: 'Plateforme·s',
                      //initFormController: genreController,
                      liste: plateformes,
                      listeDeroulant: widget.listePlateformes,
                      //changeGenre: changeGenre,
                      //addController: addGenreController,
                      addDeroulantFonction: widget.addPlateformeFonction,
                      supprDeroulantFonction: widget.supprPlateformeFonction,
                      addListeFonction: addPlateforme,
                      supprListeFonction: supprPlateforme,
                      apresAjoutez: 'une plateforme',
                      txtFeminin: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Description',
                      champController: descriptionController,
                      plusieursLignes: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15),
                ),
                elevation: WidgetStateProperty.all(0.0),
                backgroundColor: WidgetStateProperty.all(filmJaune),
                fixedSize: WidgetStateProperty.all(
                  Size.fromWidth(TailleAdaptateur.width(context, 150)),
                ),
              ),
              onPressed: () {
                if (keyForm.currentState!.validate() &&
                    titreController.text.isNotEmpty) {
                  widget.setFilmState(() {
                    widget.addFilmFonction(
                      titre: titreController.text,
                      genre: genres.isEmpty ? null : genres,
                      duree:
                          (heureController.text != '') ||
                              (minuteController.text != '')
                          ? (int.tryParse(heureController.text) ?? 0) * 60 +
                                (int.tryParse(minuteController.text) ?? 0)
                          : null,
                      annee: int.tryParse(anneeController.text),
                      plateforme: plateformes.isEmpty ? null : plateformes,
                      description: descriptionController.text == ''
                          ? null
                          : descriptionController.text,
                      note: double.tryParse(noteController.text),
                      acteurs: listeActeurs.isEmpty ? null : listeActeurs,
                      citations: listeCitations.isEmpty ? null : listeCitations,
                      realisateur: realisateurController.text == ''
                          ? null
                          : realisateurController.text,
                      cinema: cinemaController,
                      date: dateController,
                      contexte: contexteController.text == ''
                          ? null
                          : contexteController.text,
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: ComposantTexte(
                texte: 'Ajouter',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 20,
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
