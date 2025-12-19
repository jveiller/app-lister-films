import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/forms/form_ajouter_film_voir.dart';
import 'package:flutter/material.dart';

class BoutonAjouterFilmVoir extends StatelessWidget {
  final List<String> listeGenre;
  final Function addGenreFonction;
  final Function deleteGenreFonction;
  final Function setFilmState;
  final Function addFilmFonction;
  const BoutonAjouterFilmVoir({
    super.key,
    required this.listeGenre,
    required this.addFilmFonction,
    required this.setFilmState,
    required this.addGenreFonction,
    required this.deleteGenreFonction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FormAjouterFilmVoir(
              listeGenres: listeGenre,
              addGenreFonction: addGenreFonction,
              supprGenreFonction: deleteGenreFonction,
              setFilmState: setFilmState,
              addFilmFonction: addFilmFonction,
            );
          },
        );
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0.0),
        fixedSize: WidgetStateProperty.all(Size.infinite),
        side: WidgetStateProperty.all(BorderSide(width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ComposantTexte(texte: 'Ajouter', color: Colors.grey[800], size: 18),
          Icon(Icons.add, color: Colors.grey[700], size: 25),
        ],
      ),
    );
  }
}
