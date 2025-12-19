import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/selecteur.dart';
import 'package:flutter/material.dart';

class SeriePage extends StatefulWidget {
  const SeriePage({super.key});

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(texteBar: 'SÉRIES', couleur: serieOrange),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Selecteur(
            vu: vu,
            txtVoir: 'À VOIR',
            txtVu: 'VU',
            couleurOff: Color.fromARGB(255, 185, 175, 149),
            couleurOn: serieOrange,
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
