import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_date.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormModifSaison extends StatefulWidget {
  final Serie serie;
  final Saison saison;
  final Function setSaisonState;
  final Function sauvegarderFonction;
  const FormModifSaison({
    super.key,
    required this.serie,
    required this.saison,
    required this.setSaisonState,
    required this.sauvegarderFonction,
  });

  @override
  State<FormModifSaison> createState() => _FormModifSaisonState();
}

class _FormModifSaisonState extends State<FormModifSaison> {
  late TextEditingController nbEpisodesController;
  late TextEditingController noteController;
  late TextEditingController commentaireController;
  DateTime? dateDebutController;
  DateTime? dateFinController;

  void changeDateDebut(DateTime? value) {
    setState(() => dateDebutController = value);
  }

  void changeDateFin(DateTime? value) {
    setState(() => dateFinController = value);
  }

  @override
  void initState() {
    super.initState();
    nbEpisodesController = TextEditingController(
      text: widget.saison.nbEpisodes?.toString(),
    );
    noteController = TextEditingController(
      text: widget.saison.note?.toString(),
    );
    commentaireController = TextEditingController(
      text: widget.saison.commentaire,
    );
    dateDebutController = widget.saison.dateDebut;
    dateFinController = widget.saison.dateFin;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      scrollable: true,
      backgroundColor: Colors.white,
      title: EnteteForm(
        couleur: serieOrange,
        txt: 'Modifier saison ${widget.saison.numero}',
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: ChampNombre(
              txt: 'Nombre d\'épisodes',
              champController: nbEpisodesController,
              largeur: 80,
              nbMaxNombres: 3,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: ChampNote(txt: 'Note', champController: noteController),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: ChampTexte(
              txt: 'Commentaire',
              champController: commentaireController,
              plusieursLignes: true,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: ChampDate(
              txt: 'Date de début',
              changeDate: changeDateDebut,
              date: dateDebutController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: ChampDate(
              txt: 'Date de fin',
              changeDate: changeDateFin,
              date: dateFinController,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0.0),
            backgroundColor: WidgetStateProperty.all(serieOrange),
          ),
          onPressed: () {
            widget.setSaisonState(() {
              widget.saison.setNbEpisodes(
                int.tryParse(nbEpisodesController.text),
              );
              widget.saison.setNote(double.tryParse(noteController.text));
              widget.saison.setCommentaire(
                commentaireController.text == ''
                    ? null
                    : commentaireController.text,
              );
              widget.saison.setDateDebut(dateDebutController);
              widget.saison.setDateFin(dateFinController);
            });
            widget.sauvegarderFonction(widget.serie);
            Navigator.pop(context);
          },
          child: ComposantTexte(
            texte: 'Modifier',
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
