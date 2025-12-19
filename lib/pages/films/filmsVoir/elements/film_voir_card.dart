import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/film_voir_pop_up.dart';
import 'package:flutter/material.dart';

class FilmVoirCard extends StatefulWidget {
  final FilmsVoir fv;
  final Function supprFilmFonction;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function modifFilmFonction;
  const FilmVoirCard({
    super.key,
    required this.fv,
    required this.supprFilmFonction,
    required this.listeGenres,
    required this.modifFilmFonction,
    required this.addGenreFonction,
    required this.supprGenreFonction,
  });

  @override
  State<FilmVoirCard> createState() => _FilmVoirCardState();
}

class _FilmVoirCardState extends State<FilmVoirCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return FilmVoirPopUp(
              fv: widget.fv,
              supprFilmFonction: widget.supprFilmFonction,
              listeGenres: widget.listeGenres,
              modifFilmFonction: widget.modifFilmFonction,
              addGenreFonction: widget.addGenreFonction,
              supprGenreFonction: widget.supprGenreFonction,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: widget.fv.titre,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    if (widget.fv.duree != null) ...[
                      if ((widget.fv.duree! % 60) == 0 &&
                          (widget.fv.duree! / 60).toInt() != 0)
                        ComposantTexte(
                          texte: '${(widget.fv.duree! / 60).toInt()}h',
                        )
                      else if ((widget.fv.duree! % 60) < 10 &&
                          (widget.fv.duree! / 60).toInt() != 0 &&
                          (widget.fv.duree! % 60) != 0)
                        ComposantTexte(
                          texte:
                              '${(widget.fv.duree! / 60).toInt()}h0${widget.fv.duree! % 60}',
                        )
                      else if ((widget.fv.duree! % 60) >= 10 &&
                          (widget.fv.duree! / 60).toInt() != 0)
                        ComposantTexte(
                          texte:
                              '${(widget.fv.duree! / 60).toInt()}h${widget.fv.duree! % 60}',
                        )
                      else
                        ComposantTexte(texte: '${widget.fv.duree! % 60} min'),
                    ] else if (widget.fv.genre != null) ...[
                      ComposantTexte(texte: widget.fv.genre!),
                    ] else ...[
                      ComposantTexte(texte: ''),
                    ],
                  ],
                ),
              ),
              ComposantTexte(
                texte: widget.fv.note != null
                    ? widget.fv.note.toString()
                    : 'Pas de note',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
