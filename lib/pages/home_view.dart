import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/pages/films/films_page.dart';
import 'package:culture_app1/pages/livres/livres_page.dart';
import 'package:culture_app1/pages/podcasts/podcasts_page.dart';
import 'package:culture_app1/pages/series/series_page.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  static int currentIndex = 0;
  static int realIndex = 0;

  void setCurrentIndex(int current, int real) {
    setState(() {
      // Met à jour les index selon la logique précédente
      currentIndex = (current <= 3) ? current : currentIndex;
      realIndex = real;
    });
  }

  /*
  void setCurrentIndex(int index, [int? mission]) {
    // index entre 0 et 2 pour la BottomNavigationBar
    currentIndex = (index <= 2) ? index : currentIndex;

    // pageIndex peut être n’importe quelle page (3, 4, etc.)
    pageIndex = index;

    if (mission != null) {
      missionEnCours = mission;
    }

    setState(() {});
  }


  setCurrentIndex(int current, int real) {
    setState(() {
      currentIndex = current;
      realIndex = real;
      print(realIndex.toString());
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [FilmPage(), SeriePage(), LivrePage(), PodcastPage()][realIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white, //Plus joli en mainBlue.withOpacity(0.2), ?

            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300, // ✅ Contour intérieur fin
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) => setCurrentIndex(index, index),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            iconSize: 28,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.movie),
                activeIcon: Icon(Icons.movie, color: filmJaune),
                label: 'Films',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.slideshow),
                activeIcon: Icon(Icons.slideshow, color: serieOrange),
                label: 'Séries',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book),
                activeIcon: Icon(Icons.menu_book, color: livreRouge),
                label: 'Livres',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.mic),
                activeIcon: Icon(Icons.mic, color: podcastRose),
                label: 'Podcasts',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
