import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/pages/series/elements/forms/form_ajouter_serie.dart';
import 'package:flutter/material.dart';

class BoutonAjouterSerie extends StatelessWidget {
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
  final Function setSerieState;
  final Function addSerieFonction;
  const BoutonAjouterSerie({
    super.key,
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
    required this.setSerieState,
    required this.addSerieFonction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FormAjouterSerie(
              listeGenres: listeGenres,
              addGenreFonction: addGenreFonction,
              supprGenreFonction: supprGenreFonction,
              selectionnerGenreFonction: selectionnerGenreFonction,
              listePlateformes: listePlateformes,
              addPlateformeFonction: addPlateformeFonction,
              supprPlateformeFonction: supprPlateformeFonction,
              selectionnerPlateformeFonction: selectionnerPlateformeFonction,
              listeAvecQui: listeAvecQui,
              addAvecQuiFonction: addAvecQuiFonction,
              supprAvecQuiFonction: supprAvecQuiFonction,
              selectionnerAvecQuiFonction: selectionnerAvecQuiFonction,
              listeRecommandations: listeRecommandations,
              addRecommandationFonction: addRecommandationFonction,
              supprRecommandationFonction: supprRecommandationFonction,
              selectionnerRecommandationFonction:
                  selectionnerRecommandationFonction,
              setSerieState: setSerieState,
              addSerieFonction: addSerieFonction,
            );
          },
        );
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0.0),
        side: WidgetStateProperty.all(BorderSide(width: 2)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ComposantTexte(texte: 'Ajouter', color: Colors.grey[800], size: 18),
            Icon(
              Icons.add,
              color: Colors.grey[700],
              size: TailleAdaptateur.font(context, 25),
            ),
          ],
        ),
      ),
    );
  }
}
