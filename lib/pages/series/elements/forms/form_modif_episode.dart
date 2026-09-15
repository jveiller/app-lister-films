import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_date.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_liste_deroulant.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:flutter/material.dart';

class FormModifEpisode extends StatefulWidget {
  final Serie serie;
  final Episode episode;
  final List<String> listeAvecQui;
  final Function addAvecQuiFonction;
  final Function supprAvecQuiFonction;
  final Function selectionnerAvecQuiFonction;
  final Function setEpisodeState;
  final Function sauvegarderFonction;
  const FormModifEpisode({
    super.key,
    required this.serie,
    required this.episode,
    required this.listeAvecQui,
    required this.addAvecQuiFonction,
    required this.supprAvecQuiFonction,
    required this.selectionnerAvecQuiFonction,
    required this.setEpisodeState,
    required this.sauvegarderFonction,
  });

  @override
  State<FormModifEpisode> createState() => _FormModifEpisodeState();
}

class _FormModifEpisodeState extends State<FormModifEpisode> {
  late TextEditingController titreController;
  late TextEditingController dureeController;
  late TextEditingController noteController;
  late TextEditingController descriptionController;
  late List<String> avecQui;
  late bool vu;
  DateTime? dateVisionnageController;

  void changeDateVisionnage(DateTime? value) {
    setState(() => dateVisionnageController = value);
  }

  void addAvecQui(String p) {
    if (!avecQui.contains(p)) {
      setState(() {
        avecQui.add(p);
      });
    }
  }

  void supprAvecQui(String p) {
    setState(() {
      avecQui.remove(p);
    });
  }

  @override
  void initState() {
    super.initState();
    titreController = TextEditingController(text: widget.episode.titre);
    dureeController = TextEditingController(
      text: widget.episode.duree?.toString(),
    );
    noteController = TextEditingController(
      text: widget.episode.note?.toString(),
    );
    descriptionController = TextEditingController(
      text: widget.episode.description,
    );
    avecQui = widget.episode.avecQui ?? [];
    vu = widget.episode.vu;
    dateVisionnageController = widget.episode.dateVisionnage;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          scrollable: true,
          backgroundColor: Colors.white,
          title: EnteteForm(
            couleur: serieOrange,
            txt: 'Modifier épisode ${widget.episode.numero}',
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: ChampTexte(
                  txt: 'Titre de l\'épisode',
                  champController: titreController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    ComposantTexte(texte: 'Vu', weight: FontWeight.bold),
                    Switch(
                      value: vu,
                      activeColor: serieOrange,
                      onChanged: (v) => setStateDialog(() => vu = v),
                    ),
                  ],
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
                child: ChampNombre(
                  txt: 'Durée (min)',
                  champController: dureeController,
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
                child: ChampDate(
                  txt: 'Date de visionnage',
                  changeDate: changeDateVisionnage,
                  date: dateVisionnageController,
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
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0.0),
                backgroundColor: WidgetStateProperty.all(serieOrange),
                fixedSize: WidgetStateProperty.all(
                  Size.fromWidth(TailleAdaptateur.width(context, 150)),
                ),
              ),
              onPressed: () {
                final etaitVuAvant = widget.serie.statut == 'vu';
                widget.setEpisodeState(() {
                  widget.episode.setTitre(
                    titreController.text == ''
                        ? null
                        : titreController.text,
                  );
                  widget.episode.setVu(vu);
                  widget.episode.setAvecQui(
                    avecQui.isEmpty ? null : avecQui,
                  );
                  widget.episode.setDuree(
                    int.tryParse(dureeController.text),
                  );
                  widget.episode.setNote(
                    double.tryParse(noteController.text),
                  );
                  widget.episode.setDescription(
                    descriptionController.text == ''
                        ? null
                        : descriptionController.text,
                  );
                  widget.episode.setDateVisionnage(dateVisionnageController);
                });
                widget.sauvegarderFonction(
                  widget.serie,
                  etaitVuAvant: etaitVuAvant,
                );
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
      },
    );
  }
}
