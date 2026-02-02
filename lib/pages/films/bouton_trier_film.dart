import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class BoutonTrierFilm extends StatelessWidget {
  final Function fonctionTriDuree;
  final Function fonctionTriNote;
  final Function fonctionTriAjout;
  const BoutonTrierFilm({
    super.key,
    required this.fonctionTriAjout,
    required this.fonctionTriDuree,
    required this.fonctionTriNote,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'ajout',
          child: ComposantTexte(texte: 'Date d\'ajout'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'duree',
          child: ComposantTexte(texte: 'Durée'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'note',
          child: ComposantTexte(texte: 'Note'),
        ),
      ],
      //constraints: BoxConstraints(minWidth: 130),
      position: PopupMenuPosition.over,
      offset: const Offset(0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(width: 2),
      ),
      onSelected: (val) {
        if (val == 'duree') {
          fonctionTriDuree();
        } else if (val == 'note') {
          fonctionTriNote();
        } else if (val == 'ajout') {
          fonctionTriAjout();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ComposantTexte(
                texte: 'Trier par',
                color: Colors.grey[800],
                size: 18,
              ),
              Icon(Icons.arrow_drop_down, color: Colors.grey[700], size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
