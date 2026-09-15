import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_supprimer.dart';
import 'package:culture_app1/pages/series/elements/carre_progression.dart';
import 'package:culture_app1/pages/series/elements/forms/form_modif_serie.dart';
import 'package:culture_app1/pages/series/elements/position_pop_up.dart';
import 'package:culture_app1/pages/series/elements/saison_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeriePopUp extends StatefulWidget {
  final Serie serie;
  final Function supprSerieFonction;
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
  final Function modifSerieFonction;
  final Function sauvegarderFonction;
  final Function toggleEpisodeVuFonction;
  final Function definirPositionFonction;
  const SeriePopUp({
    super.key,
    required this.serie,
    required this.supprSerieFonction,
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
    required this.modifSerieFonction,
    required this.sauvegarderFonction,
    required this.toggleEpisodeVuFonction,
    required this.definirPositionFonction,
  });

  @override
  State<SeriePopUp> createState() => _SeriePopUpState();
}

class _SeriePopUpState extends State<SeriePopUp> {

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog3) {
        final statut = widget.serie.statut;
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
          title: ComposantTexte(
            texte: widget.serie.titre,
            size: 22,
            weight: FontWeight.bold,
          ),
          content: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.serie.genre != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Genre·s', weight: FontWeight.bold),
                    ComposantTexte(
                      texte: widget.serie.genre!.join('/'),
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.serie.note != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Note',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(texte: '${widget.serie.note} / 10'),
                  ],
                ),
              ],
              if (widget.serie.annee != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Année de sortie',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(texte: widget.serie.annee.toString()),
                  ],
                ),
              ],
              if (widget.serie.dateDebutEffective != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de début',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat(
                        'dd/MM/yyyy',
                      ).format(widget.serie.dateDebutEffective!),
                    ),
                  ],
                ),
              ],
              if (widget.serie.dateFinEffective != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de fin',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat(
                        'dd/MM/yyyy',
                      ).format(widget.serie.dateFinEffective!),
                    ),
                  ],
                ),
              ],
              if (widget.serie.createur != null &&
                  widget.serie.createur != '') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Créateur·rice',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.serie.createur!,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.serie.acteurs != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Acteurices principaux',
                      weight: FontWeight.bold,
                    ),
                    for (String a in widget.serie.acteurs!)
                      ComposantTexte(texte: a, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.serie.plateforme != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Plateforme·s',
                      weight: FontWeight.bold,
                    ),
                    for (String p in widget.serie.plateforme!)
                      ComposantTexte(texte: p, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.serie.avecQui != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Avec qui',
                      weight: FontWeight.bold,
                    ),
                    for (String p in widget.serie.avecQui!)
                      ComposantTexte(texte: p, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.serie.recommandePar != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Recommandé par',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.serie.recommandePar!.join('/'),
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.serie.description != null &&
                  widget.serie.description != '') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Description',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.serie.description!,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.serie.citations != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Citations marquantes',
                      weight: FontWeight.bold,
                    ),
                    for (String c in widget.serie.citations!)
                      ComposantTexte(texte: c, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.serie.nbEpisodesMoyen != null ||
                  widget.serie.dureeMoyenneEpisode != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.serie.nbEpisodesMoyen != null)
                      ComposantTexte(
                        texte:
                            '${widget.serie.nbEpisodesMoyen} épisodes / saison en moyenne',
                        alignment: TextAlign.start,
                      ),
                    if (widget.serie.dureeMoyenneEpisode != null)
                      ComposantTexte(
                        texte:
                            '${widget.serie.dureeMoyenneEpisode} min / épisode en moyenne',
                        alignment: TextAlign.start,
                      ),
                  ],
                ),
              ],
              if (widget.serie.saisons.isNotEmpty) ...[
                ComposantTexte(texte: 'Saisons', weight: FontWeight.bold),
                Wrap(
                  children: [
                    for (Saison s in widget.serie.saisons)
                      CarreProgression(
                        texte: '${s.numero}',
                        rempli: s.complete,
                        enCours: s.enCours,
                        couleur: serieOrange,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SaisonPopUp(
                              serie: widget.serie,
                              saison: s,
                              listeAvecQui: widget.listeAvecQui,
                              addAvecQuiFonction: widget.addAvecQuiFonction,
                              supprAvecQuiFonction:
                                  widget.supprAvecQuiFonction,
                              selectionnerAvecQuiFonction:
                                  widget.selectionnerAvecQuiFonction,
                              sauvegarderFonction: widget.sauvegarderFonction,
                              toggleEpisodeVuFonction:
                                  widget.toggleEpisodeVuFonction,
                            ),
                          ).then((_) => setStateDialog3(() {}));
                        },
                      ),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    BoutonSupprimer(
                      media: 'série',
                      delete: () =>
                          widget.supprSerieFonction(widget.serie.id),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return FormModifSerie(
                                  serie: widget.serie,
                                  listeGenres: widget.listeGenres,
                                  addGenreFonction: widget.addGenreFonction,
                                  supprGenreFonction:
                                      widget.supprGenreFonction,
                                  selectionnerGenreFonction:
                                      widget.selectionnerGenreFonction,
                                  listePlateformes: widget.listePlateformes,
                                  addPlateformeFonction:
                                      widget.addPlateformeFonction,
                                  supprPlateformeFonction:
                                      widget.supprPlateformeFonction,
                                  selectionnerPlateformeFonction:
                                      widget.selectionnerPlateformeFonction,
                                  listeAvecQui: widget.listeAvecQui,
                                  addAvecQuiFonction:
                                      widget.addAvecQuiFonction,
                                  supprAvecQuiFonction:
                                      widget.supprAvecQuiFonction,
                                  selectionnerAvecQuiFonction:
                                      widget.selectionnerAvecQuiFonction,
                                  listeRecommandations:
                                      widget.listeRecommandations,
                                  addRecommandationFonction:
                                      widget.addRecommandationFonction,
                                  supprRecommandationFonction:
                                      widget.supprRecommandationFonction,
                                  selectionnerRecommandationFonction:
                                      widget.selectionnerRecommandationFonction,
                                  setSerieState: setStateDialog3,
                                  modifFonction: widget.modifSerieFonction,
                                );
                              },
                            );
                          },
                        );
                      },
                      child: ComposantTexte(texte: 'Modifier'),
                    ),
                    if (statut != 'vu' && widget.serie.saisons.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => PositionPopUp(
                              serie: widget.serie,
                              definirPositionFonction:
                                  widget.definirPositionFonction,
                            ),
                          ).then((_) => setStateDialog3(() {}));
                        },
                        child: ComposantTexte(texte: 'Ma position'),
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
