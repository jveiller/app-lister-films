import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/selecteur.dart';
import 'package:flutter/material.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({super.key});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(texteBar: 'PODCASTS', couleur: podcastRose),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Selecteur(
            vu: vu,
            txtVoir: 'À ÉCOUTER',
            txtVu: 'ÉCOUTÉ',
            couleurOff: Color.fromARGB(255, 185, 175, 149),
            couleurOn: podcastRose,
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
