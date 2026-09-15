import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVu/elements/form/form_ajouter_film_vu.dart';
import 'package:flutter/material.dart';

class BoutonAjouterFilmVu extends StatelessWidget {
  final List<String> listeGenre;
  final Function addGenreFonction;
  final Function deleteGenreFonction;
  final Function selectionnerGenreFonction;
  final Function setFilmState;
  final Function addFilmFonction;
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
  const BoutonAjouterFilmVu({
    super.key,
    required this.listeGenre,
    required this.addFilmFonction,
    required this.setFilmState,
    required this.addGenreFonction,
    required this.deleteGenreFonction,
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
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FormAjouterFilmVu(
              listeGenres: listeGenre,
              addGenreFonction: addGenreFonction,
              supprGenreFonction: deleteGenreFonction,
              selectionnerGenreFonction: selectionnerGenreFonction,
              setFilmState: setFilmState,
              addFilmFonction: addFilmFonction,
              listePlateformes: listePlateformes,
              addPlateformeFonction: addPlateformeFonction,
              supprPlateformeFonction: supprPlateformeFonction,
              selectionnerPlateformeFonction: selectionnerPlateformeFonction,
              listePersonnes: listePersonnes,
              addPersonneFonction: addPersonneFonction,
              supprPersonneFonction: supprPersonneFonction,
              selectionnerPersonneFonction: selectionnerPersonneFonction,
              listeCinemas: listeCinemas,
              addCinemaFonction: addCinemaFonction,
              supprCinemaFonction: supprCinemaFonction,
              selectionnerCinemaFonction: selectionnerCinemaFonction,
              listeRecommandations: listeRecommandations,
              addRecommandationFonction: addRecommandationFonction,
              supprRecommandationFonction: supprRecommandationFonction,
              selectionnerRecommandationFonction:
                  selectionnerRecommandationFonction,
            );
          },
        );
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0.0),
        //fixedSize: WidgetStateProperty.all(Size.infinite),
        side: WidgetStateProperty.all(BorderSide(width: 2)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ComposantTexte(texte: 'Ajouter', color: Colors.grey[800], size: 18),
            Icon(Icons.add, color: Colors.grey[700], size: 25),
          ],
        ),
      ),
    );
  }
}
