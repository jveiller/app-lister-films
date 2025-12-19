import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class BoutonAnnuler extends StatelessWidget {
  final String txt;
  final double size;
  final Color color;
  const BoutonAnnuler({
    super.key,
    this.txt = 'Annuler',
    this.size = 16,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: ComposantTexte(texte: txt, size: size, color: color),
    );
  }
}
