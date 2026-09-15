import 'package:culture_app1/commun/database/db_film_voir.dart';
import 'package:culture_app1/commun/database/db_film_vu.dart';
import 'package:culture_app1/commun/database/db_serie.dart';

// Suggestions d'autocomplétion pour les acteurs·ices et les réalisateur·ices
// (et créateur·ices de séries) : dérivées à la volée des valeurs déjà
// saisies par l'utilisateur dans ses films et séries, communes aux deux
// types plutôt que gérées par une liste séparée à alimenter manuellement.
class DbSuggestions {
  static Set<String> _extraireValeurs(
    List<Map<String, Object?>> lignes,
    String colonne, {
    bool separeParVirgule = false,
  }) {
    final valeurs = <String>{};
    for (final ligne in lignes) {
      final brut = ligne[colonne] as String?;
      if (brut == null || brut.isEmpty) continue;
      if (separeParVirgule) {
        for (final v in brut.split(',')) {
          final t = v.trim();
          if (t.isNotEmpty) valeurs.add(t);
        }
      } else {
        final t = brut.trim();
        if (t.isNotEmpty) valeurs.add(t);
      }
    }
    return valeurs;
  }

  static List<String> _trier(Set<String> valeurs) {
    final liste = valeurs.toList();
    liste.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return liste;
  }

  static Future<List<String>> getActeurs() async {
    final dbVoir = await DbFilmsVoir.getDatabase();
    final dbVu = await DbFilmsVu.getDatabase();
    final dbSerie = await DbSerie.getDatabase();
    final valeurs = <String>{};
    valeurs.addAll(
      _extraireValeurs(
        await dbVoir.query('filmsVoir3', columns: ['acteurs']),
        'acteurs',
        separeParVirgule: true,
      ),
    );
    valeurs.addAll(
      _extraireValeurs(
        await dbVu.query('filmsVu2', columns: ['acteurs']),
        'acteurs',
        separeParVirgule: true,
      ),
    );
    valeurs.addAll(
      _extraireValeurs(
        await dbSerie.query('series1', columns: ['acteurs']),
        'acteurs',
        separeParVirgule: true,
      ),
    );
    return _trier(valeurs);
  }

  static Future<List<String>> getRealisateurs() async {
    final dbVoir = await DbFilmsVoir.getDatabase();
    final dbVu = await DbFilmsVu.getDatabase();
    final dbSerie = await DbSerie.getDatabase();
    final valeurs = <String>{};
    valeurs.addAll(
      _extraireValeurs(
        await dbVoir.query('filmsVoir3', columns: ['realisateur']),
        'realisateur',
      ),
    );
    valeurs.addAll(
      _extraireValeurs(
        await dbVu.query('filmsVu2', columns: ['realisateur']),
        'realisateur',
      ),
    );
    valeurs.addAll(
      _extraireValeurs(
        await dbSerie.query('series1', columns: ['createur']),
        'createur',
      ),
    );
    return _trier(valeurs);
  }
}
