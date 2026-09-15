class Episode {
  int numero;
  String? titre;
  bool vu;
  int? duree;
  double? note;
  String? description;
  List<String>? avecQui;
  DateTime? dateVisionnage;

  Episode({
    required this.numero,
    this.titre,
    this.vu = false,
    this.duree,
    this.note,
    this.description,
    this.avecQui,
    this.dateVisionnage,
  });

  void setTitre(String? t) => titre = t;
  void setVu(bool v) => vu = v;
  void setDuree(int? d) => duree = d;
  void setNote(double? n) => note = n;
  void setDescription(String? d) => description = d;
  void setAvecQui(List<String>? a) => avecQui = a;
  void setDateVisionnage(DateTime? d) => dateVisionnage = d;

  Map<String, dynamic> toMap() => {
    'numero': numero,
    'titre': titre,
    'vu': vu,
    'duree': duree,
    'note': note,
    'description': description,
    'avecQui': avecQui,
    'dateVisionnage': dateVisionnage?.toIso8601String(),
  };

  factory Episode.fromMap(Map<String, dynamic> map) => Episode(
    numero: map['numero'] as int,
    titre: map['titre'] as String?,
    vu: map['vu'] as bool? ?? false,
    duree: map['duree'] as int?,
    note: map['note'] == null ? null : (map['note'] as num).toDouble(),
    description: map['description'] as String?,
    avecQui: map['avecQui'] == null
        ? null
        : List<String>.from(map['avecQui'] as List),
    dateVisionnage: map['dateVisionnage'] == null
        ? null
        : DateTime.parse(map['dateVisionnage'] as String),
  );
}

class Saison {
  int numero;
  int? nbEpisodes;
  double? note;
  String? commentaire;
  List<Episode> episodes;
  DateTime? dateDebut;
  DateTime? dateFin;
  // Vrai quand "Ma position" a marqué la saison comme entièrement vue alors
  // que son nombre d'épisodes n'est pas défini (donc sans épisodes à cocher
  // individuellement).
  bool completeManuelle;

  Saison({
    required this.numero,
    this.nbEpisodes,
    this.note,
    this.commentaire,
    List<Episode>? episodes,
    this.dateDebut,
    this.dateFin,
    this.completeManuelle = false,
  }) : episodes = episodes ?? [];

  // Ajuste le nombre d'épisodes : ajoute des épisodes vides ou retire les
  // derniers, en conservant les données des épisodes déjà définis.
  void setNbEpisodes(int? n) {
    nbEpisodes = n;
    if (n == null) return;
    completeManuelle = false;
    if (episodes.length > n) {
      episodes = episodes.sublist(0, n);
    } else {
      while (episodes.length < n) {
        episodes.add(Episode(numero: episodes.length + 1));
      }
    }
  }

  void setNote(double? n) => note = n;
  void setCommentaire(String? c) => commentaire = c;
  void setDateDebut(DateTime? d) => dateDebut = d;
  void setDateFin(DateTime? d) => dateFin = d;

  bool get definie => nbEpisodes != null && episodes.isNotEmpty;
  bool get complete =>
      completeManuelle || (definie && episodes.every((e) => e.vu));
  bool get enCours => !complete && definie && episodes.any((e) => e.vu);

  // Date de début/fin de la saison : la date saisie manuellement si elle
  // existe, sinon la plus ancienne/récente date de visionnage parmi ses
  // épisodes.
  DateTime? get dateDebutEffective {
    if (dateDebut != null) return dateDebut;
    final dates =
        episodes.map((e) => e.dateVisionnage).whereType<DateTime>().toList()
          ..sort();
    return dates.isEmpty ? null : dates.first;
  }

  DateTime? get dateFinEffective {
    if (dateFin != null) return dateFin;
    final dates =
        episodes.map((e) => e.dateVisionnage).whereType<DateTime>().toList()
          ..sort();
    return dates.isEmpty ? null : dates.last;
  }

  Map<String, dynamic> toMap() => {
    'numero': numero,
    'nbEpisodes': nbEpisodes,
    'note': note,
    'commentaire': commentaire,
    'episodes': episodes.map((e) => e.toMap()).toList(),
    'completeManuelle': completeManuelle,
    'dateDebut': dateDebut?.toIso8601String(),
    'dateFin': dateFin?.toIso8601String(),
  };

  factory Saison.fromMap(Map<String, dynamic> map) => Saison(
    numero: map['numero'] as int,
    nbEpisodes: map['nbEpisodes'] as int?,
    note: map['note'] == null ? null : (map['note'] as num).toDouble(),
    commentaire: map['commentaire'] as String?,
    episodes: map['episodes'] == null
        ? []
        : (map['episodes'] as List)
              .map((e) => Episode.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList(),
    completeManuelle: map['completeManuelle'] as bool? ?? false,
    dateDebut: map['dateDebut'] == null
        ? null
        : DateTime.parse(map['dateDebut'] as String),
    dateFin: map['dateFin'] == null
        ? null
        : DateTime.parse(map['dateFin'] as String),
  );
}

class Serie {
  int id;
  late String titre;
  List<String>? genre;
  List<String>? plateforme;
  int? annee;
  String? createur;
  List<String>? acteurs;
  String? description;
  List<String>? avecQui;
  List<String>? recommandePar;
  List<String>? citations;
  int? nbSaisons;
  int? nbEpisodesMoyen;
  int? dureeMoyenneEpisode;
  double? note;
  DateTime? dateDebut;
  DateTime? dateFin;
  List<Saison> saisons;

