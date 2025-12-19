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
  final Function modifFilmFonction;
  const FilmVuPopUp({
    super.key,
    required this.fv,
    required this.supprFilmFonction,
    required this.listeGenres,
    required this.modifFilmFonction,
    required this.addGenreFonction,
    required this.supprGenreFonction,
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
                    ComposantTexte(texte: 'Genre', weight: FontWeight.bold),
                    ComposantTexte(texte: widget.fv.genre!),
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
                    ComposantTexte(texte: widget.fv.acteurs!.join(',')),
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
                    ComposantTexte(texte: widget.fv.realisateur as String),
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
                      ComposantTexte(texte: c),
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
              if (widget.fv.plateforme != '' &&
                  widget.fv.plateforme != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Plateforme',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(texte: widget.fv.plateforme as String),
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
                        if (widget.fv.genre != null &&
                            !widget.listeGenres.contains(
                              widget.fv.genre ?? '',
                            )) {
                          widget.addGenreFonction(widget.fv.genre!);
                        }
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
                                  setFilmState: setStateDialog3,
                                  modifFonction: widget.modifFilmFonction,
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
