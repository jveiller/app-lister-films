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
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ComposantTexte(
                      texte: 'Supprimer $media',
                      weight: FontWeight.bold,
                      size: 20,
                      alignment: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ComposantTexte(
                      texte: 'Voulez-vous vraiment supprimer ce $media ?',
                      alignment: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BoutonAnnuler(),
                        SizedBox(width: 10),
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
                  ],
                ),
              ),
            );
          },
        );
      },
      child: ComposantTexte(texte: 'Supprimer', color: Colors.red[900]),
    );
  }
}
