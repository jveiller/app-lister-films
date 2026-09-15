import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/series/elements/serie_pop_up.dart';
import 'package:flutter/material.dart';

class SerieCard extends StatefulWidget {
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
  const SerieCard({
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
  State<SerieCard> createState() => _SerieCardState();
}

class _SerieCardState extends State<SerieCard> {
  String sousTitre() {
    final episodes = widget.serie.tousLesEpisodes;
    if (widget.serie.statut == 'en_cours') {
      final vus = episodes.where((e) => e.vu).length;
      return '$vus épisode·s vus sur ${episodes.length}';
    }
    final estimation = widget.serie.estimationEpisodes;
    if (estimation != null) {
      return '${estimation.nbEpisodes} épisodes de ${estimation.dureeMoyenne} minutes';
    }
    if (widget.serie.genre != null) return widget.serie.genre!.join('/');
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SeriePopUp(
              serie: widget.serie,
              supprSerieFonction: widget.supprSerieFonction,
              listeGenres: widget.listeGenres,
              addGenreFonction: widget.addGenreFonction,
              supprGenreFonction: widget.supprGenreFonction,
              selectionnerGenreFonction: widget.selectionnerGenreFonction,
              listePlateformes: widget.listePlateformes,
              addPlateformeFonction: widget.addPlateformeFonction,
              supprPlateformeFonction: widget.supprPlateformeFonction,
              selectionnerPlateformeFonction:
                  widget.selectionnerPlateformeFonction,
              listeAvecQui: widget.listeAvecQui,
              addAvecQuiFonction: widget.addAvecQuiFonction,
              supprAvecQuiFonction: widget.supprAvecQuiFonction,
              selectionnerAvecQuiFonction: widget.selectionnerAvecQuiFonction,
              listeRecommandations: widget.listeRecommandations,
              addRecommandationFonction: widget.addRecommandationFonction,
              supprRecommandationFonction:
                  widget.supprRecommandationFonction,
              selectionnerRecommandationFonction:
                  widget.selectionnerRecommandationFonction,
              modifSerieFonction: widget.modifSerieFonction,
              sauvegarderFonction: widget.sauvegarderFonction,
              toggleEpisodeVuFonction: widget.toggleEpisodeVuFonction,
              definirPositionFonction: widget.definirPositionFonction,
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: TailleAdaptateur.width(context, 20),
            vertical: 5,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: widget.serie.titre,
                      size: 20,
                      weight: FontWeight.bold,
                      alignment: TextAlign.start,
                    ),
                    ComposantTexte(
                      texte: sousTitre(),
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: ComposantTexte(
                  texte: widget.serie.note != null
                      ? widget.serie.note.toString()
                      : 'Pas de note',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