  Serie({
    required this.id,
    required this.titre,
    this.genre,
    this.plateforme,
    this.annee,
    this.createur,
    this.acteurs,
    this.description,
    this.avecQui,
    this.recommandePar,
    this.citations,
    this.nbSaisons,
    this.nbEpisodesMoyen,
    this.dureeMoyenneEpisode,
    this.note,
    this.dateDebut,
    this.dateFin,
    List<Saison>? saisons,
  }) : saisons = saisons ?? [];

  void setTitre(String titre) => this.titre = titre;
  void setGenre(List<String>? g) => genre = g;
  void setPlateforme(List<String>? p) => plateforme = p;
  void setAnnee(int? a) => annee = a;
  void setCreateur(String? c) => createur = c;
  void setActeurs(List<String>? a) => acteurs = a;
  void setDescription(String? d) => description = d;
  void setAvecQui(List<String>? a) => avecQui = a;
  void setRecommandePar(List<String>? r) => recommandePar = r;
  void setCitations(List<String>? c) => citations = c;
  void setNbEpisodesMoyen(int? n) => nbEpisodesMoyen = n;
  void setDureeMoyenneEpisode(int? d) => dureeMoyenneEpisode = d;
  void setNote(double? n) => note = n;
  void setDateDebut(DateTime? d) => dateDebut = d;
  void setDateFin(DateTime? d) => dateFin = d;

  // Ajuste le nombre de saisons : ajoute des saisons vides ou retire les
  // dernières, en conservant les données des saisons déjà définies.
  void setNbSaisons(int? n) {
    nbSaisons = n;
    if (n == null) return;
    if (saisons.length > n) {
      saisons = saisons.sublist(0, n);
    } else {
      while (saisons.length < n) {
        saisons.add(Saison(numero: saisons.length + 1));
      }
    }
  }

  List<Episode> get tousLesEpisodes =>
      saisons.expand((s) => s.episodes).toList();

  // Date de début/fin de la série : la date saisie manuellement si elle
  // existe, sinon la plus ancienne/récente date effective (elle-même
  // éventuellement dérivée des épisodes) parmi ses saisons.
  DateTime? get dateDebutEffective {
    if (dateDebut != null) return dateDebut;
    final dates =
        saisons.map((s) => s.dateDebutEffective).whereType<DateTime>().toList()
          ..sort();
    return dates.isEmpty ? null : dates.first;
  }

  DateTime? get dateFinEffective {
    if (dateFin != null) return dateFin;
    final dates =
        saisons.map((s) => s.dateFinEffective).whereType<DateTime>().toList()
          ..sort();
    return dates.isEmpty ? null : dates.last;
  }

  // Statut calculé à partir de la progression réelle plutôt que stocké, pour
  // qu'il ne puisse jamais se désynchroniser des épisodes cochés.
  String get statut {
    final episodes = tousLesEpisodes;
    final saisonsCompletes =
        saisons.isNotEmpty &&
        (nbSaisons == null || saisons.length == nbSaisons) &&
        saisons.every((s) => s.definie);
    if (episodes.isEmpty || episodes.every((e) => !e.vu)) return 'a_voir';
    if (saisonsCompletes && episodes.every((e) => e.vu)) return 'vu';
    return 'en_cours';
  }

  // Estime le nombre total d'épisodes et leur durée moyenne : pour chaque
  // saison, utilise son vrai nombre d'épisodes s'il est défini, sinon le
  // nombre moyen d'épisodes par saison de la série ; pour chaque épisode,
  // utilise sa vraie durée si elle est définie, sinon la durée moyenne d'un
  // épisode. Retourne null si une donnée nécessaire au calcul manque.
  ({int nbEpisodes, int dureeMoyenne})? get estimationEpisodes {
    if (nbSaisons == null) return null;
    int totalEpisodes = 0;
    int totalMinutes = 0;
    for (var numero = 1; numero <= nbSaisons!; numero++) {
      Saison? saison;
      for (var s in saisons) {
        if (s.numero == numero) {
          saison = s;
          break;
        }
      }
      if (saison != null && saison.nbEpisodes != null) {
        totalEpisodes += saison.nbEpisodes!;
        for (var e in saison.episodes) {
          final duree = e.duree ?? dureeMoyenneEpisode;
          if (duree == null) return null;
          totalMinutes += duree;
        }
      } else {
        if (nbEpisodesMoyen == null || dureeMoyenneEpisode == null) {
          return null;
        }
        totalEpisodes += nbEpisodesMoyen!;
        totalMinutes += nbEpisodesMoyen! * dureeMoyenneEpisode!;
      }
    }
    if (totalEpisodes == 0) return null;
    return (
      nbEpisodes: totalEpisodes,
      dureeMoyenne: (totalMinutes / totalEpisodes).round(),
    );
  }

  // Temps total (en minutes) déjà passé à regarder cette série : somme des
  // épisodes marqués vus, en utilisant leur vraie durée si elle est définie,
  // sinon la durée moyenne d'un épisode de la série. Retourne null si un
  // épisode vu n'a ni durée propre ni durée moyenne pour la compenser.
  int? get dureeVisionneeMinutes {
    int total = 0;
    for (var e in tousLesEpisodes.where((e) => e.vu)) {
      final duree = e.duree ?? dureeMoyenneEpisode;
      if (duree == null) return null;
      total += duree;
    }
    return total;
  }
}
