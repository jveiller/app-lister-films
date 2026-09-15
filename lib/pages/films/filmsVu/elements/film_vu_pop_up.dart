import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_supprimer.dart';
import 'package:culture_app1/pages/films/filmsVu/elements/form/form_modif_film_vu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilmVuPopUp extends StatefulWidget {
  final FilmsVu fv;
  final Function supprFilmFonction;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function selectionnerGenreFonction;
  final Function modifFilmFonction;
  final List<String> listePlateformes;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  final Function selectionnerPlateformeFonction;
  final List<String> listePersonnes;
  final Function addPersonneFonction;
  final Function supprPersonneFonction;
  final Function selectionnerPersonneFonction;
  final List<String> listeCinemas;
  final Function addCinemaFonction;
  final Function supprCinemaFonction;
  final Function selectionnerCinemaFonction;
  final List<String> listeRecommandations;
  final Function addRecommandationFonction;
  final Function supprRecommandationFonction;
  final Function selectionnerRecommandationFonction;
  const FilmVuPopUp({
    super.key,
    required this.fv,
    required this.supprFilmFonction,
    required this.listeGenres,
    required this.modifFilmFonction,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.selectionnerGenreFonction,
    required this.listePlateformes,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
    required this.selectionnerPlateformeFonction,
    required this.listePersonnes,
    required this.addPersonneFonction,
    required this.supprPersonneFonction,
    required this.selectionnerPersonneFonction,
    required this.listeCinemas,
    required this.addCinemaFonction,
    required this.supprCinemaFonction,
    required this.selectionnerCinemaFonction,
    required this.listeRecommandations,
    required this.addRecommandationFonction,
    required this.supprRecommandationFonction,
    required this.selectionnerRecommandationFonction,
  });

  @override
  State<FilmVuPopUp> createState() => _FilmVuPopUpState();
}

class _FilmVuPopUpState extends State<FilmVuPopUp> {
  ComposantTexte printDuree(int duree) {
    if ((duree % 60) == 0 && (duree / 60).toInt() != 0) {
      return ComposantTexte(texte: '${(duree / 60).toInt()}h');
    } else if ((duree % 60) < 10 &&
        (duree / 60).toInt() != 0 &&
        (duree % 60) != 0) {
      return ComposantTexte(texte: '${(duree / 60).toInt()}h0${duree % 60}');
    } else if ((duree % 60) >= 10 && (duree / 60).toInt() != 0) {
      return ComposantTexte(texte: '${(duree / 60).toInt()}h${duree % 60}');
    } else {
      return ComposantTexte(texte: '${duree % 60} min');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog3) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
          title: ComposantTexte(
            texte: widget.fv.titre,
            size: 22,
            weight: FontWeight.bold,
          ),
          content: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.fv.genre != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Genre·s', weight: FontWeight.bold),
                    ComposantTexte(
                      texte: widget.fv.genre!.join('/'),
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.fv.duree != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Durée', weight: FontWeight.bold),
                    printDuree(widget.fv.duree!),
                  ],
                ),
              ],
              if (widget.fv.note != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Note', weight: FontWeight.bold),
                    ComposantTexte(texte: '${widget.fv.note} / 10'),
                  ],
                ),
              ],
              if (widget.fv.date != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de visionnage',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat("dd/MM/yyyy").format(widget.fv.date!),
                    ),
                  ],
                ),
              ],
              if (widget.fv.acteurs != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Acteurices principaux',
                      weight: FontWeight.bold,
                    ),
                    for (String a in widget.fv.acteurs!)
                      ComposantTexte(texte: a, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.fv.realisateur != '' &&
                  widget.fv.realisateur != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Réalisateur',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.realisateur as String,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.fv.recommandation != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Recommandé par',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.recommandation!.join('/'),
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.fv.description != '' &&
                  widget.fv.description != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Description',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.description as String,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.fv.citations != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Citations marquantes',
                      weight: FontWeight.bold,
                    ),
                    for (String c in widget.fv.citations!)
                      ComposantTexte(texte: c, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.fv.cinema != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Vu au cinéma',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.cinema == false ? 'Non' : 'Oui',
                    ),
                  ],
                ),
              ],
              if (widget.fv.cinema == true && widget.fv.cinemas != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Cinéma·s', weight: FontWeight.bold),
                    for (String c in widget.fv.cinemas!)
                      ComposantTexte(texte: c, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.fv.accompagne != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Vu accompagné·e',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.accompagne == false ? 'Non' : 'Oui',
                    ),
                  ],
                ),
              ],
              if (widget.fv.accompagne == true &&
                  widget.fv.personnes != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Personnes',
                      weight: FontWeight.bold,
                    ),
                    for (String p in widget.fv.personnes!)
                      ComposantTexte(texte: p, alignment: TextAlign.start),
                  ],
                ),
              ],
              if (widget.fv.contexte != '' && widget.fv.contexte != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Contexte de visionnage',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: widget.fv.contexte as String,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (widget.fv.annee != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Année de sortie',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(texte: widget.fv.annee.toString()),
                  ],
                ),
              ],
              if (widget.fv.plateforme != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Plateforme·s',
                      weight: FontWeight.bold,
                    ),
                    for (String p in widget.fv.plateforme!)
                      ComposantTexte(texte: p, alignment: TextAlign.start),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    BoutonSupprimer(
                      media: 'film',
                      delete: () => widget.supprFilmFonction(widget.fv.id),
                    ),
                    TextButton(
                      onPressed: () {
                        /*if (widget.fv.genre != null) {
                          for (var genre in widget.fv.genre!) {
                            if (!widget.listeGenres.contains(genre)) {
                              widget.addGenreFonction(genre);
                            }
                          }
                        }*/
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return FormModifFilmVu(
                                  fv: widget.fv,
                                  listeGenres: widget.listeGenres,
                                  addGenreFonction: widget.addGenreFonction,
                                  supprGenreFonction: widget.supprGenreFonction,
                                  selectionnerGenreFonction:
                                      widget.selectionnerGenreFonction,
                                  setFilmState: setStateDialog3,
                                  modifFonction: widget.modifFilmFonction,
                                  listePlateformes: widget.listePlateformes,
                                  addPlateformeFonction:
                                      widget.addPlateformeFonction,
                                  supprPlateformeFonction:
                                      widget.supprPlateformeFonction,
                                  selectionnerPlateformeFonction:
                                      widget.selectionnerPlateformeFonction,
                                  listePersonnes: widget.listePersonnes,
                                  addPersonneFonction:
                                      widget.addPersonneFonction,
                                  supprPersonneFonction:
                                      widget.supprPersonneFonction,
                                  selectionnerPersonneFonction:
                                      widget.selectionnerPersonneFonction,
                                  listeCinemas: widget.listeCinemas,
                                  addCinemaFonction: widget.addCinemaFonction,
                                  supprCinemaFonction:
                                      widget.supprCinemaFonction,
                                  selectionnerCinemaFonction:
                                      widget.selectionnerCinemaFonction,
                                  listeRecommandations:
                                      widget.listeRecommandations,
                                  addRecommandationFonction:
                                      widget.addRecommandationFonction,
                                  supprRecommandationFonction:
                                      widget.supprRecommandationFonction,
                                  selectionnerRecommandationFonction:
                                      widget.selectionnerRecommandationFonction,
                                );
                              },
                            );
                          },
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
