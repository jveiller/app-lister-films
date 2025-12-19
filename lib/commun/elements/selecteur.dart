import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Selecteur extends StatelessWidget {
  Color couleurOn;
  Color couleurOff;
  String txtVoir;
  String txtVu;
  bool vu;
  Function() onTap1;
  Function() onTap2;

  Selecteur({
    super.key,
    required this.couleurOff,
    required this.couleurOn,
    required this.txtVoir,
    required this.txtVu,
    required this.vu,
    required this.onTap1,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 185,
          decoration: BoxDecoration(
            color: vu == true ? couleurOff : couleurOn,

            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: TextButton(
            onPressed: onTap1,
            child: ComposantTexte(
              texte: txtVoir,
              size: 23,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 60,
          width: 185,
          decoration: BoxDecoration(
            color: vu == false ? couleurOff : couleurOn,

            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: TextButton(
            onPressed: onTap2,
            child: ComposantTexte(
              texte: txtVu,
              size: 23,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
