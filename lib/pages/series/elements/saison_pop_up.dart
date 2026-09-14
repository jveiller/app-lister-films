import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_note.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_texte.dart';
import 'package:culture_app1/commun/elements/form/entete_form.dart';
import 'package:culture_app1/pages/series/elements/carre_progression.dart';
import 'package:culture_app1/pages/series/elements/episode_pop_up.dart';
import 'package:flutter/material.dart';

class SaisonPopUp extends StatefulWidget {
  final Serie serie;
  final Saison saison;
  final List<String> listeAvecQui;
  final Function addAvecQuiFonction;
  final Function supprAvecQuiFonction;
  final Function selectionnerAvecQuiFonction;
  final Function sauvegarderFonction;
  final Function toggleEpisodeVuFonction;
  const SaisonPopUp({
    super.key,
    required this.serie,
    required this.saison,
    required this.listeAvecQui,
    required this.addAvecQuiFonction,
    required this.supprAvecQuiFonction,
    required this.selectionnerAvecQuiFonction,
    required this.sauvegarderFonction,
    required this.toggleEpisodeVuFonction,
  });

  @override
  State<SaisonPopUp> createState() => _SaisonPopUpState();
}

class _SaisonPopUpState extends State<SaisonPopUp> {
  late TextEditingController nbEpisodesController;
  late TextEditingController noteController;
  late TextEditingController commentaireController;

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
            txt: 'Saison ${widget.saison.numero}',
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
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0.0),
                    backgroundColor: WidgetStateProperty.all(serieOrange),
                  ),
                  onPressed: () {
                    setStateDialog(() {
                      widget.saison.setNbEpisodes(
                        int.tryParse(nbEpisodesController.text),
                      );
                      widget.saison.setNote(
                        double.tryParse(noteController.text),
                      );
                      widget.saison.setCommentaire(
                        commentaireController.text == ''
                            ? null
                            : commentaireController.text,
                      );
                    });
                    widget.sauvegarderFonction(widget.serie);
                  },
                  child: ComposantTexte(
                    texte: 'Enregistrer',
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.saison.definie) ...[
                SizedBox(height: 10),
                ComposantTexte(texte: 'Épisodes', weight: FontWeight.bold),
                Wrap(
                  children: [
                    for (Episode e in widget.saison.episodes)
                      CarreProgression(
                        texte: '${e.numero}',
                        rempli: e.vu,
                        enCours: false,
                        couleur: serieOrange,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => EpisodePopUp(
                              serie: widget.serie,
                              episode: e,
                              listeAvecQui: widget.listeAvecQui,
                              addAvecQuiFonction: widget.addAvecQuiFonction,
                              supprAvecQuiFonction:
                                  widget.supprAvecQuiFonction,
                              selectionnerAvecQuiFonction:
                                  widget.selectionnerAvecQuiFonction,
                              sauvegarderFonction: widget.sauvegarderFonction,
                            ),
                          ).then((_) => setStateDialog(() {}));
                        },
                        onToggle: () {
                          widget.toggleEpisodeVuFonction(widget.serie, e);
                          setStateDialog(() {});
                        },
                      ),
                  ],
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: ComposantTexte(texte: 'Fermer'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
