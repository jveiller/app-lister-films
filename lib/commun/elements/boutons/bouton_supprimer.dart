import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

class BoutonSupprimer extends StatelessWidget {
  final String media;
  final Function delete;
  const BoutonSupprimer({super.key, required this.media, required this.delete});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: ComposantTexte(
              texte: 'Supprimer $media',
              weight: FontWeight.bold,
              size: 20,
            ),
            content: SizedBox(
              width: 600,
              child: ComposantTexte(
                texte: 'Voulez-vous vraiment supprimer ce $media ?',
                alignment: TextAlign.start,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            actions: [
              BoutonAnnuler(),
              TextButton(
                onPressed: () {
                  delete();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: ComposantTexte(texte: 'Confirmer'),
              ),
            ],
          ),
        );
      },
      child: ComposantTexte(texte: 'Supprimer', color: Colors.red[900]),
    );
  }
}
