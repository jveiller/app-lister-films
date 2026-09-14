import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/forms/form_avis_film.dart';
import 'package:flutter/material.dart';

class BoutonVuFilm extends StatelessWidget {
  final FilmsVoir fv;
  final List<String> listeGenres;
  final Function addGenreFonction;
  final Function supprGenreFonction;
  final Function selectionnerGenreFonction;
  final Function deleteFilmVoirFonction;
  final List<String> listePlateformes;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  final Function selectionnerPlateformeFonction;
  const BoutonVuFilm({
    super.key,
    required this.fv,
    required this.listeGenres,
    required this.addGenreFonction,
    required this.supprGenreFonction,
    required this.selectionnerGenreFonction,
    required this.deleteFilmVoirFonction,
    required this.listePlateformes,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
    required this.selectionnerPlateformeFonction,
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
              selectionnerGenreFonction: selectionnerGenreFonction,
              deleteFilmVoirFonction: deleteFilmVoirFonction,
              listePlateformes: listePlateformes,
              addPlateformeFonction: addPlateformeFonction,
              supprPlateformeFonction: supprPlateformeFonction,
              selectionnerPlateformeFonction: selectionnerPlateformeFonction,
            );
          },
        );
      },
      child: ComposantTexte(texte: 'Vu'),
    );
  }
}
