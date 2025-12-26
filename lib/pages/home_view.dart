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
      currentIndex = (current <= 3) ? current : currentIndex;
      realIndex = real;
    });
  }

  Color couleurIndex(int index) {
    switch (index) {
      case 0:
        return filmJaune;
      case 1:
        return serieOrange;
      case 2:
        return livreRouge;
      case 3:
        return podcastRose;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [FilmPage(), SeriePage(), LivrePage(), PodcastPage()][realIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          height: 110,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: currentIndex,
              onTap: (index) => setCurrentIndex(index, index),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              iconSize: 28,
              showUnselectedLabels: true,
              selectedItemColor: couleurIndex(currentIndex),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.movie),
                  label: 'Films',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.slideshow),
                  label: 'Séries',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.menu_book),
                  label: 'Livres',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.mic),
                  label: 'Podcasts',
                ),
              ],
            ),
          ),

          /*NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => setCurrentIndex(index, index),
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.movie),
                selectedIcon: Icon(Icons.movie, color: filmJaune),
                label: 'Films',
              ),
              NavigationDestination(
                icon: Icon(Icons.slideshow),
                selectedIcon: Icon(Icons.slideshow, color: serieOrange),
                label: 'Séries',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book),
                selectedIcon: Icon(Icons.menu_book, color: livreRouge),
                label: 'Livres',
              ),
              NavigationDestination(
                icon: Icon(Icons.mic),
                selectedIcon: Icon(Icons.mic, color: podcastRose),
                label: 'Podcasts',
              ),
            ],
          ),*/

          /**/
        ),
      ),
    );
  }
}
