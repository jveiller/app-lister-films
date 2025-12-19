import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/selecteur.dart';
import 'package:flutter/material.dart';

class LivrePage extends StatefulWidget {
  const LivrePage({super.key});

  @override
  State<LivrePage> createState() => _LivrePageState();
}

class _LivrePageState extends State<LivrePage> {
  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(texteBar: 'LIVRES', couleur: livreRouge),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Selecteur(
            vu: vu,
            txtVoir: 'À LIRE',
            txtVu: 'LU',
            couleurOff: Color.fromARGB(255, 185, 175, 149),
            couleurOn: livreRouge,
            onTap1: () {
              setState(() {
                vu = false;
              });
            },
            onTap2: () {
              setState(() {
                vu = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
