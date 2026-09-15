import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/pages/series/elements/forms/form_modif_episode.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EpisodePopUp extends StatefulWidget {
  final Serie serie;
  final Episode episode;
  final List<String> listeAvecQui;
  final Function addAvecQuiFonction;
  final Function supprAvecQuiFonction;
  final Function selectionnerAvecQuiFonction;
  final Function sauvegarderFonction;
  const EpisodePopUp({
    super.key,
    required this.serie,
    required this.episode,
    required this.listeAvecQui,
    required this.addAvecQuiFonction,
    required this.supprAvecQuiFonction,
    required this.selectionnerAvecQuiFonction,
    required this.sauvegarderFonction,
  });

  @override
  State<EpisodePopUp> createState() => _EpisodePopUpState();
}

class _EpisodePopUpState extends State<EpisodePopUp> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        final episode = widget.episode;
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
          title: ComposantTexte(
            texte: 'Épisode ${episode.numero}',
            size: 22,
            weight: FontWeight.bold,
          ),
          content: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (episode.titre != null && episode.titre != '') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Titre', weight: FontWeight.bold),
                    ComposantTexte(
                      texte: episode.titre!,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComposantTexte(texte: 'Vu', weight: FontWeight.bold),
                  ComposantTexte(texte: episode.vu ? 'Oui' : 'Non'),
                ],
              ),
              if (episode.avecQui != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Avec qui',
                      weight: FontWeight.bold,
                    ),
                    for (String p in episode.avecQui!)
                      ComposantTexte(texte: p, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (episode.duree != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Durée', weight: FontWeight.bold),
                    ComposantTexte(texte: '${episode.duree} min'),
                  ],
                ),
              ],
              if (episode.note != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Note', weight: FontWeight.bold),
                    ComposantTexte(texte: '${episode.note} / 10'),
                  ],
                ),
              ],
              if (episode.dateVisionnage != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de visionnage',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat(
                        'dd/MM/yyyy',
                      ).format(episode.dateVisionnage!),
                    ),
                  ],
                ),
              ],
              if (episode.description != null &&
                  episode.description != '') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Description',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: episode.description!,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => FormModifEpisode(
                            serie: widget.serie,
                            episode: episode,
                            listeAvecQui: widget.listeAvecQui,
                            addAvecQuiFonction: widget.addAvecQuiFonction,
                            supprAvecQuiFonction: widget.supprAvecQuiFonction,
                            selectionnerAvecQuiFonction:
                                widget.selectionnerAvecQuiFonction,
                            setEpisodeState: setStateDialog,
                            sauvegarderFonction: widget.sauvegarderFonction,
                          ),
                        );
                      },
                      child: ComposantTexte(texte: 'Modifier'),
                    ),
                    BoutonAnnuler(txt: 'Fermer'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
