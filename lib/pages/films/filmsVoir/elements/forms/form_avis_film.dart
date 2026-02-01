import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/database/db_film_vu.dart';
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
import 'package:hive/hive.dart';

class FormAvisFilm extends StatefulWidget {
  final FilmsVoir fv;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function deleteFilmVoirFonction;
  const FormAvisFilm({
    super.key,
    required this.fv,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.deleteFilmVoirFonction,
  });

  @override
  State<FormAvisFilm> createState() => _FormAvisFilmState();
}

class _FormAvisFilmState extends State<FormAvisFilm> {
  late TextEditingController titreController;
  //late String genreController;
  late List<String> genres;
  late TextEditingController heureController;
  late TextEditingController minuteController;
  final noteController = TextEditingController();
  late TextEditingController plateformeController;
  late TextEditingController anneeController;
  late TextEditingController descriptionController;
  late TextEditingController realisateurController;
  bool? cinemaController;
  bool ouiIsCheck = false;
  bool nonIsCheck = false;
  final contexteController = TextEditingController();
  DateTime? dateController;
  late String supprGenreController;
  late List<String> listeActeurs;
  final List<String> listeCitations = [];
  //final addGenreController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  //final keyAddForm = GlobalKey<FormState>();
  //final keySupprForm = GlobalKey<FormState>();

  void _convertFilm({
    required String titre,
    int? annee,
    int? duree,
    List<String>? genre,
    String? plateforme,
    String? description,
    double? note,
    List<String>? acteurs,
    List<String>? citations,
    String? realisateur,
    String? contexte,
    bool? cinema,
    DateTime? date,
  }) async {
    var box = await Hive.openBox('filmVu');
    int id = box.get('id') ?? 1;
    var newFilm = FilmsVu(
      id: id,
      titre: titre,
      annee: annee,
      duree: duree,
      genre: genre,
      plateforme: plateforme,
      description: description,
      note: note,
      acteurs: acteurs,
      citations: citations,
      realisateur: realisateur,
      contexte: contexte,
      cinema: cinema,
      date: date,
    );
    //Fonction pour ajouter une élément dans la base de données
    //Si l'élément renvoyé par le champ nom du form n'est pas null
    await DbFilmsVu.insert(newFilm);
    id += 1;
    await box.put('id', id);
    widget.deleteFilmVoirFonction(widget.fv.id);
    await box.close();
  }

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
    setState(() {
      listeCitations.add(c);
    });
  }

  void supprCitation(String c) {
    setState(() {
      listeCitations.remove(c);
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
    plateformeController = TextEditingController(text: widget.fv.plateforme);
    anneeController = TextEditingController(text: widget.fv.annee?.toString());
    descriptionController = TextEditingController(text: widget.fv.description);
    realisateurController = TextEditingController(text: widget.fv.realisateur);
    genres = widget.fv.genre ?? [];
    //supprGenreController = widget.listeGenres.first;
    listeActeurs = widget.fv.acteurs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          title: EnteteForm(couleur: filmJaune, txt: 'Avis film'),
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
                      txt: 'Genre',
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
                      apresAjoutez: 'un·e acteur·rice',
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
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Plateforme',
                      champController: plateformeController,
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
            Container(
              margin: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0.0),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  fixedSize: WidgetStateProperty.all(Size(130, 60)),
                  side: WidgetStateProperty.all(BorderSide(width: 1)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ComposantTexte(
                  texte: 'Annuler',
                  color: Colors.black,
                  weight: FontWeight.bold,
                  size: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0.0),
                  backgroundColor: WidgetStateProperty.all(filmJaune),
                  fixedSize: WidgetStateProperty.all(Size(130, 60)),
                ),
                onPressed: () {
                  if (keyForm.currentState!.validate() &&
                      titreController.text.isNotEmpty) {
                    _convertFilm(
                      titre: titreController.text,
                      genre: genres.isEmpty ? null : genres,
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
                      citations: listeCitations.isEmpty ? null : listeCitations,
                      realisateur: realisateurController.text == ''
                          ? null
                          : realisateurController.text,
                      contexte: contexteController.text == ''
                          ? null
                          : contexteController.text,
                      cinema: cinemaController,
                      date: dateController,
                    );
                    Navigator.pop(context);
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
            ),
          ],
        );
      },
    );
  }
}
