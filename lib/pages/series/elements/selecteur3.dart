import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class Selecteur3 extends StatelessWidget {
  final Color couleurOn;
  final Color couleurOff;
  final String valeur;
  final String txt1;
  final String txt2;
  final String txt3;
  final String val1;
  final String val2;
  final String val3;
  final Function(String) onTap;
  const Selecteur3({
    super.key,
    required this.couleurOff,
    required this.couleurOn,
    required this.valeur,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.val1,
    required this.val2,
    required this.val3,
    required this.onTap,
  });

  Widget _segment(
    BuildContext context,
    String txt,
    String val,
    BorderRadius radius,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: TailleAdaptateur.width(context, 125),
      decoration: BoxDecoration(
        color: valeur == val ? couleurOn : couleurOff,
        borderRadius: radius,
      ),
      child: TextButton(
        onPressed: () => onTap(val),
        child: ComposantTexte(
          texte: txt,
          size: 16,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _segment(
          context,
          txt1,
          val1,
          const BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        _segment(context, txt2, val2, BorderRadius.zero),
        _segment(
          context,
          txt3,
          val3,
          const BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ],
    );
  }
}
