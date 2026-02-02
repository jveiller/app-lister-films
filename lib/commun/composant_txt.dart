import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComposantTexte extends StatelessWidget {
  Color? color;
  double size;
  FontWeight weight;
  TextAlign alignment;
  String texte;
  String family;

  ComposantTexte({
    super.key,
    required this.texte,
    this.color = Colors.black,
    this.size = 16,
    this.weight = FontWeight.normal,
    this.alignment = TextAlign.center,
    this.family = 'Comic Sans MS',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texte,
      style: TextStyle(
        color: color,
        fontSize: TailleAdaptateur.font(context, size),
        fontWeight: weight,
        fontFamily: family,
      ),
      textAlign: alignment,
      maxLines: null,
    );
  }
}
