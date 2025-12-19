import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

// L'ancienne AppBar commune est en dessous
// Attention si on revient à l'ancienne AppBar, il faut modifier les composants appBar dans detail_mission et mission_form

// Ajuster la taille des appBar dans chaque page avec le paramètre height de PreferedSize

// ignore: must_be_immutable
class AppBarCommune extends StatelessWidget {
  // Le composant en haut de chaque page
  String texteBar;
  final Color couleur;
  AppBarCommune({super.key, required this.texteBar, required this.couleur});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: couleur,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 15),
      child: ComposantTexte(
        texte: texteBar,
        weight: FontWeight.bold,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
