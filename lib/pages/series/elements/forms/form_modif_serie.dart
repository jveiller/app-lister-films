import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/database/db_suggestions.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormModifSerie extends StatefulWidget {
  final Serie serie;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function selectionnerGenreFonction;
  final List<String> listePlateformes;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  final Function selectionnerPlateformeFonction;
  final List<String> listeAvecQui;
  final Function addAvecQuiFonction;
  final Function supprAvecQuiFonction;
  final Function selectionnerAvecQuiFonction;
  final List<String> listeRecommandations;
  final Function addRecommandationFonction;
  final Function supprRecommandationFonction;
  final Function selectionnerRecommandationFonction;
  final Function setSerieState;
  final Function modifFonction;
  const FormModifSerie({
    super.key,
    required this.serie,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.selectionnerGenreFonction,
    required this.listePlateformes,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
    required this.selectionnerPlateformeFonction,
    required this.listeAvecQui,
    required this.addAvecQuiFonction,
    required this.supprAvecQuiFonction,
    required this.selectionnerAvecQuiFonction,
    required this.listeRecommandations,
    required this.addRecommandationFonction,
    required this.supprRecommandationFonction,
    required this.selectionnerRecommandationFonction,
    required this.setSerieState,
    required this.modifFonction,
  });

  @override
  State<FormModifSerie> createState() => _FormModifSerieState();
}

class _FormModifSerieState extends State<FormModifSerie> {
  late TextEditingController titreController;
  late TextEditingController anneeController;
  late TextEditingController createurController;
  late TextEditingController nbSaisonsController;
  late TextEditingController nbEpisodesMoyenController;
  late TextEditingController dureeMoyenneController;
  late TextEditingController descriptionController;
  late TextEditingController noteController;
  final keyForm = GlobalKey<FormState>();
  late List<String> genres;
  late List<String> plateformes;
  late List<String> avecQui;
  late List<String> recommandePar;
  late List<String> listeActeurs;
  late List<String> listeCitations;

  void addGenre(String g) {
    if (!genres.contains(g)) setState(() => genres.add(g));
  }

  void supprGenre(String g) => setState(() => genres.remove(g));

  void addPlateforme(String p) {
    if (!plateformes.contains(p)) setState(() => plateformes.add(p));
  }

  void supprPlateforme(String p) => setState(() => plateformes.remove(p));

  void addAvecQui(String p) {
    if (!avecQui.contains(p)) setState(() => avecQui.add(p));
  }

  void supprAvecQui(String p) => setState(() => avecQui.remove(p));

  void addRecommandation(String r) {
    if (!recommandePar.contains(r)) setState(() => recommandePar.add(r));
  }

  void supprRecommandation(String r) =>
      setState(() => recommandePar.remove(r));

  void addActeur(String a) {
    if (!listeActeurs.contains(a)) setState(() => listeActeurs.add(a));
  }

  void supprActeur(String a) => setState(() => listeActeurs.remove(a));

  void addCitation(String c) => setState(() => listeCitations.add(c));

  void supprCitation(String c) => setState(() => listeCitations.remove(c));

