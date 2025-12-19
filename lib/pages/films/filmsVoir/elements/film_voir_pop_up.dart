import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_supprimer.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/boutons/bouton_vu_film.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/forms/form_modif_film_voir.dart';
import 'package:flutter/material.dart';

class FilmVoirPopUp extends StatefulWidget {
  final FilmsVoir fv;
  final Function supprFilmFonction;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function modifFilmFonction;
  const FilmVoirPopUp({
    super.key,
    required this.fv,
    required this.supprFilmFonction,
    required this.listeGenres,
    required this.modifFilmFonction,
    required this.addGenreFonction,
    required this.supprGenreFonction,
  });

  @override
  State<FilmVoirPopUp> createState() => _FilmVoirPopUpState();
}

class _FilmVoirPopUpState extends State<FilmVoirPopUp> {
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
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    BoutonSupprimer(
                      media: 'film',
                      delete: () => widget.supprFilmFonction(widget.fv.id),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (widget.fv.genre != null) {
                          if (!widget.listeGenres.contains(widget.fv.genre)) {
                            await widget.addGenreFonction(widget.fv.genre);
                          }
                        }
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return FormModifFilmVoir(
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
                    BoutonVuFilm(
                      fv: widget.fv,
                      listeGenres: widget.listeGenres,
                      addGenreFonction: widget.addGenreFonction,
                      supprGenreFonction: widget.supprGenreFonction,
                      deleteFilmVoirFonction: widget.supprFilmFonction,
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
