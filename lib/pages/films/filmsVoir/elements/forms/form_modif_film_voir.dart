import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
//import 'package:culture_app1/commun/elements/form/champs/champ_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_duree.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormModifFilmVoir extends StatefulWidget {
  final FilmsVoir fv;
  final List<String> listeGenres;
  final List<String> listePlateformes;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function selectionnerGenreFonction;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  final Function selectionnerPlateformeFonction;
  final Function setFilmState;
  final Function modifFonction;
  final List<String> listeRecommandations;
  final Function addRecommandationFonction;
  final Function supprRecommandationFonction;
  final Function selectionnerRecommandationFonction;
  const FormModifFilmVoir({
    super.key,
    required this.fv,
    required this.listeGenres,
    required this.listePlateformes,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.selectionnerGenreFonction,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
    required this.selectionnerPlateformeFonction,
    required this.setFilmState,
    required this.modifFonction,
    required this.listeRecommandations,
    required this.addRecommandationFonction,
    required this.supprRecommandationFonction,
    required this.selectionnerRecommandationFonction,
  });

  @override
  State<FormModifFilmVoir> createState() => _FormModifFilmVoirState();
}

class _FormModifFilmVoirState extends State<FormModifFilmVoir> {
  late TextEditingController titreController;
  //late String genreController;
  late List<String> genres;
  late List<String> plateformes;
  late List<String> recommandations;
  late TextEditingController heureController;
  late TextEditingController minuteController;
  late TextEditingController noteController;
  //late TextEditingController plateformeController;
  late TextEditingController anneeController;
  late TextEditingController descriptionController;
  late TextEditingController realisateurController;
  //late String supprGenreController;
  late List<String> listeActeurs;
  final addGenreController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  //final keyAddForm = GlobalKey<FormState>();
  //final keySupprForm = GlobalKey<FormState>();

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

  void addRecommandation(String r) {
    if (!recommandations.contains(r)) {
      setState(() {
        recommandations.add(r);
      });
    }
  }

  void supprRecommandation(String r) {
    setState(() {
      recommandations.remove(r);
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
    //plateformeController = TextEditingController(text: widget.fv.plateforme);
    anneeController = TextEditingController(text: widget.fv.annee?.toString());
    descriptionController = TextEditingController(text: widget.fv.description);
    realisateurController = TextEditingController(text: widget.fv.realisateur);
    genres = widget.fv.genre ?? [];
    plateformes = widget.fv.plateforme ?? [];
    //supprGenreController = widget.listeGenres.first;
    listeActeurs = widget.fv.acteurs ?? [];
    recommandations = widget.fv.recommandation ?? [];
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
                  /*Container(
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
                      selectionnerDeroulantFonction:
                          widget.selectionnerGenreFonction,
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
                      selectionnerDeroulantFonction:
                          widget.selectionnerPlateformeFonction,
                      addListeFonction: addPlateforme,
                      supprListeFonction: supprPlateforme,
                      apresAjoutez: 'une plateforme',
                      txtFeminin: true,
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
                    child: ChampListeDeroulant(
                      txt: 'Recommandé par',
                      liste: recommandations,
                      listeDeroulant: widget.listeRecommandations,
                      addDeroulantFonction: widget.addRecommandationFonction,
                      supprDeroulantFonction:
                          widget.supprRecommandationFonction,
                      selectionnerDeroulantFonction:
                          widget.selectionnerRecommandationFonction,
                      addListeFonction: addRecommandation,
                      supprListeFonction: supprRecommandation,
                      apresAjoutez: 'une recommandation',
                      txtFeminin: true,
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
                    widget.modifFonction(
                      fv: widget.fv,
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
                      realisateur: realisateurController.text == ''
                          ? null
                          : realisateurController.text,
                      recommandation: recommandations.isEmpty
                          ? null
                          : recommandations,
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
