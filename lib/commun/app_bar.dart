import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

// L'ancienne AppBar commune est en dessous
// Attention si on revient à l'ancienne AppBar, il faut modifier les composants appBar dans detail_mission et mission_form

// Ajuster la taille des appBar dans chaque page avec le paramètre height de PreferedSize

class AppBarCommune extends StatelessWidget {
  // Le composant en haut de chaque page
  final String texteBar;
  final Color couleur;
  final bool retour;
  final bool bouton;
  final Widget? pageBouton;
  const AppBarCommune({
    super.key,
    required this.texteBar,
    required this.couleur,
    this.retour = false,
    this.bouton = false,
    this.pageBouton,
  }) : assert(bouton == false || (bouton == true && pageBouton != null));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: couleur,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: TailleAdaptateur.font(context, 15)),
          child: ComposantTexte(
            texte: texteBar,
            weight: FontWeight.bold,
            size: 30,
            color: Colors.white,
          ),
        ),
        if (retour)
          Container(
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(
              bottom: TailleAdaptateur.font(context, 10),
              left: TailleAdaptateur.font(context, 20),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: TailleAdaptateur.font(context, 30),
              ),
            ),
          ),
        if (bouton)
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(
              bottom: TailleAdaptateur.font(context, 20),
              right: TailleAdaptateur.font(context, 20),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageBouton!),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  color: couleur,
                ),
                child: Icon(Icons.bar_chart, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
