import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_duree.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormModifFilmVoir extends StatefulWidget {
  final FilmsVoir fv;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function setFilmState;
  final Function modifFonction;
  const FormModifFilmVoir({
    super.key,
    required this.fv,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.setFilmState,
    required this.modifFonction,
  });

  @override
  State<FormModifFilmVoir> createState() => _FormModifFilmVoirState();
}

class _FormModifFilmVoirState extends State<FormModifFilmVoir> {
  late TextEditingController titreController;
  late String genreController;
  late TextEditingController heureController;
  late TextEditingController minuteController;
  late TextEditingController noteController;
  late TextEditingController plateformeController;
  late TextEditingController anneeController;
  late TextEditingController descriptionController;
  late TextEditingController realisateurController;
  late String supprGenreController;
  late List<String> listeActeurs;
  final addGenreController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  final keyAddForm = GlobalKey<FormState>();
  final keySupprForm = GlobalKey<FormState>();

  void changeGenre(String g) {
    setState(() {
      genreController = g;
    });
  }

  void addActeur(String a) {
    setState(() {
      listeActeurs.add(a);
    });
  }

  void supprActeur(String a) {
    setState(() {
      listeActeurs.remove(a);
    });
  }

  @override
  void initState() {
    super.initState();
    titreController = TextEditingController(text: widget.fv.titre);
    heureController = TextEditingController(
      text: widget.fv.duree != null
          ? (widget.fv.duree! ~/ 60).toString()
          : null,
    );
    minuteController = TextEditingController(
      text: widget.fv.duree != null
          ? (widget.fv.duree! % 60).toInt().toString()
          : null,
    );
    noteController = TextEditingController(text: widget.fv.note?.toString());
    plateformeController = TextEditingController(text: widget.fv.plateforme);
    anneeController = TextEditingController(text: widget.fv.annee?.toString());
    descriptionController = TextEditingController(text: widget.fv.description);
    realisateurController = TextEditingController(text: widget.fv.realisateur);
    genreController = widget.fv.genre ?? '';
    supprGenreController = widget.listeGenres.first;
    listeActeurs = widget.fv.acteurs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          title: EnteteForm(couleur: filmJaune, txt: 'Modifier film'),
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
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampDeroulant(
                      txt: 'Genre',
                      initFormController: genreController,
                      changeGenre: changeGenre,
                      liste: widget.listeGenres,
                      addController: addGenreController,
                      addFonction: widget.addGenreFonction,
                      supprFonction: widget.supprGenreFonction,
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
                    child: ChampTexte(
                      txt: 'Plateforme',
                      champController: plateformeController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListe(
                      txt: 'Acteurices principaux',
                      liste: listeActeurs,
                      addListeFonction: addActeur,
                      supprListeFonction: supprActeur,
                      apresAjoutez: 'un·e acteurice',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Réalisateur',
                      champController: realisateurController,
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
                elevation: WidgetStateProperty.all(0.0),
                backgroundColor: WidgetStateProperty.all(filmJaune),
                fixedSize: WidgetStateProperty.all(Size(150, 60)),
              ),
              onPressed: () {
                if (keyForm.currentState!.validate() &&
                    titreController.text.isNotEmpty) {
                  widget.setFilmState(() {
                    widget.modifFonction(
                      fv: widget.fv,
                      titre: titreController.text,
                      genre: genreController == '' ? null : genreController,
                      duree:
                          (heureController.text != '') ||
                              (minuteController.text != '')
                          ? (int.tryParse(heureController.text) ?? 0) * 60 +
                                (int.tryParse(minuteController.text) ?? 0)
                          : null,
                      annee: int.tryParse(anneeController.text),
                      plateforme: plateformeController.text == ''
                          ? null
                          : plateformeController.text,
                      description: descriptionController.text == ''
                          ? null
                          : descriptionController.text,
                      note: double.tryParse(noteController.text),
                      acteurs: listeActeurs.isEmpty ? null : listeActeurs,
                      realisateur: realisateurController.text == ''
                          ? null
                          : realisateurController.text,
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: ComposantTexte(
                texte: 'Modifier',
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