  @override
  void initState() {
    super.initState();
    titreController = TextEditingController(text: widget.serie.titre);
    anneeController = TextEditingController(
      text: widget.serie.annee?.toString(),
    );
    createurController = TextEditingController(text: widget.serie.createur);
    nbSaisonsController = TextEditingController(
      text: widget.serie.nbSaisons?.toString(),
    );
    nbEpisodesMoyenController = TextEditingController(
      text: widget.serie.nbEpisodesMoyen?.toString(),
    );
    dureeMoyenneController = TextEditingController(
      text: widget.serie.dureeMoyenneEpisode?.toString(),
    );
    descriptionController = TextEditingController(
      text: widget.serie.description,
    );
    noteController = TextEditingController(
      text: widget.serie.note?.toString(),
    );
    genres = widget.serie.genre ?? [];
    plateformes = widget.serie.plateforme ?? [];
    avecQui = widget.serie.avecQui ?? [];
    recommandePar = widget.serie.recommandePar ?? [];
    listeActeurs = widget.serie.acteurs ?? [];
    listeCitations = widget.serie.citations ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final labelNote = widget.serie.statut == 'vu'
        ? 'Note'
        : 'Envie de voir';
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          title: EnteteForm(couleur: serieOrange, txt: 'Modifier série'),
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
                    child: ChampListeDeroulant(
                      txt: 'Genre·s',
                      liste: genres,
                      listeDeroulant: widget.listeGenres,
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
                    child: ChampListeDeroulant(
                      txt: 'Plateforme·s',
                      liste: plateformes,
                      listeDeroulant: widget.listePlateformes,
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
                    child: ChampNote(
                      txt: labelNote,
                      champController: noteController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampNombre(
                      txt: 'Nombre de saisons',
                      champController: nbSaisonsController,
                      largeur: 80,
                      nbMaxNombres: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampNombre(
                      txt: 'Nombre moyen d\'épisodes par saison',
                      champController: nbEpisodesMoyenController,
                      largeur: 80,
                      nbMaxNombres: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampNombre(
                      txt: 'Durée moyenne d\'un épisode (min)',
                      champController: dureeMoyenneController,
                      largeur: 80,
                      nbMaxNombres: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListe(
                      txt: 'Acteurs/Actrices principaux',
                      liste: listeActeurs,
                      addListeFonction: addActeur,
                      supprListeFonction: supprActeur,
                      apresAjoutez: 'un·e acteur·ice',
                      suggestionsFonction: DbSuggestions.getActeurs,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampTexte(
                      txt: 'Créateur·rice',
                      champController: createurController,
                      suggestionsFonction: DbSuggestions.getRealisateurs,
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
                    child: ChampListeDeroulant(
                      txt: 'Avec qui',
                      liste: avecQui,
                      listeDeroulant: widget.listeAvecQui,
                      addDeroulantFonction: widget.addAvecQuiFonction,
                      supprDeroulantFonction: widget.supprAvecQuiFonction,
                      selectionnerDeroulantFonction:
                          widget.selectionnerAvecQuiFonction,
                      addListeFonction: addAvecQui,
                      supprListeFonction: supprAvecQui,
                      apresAjoutez: 'une personne',
                      txtFeminin: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListeDeroulant(
                      txt: 'Recommandé par',
                      liste: recommandePar,
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
                    child: ChampTexte(
                      txt: 'Description',
                      champController: descriptionController,
                      plusieursLignes: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ChampListe(
                      txt: 'Citations marquantes',
                      liste: listeCitations,
                      addListeFonction: addCitation,
                      supprListeFonction: supprCitation,
                      apresAjoutez: 'une citation',
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
                backgroundColor: WidgetStateProperty.all(serieOrange),
                fixedSize: WidgetStateProperty.all(
                  Size.fromWidth(TailleAdaptateur.width(context, 150)),
                ),
              ),
              onPressed: () {
                if (keyForm.currentState!.validate() &&
                    titreController.text.isNotEmpty) {
                  widget.setSerieState(() {
                    widget.modifFonction(
                      serie: widget.serie,
                      titre: titreController.text,
                      genre: genres.isEmpty ? null : genres,
                      plateforme: plateformes.isEmpty ? null : plateformes,
                      annee: int.tryParse(anneeController.text),
                      createur: createurController.text == ''
                          ? null
                          : createurController.text,
                      acteurs: listeActeurs.isEmpty ? null : listeActeurs,
                      nbSaisons: int.tryParse(nbSaisonsController.text),
                      nbEpisodesMoyen: int.tryParse(
                        nbEpisodesMoyenController.text,
                      ),
                      dureeMoyenneEpisode: int.tryParse(
                        dureeMoyenneController.text,
                      ),
                      avecQui: avecQui.isEmpty ? null : avecQui,
                      recommandePar: recommandePar.isEmpty
                          ? null
                          : recommandePar,
                      description: descriptionController.text == ''
                          ? null
                          : descriptionController.text,
                      citations: listeCitations.isEmpty
                          ? null
                          : listeCitations,
                      note: double.tryParse(noteController.text),
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
