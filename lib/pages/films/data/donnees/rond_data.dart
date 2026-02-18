import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:flutter/material.dart';

class RondData extends StatelessWidget {
  final String data;
  const RondData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: TailleAdaptateur.width(context, 150),
          height: TailleAdaptateur.width(context, 150),
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
            color: filmJaune,
          ),
          child: Center(
            child: ComposantTexte(
              texte: data,
              size: 48,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
