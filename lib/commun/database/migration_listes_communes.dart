import 'package:hive/hive.dart';

// Migration one-shot : genres, plateformes, recommandations et personnes
// étaient jusque-là dupliqués par type de contenu (Films à voir, Films vus,
// Séries), chacun avec sa propre liste de suggestions. On les fusionne une
// fois pour toutes dans la box 'film', qui devient la source commune aux
// deux types, en conservant les valeurs déjà saisies par l'utilisateur.
Future<void> migrerListesCommunes() async {
  final filmBox = Hive.box('film');
  if (filmBox.get('migrationListesCommunesV1') == true) return;

  final filmVuBox = Hive.box('filmVu');
  final serieBox = Hive.box('serie');

  List<String> fusionner(List<List<String>?> listes) {
    final resultat = <String>[];
    for (final liste in listes) {
      if (liste == null) continue;
      for (final valeur in liste) {
        if (!resultat.contains(valeur)) resultat.add(valeur);
      }
    }
    return resultat;
  }

  final List<String>? filmGenres = filmBox.get('genres');
  final List<String>? serieGenres = serieBox.get('genres');
  final genres = fusionner([filmGenres, serieGenres]);
  if (genres.isNotEmpty) await filmBox.put('genres', genres);

  final List<String>? filmPlateformes = filmBox.get('plateformes');
  final List<String>? seriePlateformes = serieBox.get('plateformes');
  final plateformes = fusionner([filmPlateformes, seriePlateformes]);
  if (plateformes.isNotEmpty) await filmBox.put('plateformes', plateformes);

  final List<String>? filmRecommandations = filmBox.get('recommandations');
  final List<String>? filmVuRecommandations = filmVuBox.get('recommandations');
  final List<String>? serieRecommandations = serieBox.get('recommandations');
  final recommandations = fusionner([
    filmRecommandations,
    filmVuRecommandations,
    serieRecommandations,
  ]);
  if (recommandations.isNotEmpty) {
    await filmBox.put('recommandations', recommandations);
  }

  final List<String>? filmVuPersonnes = filmVuBox.get('personnes');
  final List<String>? serieAvecQui = serieBox.get('avecQui');
  final personnes = fusionner([filmVuPersonnes, serieAvecQui]);
  if (personnes.isNotEmpty) await filmBox.put('personnes', personnes);

  await serieBox.delete('genres');
  await serieBox.delete('plateformes');
  await serieBox.delete('recommandations');
  await serieBox.delete('avecQui');
  await filmVuBox.delete('recommandations');
  await filmVuBox.delete('personnes');

  await filmBox.put('migrationListesCommunesV1', true);
}
