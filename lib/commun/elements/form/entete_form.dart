import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnteteForm extends StatelessWidget {
  Color couleur;
  String txt;
  EnteteForm({super.key, required this.couleur, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TailleAdaptateur.width(context, 70),
      decoration: BoxDecoration(border: Border.all(width: 2.0)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              color: couleur,
              child: ComposantTexte(
                texte: txt,
                weight: FontWeight.bold,
                size: 23,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: TailleAdaptateur.width(context, 70),
            width: TailleAdaptateur.width(context, 70),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0.0),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.close_outlined,
                  size: TailleAdaptateur.font(context, 30),
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
