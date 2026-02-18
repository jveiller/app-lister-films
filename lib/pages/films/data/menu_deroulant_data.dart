import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class MenuDeroulantData extends StatelessWidget {
  final double largeurDeroulant;
  final String value;
  final List<String> listValues;
  final List<String> listAffichage;
  final Function(String) fctChange;
  const MenuDeroulantData({
    super.key,
    required this.value,
    required this.fctChange,
    required this.listValues,
    required this.listAffichage,
    this.largeurDeroulant = 350,
  }) : assert(listValues.length == listAffichage.length);

  @override
  Widget build(BuildContext context) {
    if (listValues.length > 1) {
      return SizedBox(
        width: TailleAdaptateur.width(context, largeurDeroulant),
        //margin: EdgeInsets.symmetric(
        //horizontal: TailleAdaptateur.width(context, 30),
        //vertical: 10,
        //),
        child: PopupMenuButton<String>(
          itemBuilder: (context) => [
            for (var i = 0; i < listValues.length; i++) ...[
              PopupMenuItem(
                value: listValues[i],
                height: TailleAdaptateur.height(context, 36),
                child: Center(
                  child: ComposantTexte(texte: listAffichage[i], size: 20),
                ),
              ),
              if (listValues.length < 6 && i < listValues.length - 1)
                PopupMenuDivider(),
            ],
          ],
          constraints: BoxConstraints(
            minWidth: TailleAdaptateur.width(context, largeurDeroulant),
          ),
          position: PopupMenuPosition.over,
          offset: const Offset(0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(width: 2),
          ),
          onSelected: (val) {
            fctChange(val);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.2),
              borderRadius: BorderRadius.circular(45),
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Center(
                  child: ComposantTexte(
                    texte: listAffichage[listValues.indexOf(value)],
                    color: Colors.grey[800],
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey[700],
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: TailleAdaptateur.width(context, largeurDeroulant),
        decoration: BoxDecoration(
          border: Border.all(width: 1.2),
          borderRadius: BorderRadius.circular(45),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Center(
              child: ComposantTexte(
                texte: listAffichage[listValues.indexOf(value)],
                color: Colors.grey[800],
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[700],
                size: 25,
              ),
            ),
          ],
        ),
      );
    }
  }
}
