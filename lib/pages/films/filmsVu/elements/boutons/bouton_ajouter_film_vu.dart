import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/films/filmsVu/elements/form/form_ajouter_film_vu.dart';
import 'package:flutter/material.dart';

class BoutonAjouterFilmVu extends StatelessWidget {
  final List<String> listeGenre;
  final Function addGenreFonction;
  final Function deleteGenreFonction;
  final Function setFilmState;
  final Function addFilmFonction;
  final List<String> listePlateformes;
  final Function addPlateformeFonction;
  final Function supprPlateformeFonction;
  const BoutonAjouterFilmVu({
    super.key,
    required this.listeGenre,
    required this.addFilmFonction,
    required this.setFilmState,
    required this.addGenreFonction,
    required this.deleteGenreFonction,
    required this.listePlateformes,
    required this.addPlateformeFonction,
    required this.supprPlateformeFonction,
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
              setFilmState: setFilmState,
              addFilmFonction: addFilmFonction,
              listePlateformes: listePlateformes,
              addPlateformeFonction: addPlateformeFonction,
              supprPlateformeFonction: supprPlateformeFonction,
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
