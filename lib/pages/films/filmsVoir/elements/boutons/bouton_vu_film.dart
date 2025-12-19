import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/forms/form_avis_film.dart';
import 'package:flutter/material.dart';

class BoutonVuFilm extends StatelessWidget {
  final FilmsVoir fv;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function deleteFilmVoirFonction;
  const BoutonVuFilm({
    super.key,
    required this.fv,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.deleteFilmVoirFonction,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return FormAvisFilm(
              fv: fv,
              listeGenres: listeGenres,
              addGenreFonction: addGenreFonction,
              supprGenreFonction: supprGenreFonction,
              deleteFilmVoirFonction: deleteFilmVoirFonction,
            );
          },
        );
      },
      child: ComposantTexte(texte: 'Vu'),
    );
  }
}
